From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Fri, 7 Aug 2015 12:44:01 +0300
Message-ID: <55C47DE1.9020902@ti.com>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On 08/07/2015 11:41 AM, Sebastian Andrzej Siewior wrote:
> This DMA driver is used by 8250-omap on DRA7-evm. There is one
> requirement that is to pause a transfer. This is currently used on th=
e RX
> side. It is possible that the UART HW aborted the RX (UART's RX-timeo=
ut)
> but the DMA controller starts the transfer shortly after.
> Before we can manually purge the FIFO we need to pause the transfer,
> check how many bytes it already received and terminate the transfer
> without it making any progress.
>=20
> From testing on the TX side it seems that it is possible that we invo=
ke
> pause once the transfer has completed which is indicated by the missi=
ng
> CCR_ENABLE bit but before the interrupt has been noticed. In that cas=
e the
> interrupt will come even after disabling it.
>=20
> The AM572x manual says that we have to wait for the CCR_RD_ACTIVE &
> CCR_WR_ACTIVE bits to be gone before programming it again here is the
> drain loop. Also it looks like without the drain the TX-transfer make=
s
> sometimes progress.
>=20
> One note: The pause + resume combo is broken because after resume the
> the complete transfer will be programmed again. That means the alread=
y
> transferred bytes (until the pause event) will be sent again. This is
> currently not important for my UART user because it does only pause +
> terminate.

with a short testing audio did not broke (the only user of pause/resume=
)
Some comments embedded.

> Cc: <stable@vger.kernel.org>

Why stable? This is not fixing any bugs since the PAUSE was not allowed=
 for
non cyclic transfers.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/dma/omap-dma.c | 54 ++++++++++++++++++++++++++++++++++++++--=
----------
>  1 file changed, 41 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index 249445c8a4c6..6b8497203caf 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -299,7 +299,7 @@ static void omap_dma_start(struct omap_chan *c, s=
truct omap_desc *d)
>  	omap_dma_chan_write(c, CCR, d->ccr | CCR_ENABLE);
>  }
> =20
> -static void omap_dma_stop(struct omap_chan *c)
> +static int omap_dma_stop(struct omap_chan *c)
>  {
>  	struct omap_dmadev *od =3D to_omap_dma_dev(c->vc.chan.device);
>  	uint32_t val;
> @@ -342,8 +342,26 @@ static void omap_dma_stop(struct omap_chan *c)
> =20
>  		omap_dma_glbl_write(od, OCP_SYSCONFIG, sysconfig);
>  	} else {
> +		int i =3D 0;
> +
> +		if (!(val & CCR_ENABLE))
> +			return -EINVAL;
> +
>  		val &=3D ~CCR_ENABLE;
>  		omap_dma_chan_write(c, CCR, val);
> +		do {
> +			val =3D omap_dma_chan_read(c, CCR);
> +			if (!(val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE)))
> +				break;
> +			if (i > 100)

if (++i > 100)
	break;
to avoid infinite loop?


> +				break;
> +			udelay(5);
> +		} while (1);
> +
> +		if (val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE))

if (i > 100) ?



> +			dev_err(c->vc.chan.device->dev,
> +				"DMA drain did not complete on lch %d\n",
> +				c->dma_ch);
>  	}
> =20
>  	mb();
> @@ -358,6 +376,7 @@ static void omap_dma_stop(struct omap_chan *c)
> =20
>  		omap_dma_chan_write(c, CLNK_CTRL, val);
>  	}
> +	return 0;
>  }
> =20
>  static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc =
*d,
> @@ -728,6 +747,8 @@ static enum dma_status omap_dma_tx_status(struct =
dma_chan *chan,
>  	} else {
>  		txstate->residue =3D 0;
>  	}
> +	if (ret =3D=3D DMA_IN_PROGRESS && c->paused)
> +		ret =3D DMA_PAUSED;
>  	spin_unlock_irqrestore(&c->vc.lock, flags);
> =20
>  	return ret;
> @@ -1053,28 +1074,33 @@ static int omap_dma_terminate_all(struct dma_=
chan *chan)
>  static int omap_dma_pause(struct dma_chan *chan)
>  {
>  	struct omap_chan *c =3D to_omap_dma_chan(chan);
> +	struct omap_dmadev *od =3D to_omap_dma_dev(chan->device);
> +	unsigned long flags;
> +	int ret =3D -EINVAL;
> =20
> -	/* Pause/Resume only allowed with cyclic mode */
> -	if (!c->cyclic)
> -		return -EINVAL;
> +	spin_lock_irqsave(&od->irq_lock, flags);
> =20
> -	if (!c->paused) {
> -		omap_dma_stop(c);
> -		c->paused =3D true;
> +	if (!c->paused && c->desc) {
> +		ret =3D omap_dma_stop(c);
> +		if (!ret)
> +			c->paused =3D true;
>  	}
> =20
> -	return 0;
> +	spin_unlock_irqrestore(&od->irq_lock, flags);
> +
> +	return ret;
>  }
> =20
>  static int omap_dma_resume(struct dma_chan *chan)
>  {
>  	struct omap_chan *c =3D to_omap_dma_chan(chan);
> +	struct omap_dmadev *od =3D to_omap_dma_dev(chan->device);
> +	unsigned long flags;
> +	int ret =3D -EINVAL;
> =20
> -	/* Pause/Resume only allowed with cyclic mode */
> -	if (!c->cyclic)
> -		return -EINVAL;
> +	spin_lock_irqsave(&od->irq_lock, flags);
> =20
> -	if (c->paused) {
> +	if (c->paused && c->desc) {
>  		mb();
> =20
>  		/* Restore channel link register */
> @@ -1082,9 +1108,11 @@ static int omap_dma_resume(struct dma_chan *ch=
an)
> =20
>  		omap_dma_start(c, c->desc);
>  		c->paused =3D false;
> +		ret =3D 0;
>  	}
> +	spin_unlock_irqrestore(&od->irq_lock, flags);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static int omap_dma_chan_init(struct omap_dmadev *od)
>=20


--=20
P=E9ter
