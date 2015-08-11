From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 3/3] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Tue, 11 Aug 2015 15:02:44 +0300
Message-ID: <55C9E464.2060404@ti.com>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
 <1438977619-15488-4-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438977619-15488-4-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vinod Koul <vinod.koul@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, peter@hurleysoftware.com
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de
List-Id: linux-omap@vger.kernel.org

On 08/07/2015 11:00 PM, Sebastian Andrzej Siewior wrote:
> -static void omap_dma_stop(struct omap_chan *c)
> +static void omap_dma_drain_chan(struct omap_chan *c)
> +{
> +	int i;
> +	uint32_t val;
> +
> +	/* Wait for sDMA FIFO to drain */
> +	for (i =3D 0; ; i++) {
> +		val =3D omap_dma_chan_read(c, CCR);
> +		if (!(val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE)))
> +			break;
> +
> +		if (i > 100)
> +			break;
> +
> +		udelay(5);
> +	}
> +
> +	if (val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE))
> +		dev_err(c->vc.chan.device->dev,
> +			"DMA drain did not complete on lch %d\n",
> +			c->dma_ch);
> +}
> +
> +static int omap_dma_stop(struct omap_chan *c)
>  {
>  	struct omap_dmadev *od =3D to_omap_dma_dev(c->vc.chan.device);
>  	uint32_t val;
> @@ -312,7 +335,6 @@ static void omap_dma_stop(struct omap_chan *c)
>  	val =3D omap_dma_chan_read(c, CCR);
>  	if (od->plat->errata & DMA_ERRATA_i541 && val & CCR_TRIGGER_SRC) {
>  		uint32_t sysconfig;
> -		unsigned i;
> =20
>  		sysconfig =3D omap_dma_glbl_read(od, OCP_SYSCONFIG);
>  		val =3D sysconfig & ~DMA_SYSCONFIG_MIDLEMODE_MASK;
> @@ -323,27 +345,18 @@ static void omap_dma_stop(struct omap_chan *c)
>  		val &=3D ~CCR_ENABLE;
>  		omap_dma_chan_write(c, CCR, val);
> =20
> -		/* Wait for sDMA FIFO to drain */
> -		for (i =3D 0; ; i++) {
> -			val =3D omap_dma_chan_read(c, CCR);
> -			if (!(val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE)))
> -				break;
> -
> -			if (i > 100)
> -				break;
> -
> -			udelay(5);
> -		}
> -
> -		if (val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE))
> -			dev_err(c->vc.chan.device->dev,
> -				"DMA drain did not complete on lch %d\n",
> -			        c->dma_ch);
> +		omap_dma_drain_chan(c);
> =20
>  		omap_dma_glbl_write(od, OCP_SYSCONFIG, sysconfig);
>  	} else {
> +
> +		if (!(val & CCR_ENABLE))
> +			return -EINVAL;
> +
>  		val &=3D ~CCR_ENABLE;
>  		omap_dma_chan_write(c, CCR, val);
> +
> +		omap_dma_drain_chan(c);

Note that the FIFO drain only applies to source synchronized transfers.=
=2E. When
the BUFFERING is _not_ disabled - in most of the cases this is true.

> +	/*
> +	 * We do not allow DMA_MEM_TO_DEV transfers to be paused.
> +	 * From the AM572x TRM, 16.1.4.18 Disabling a Channel During Transf=
er:
> +	 * "When a channel is disabled during a transfer, the channel under=
goes
> +	 * an abort, unless it is hardware-source-synchronized =E2=80=A6".
> +	 * A source-synchronised channel is one where the fetching of data =
is
> +	 * under control of the device. In other words, a device-to-memory
> +	 * transfer. So, a destination-synchronised channel (which would be=
 a
> +	 * memory-to-device transfer) undergoes an abort if the the CCR_ENA=
BLE
> +	 * bit is cleared.
> +	 * From 16.1.4.20.4.6.2 Abort: "If an abort trigger occurs, the cha=
nnel
> +	 * aborts immediately after completion of current read/write
> +	 * transactions and then the FIFO is cleaned up." The term "cleaned=
 up"
> +	 * is not defined. TI recommends to check that RD_ACTIVE and WR_ACT=
IVE
> +	 * are both clear _before_ disabling the channel, otherwise data lo=
ss
> +	 * will occur.
> +	 * The problem is that if the channel is active, then device activi=
ty
> +	 * can result in DMA activity starting between reading those as bot=
h
> +	 * clear and the write to DMA_CCR to clear the enable bit hitting t=
he
> +	 * hardware. If the DMA hardware can't drain the data in its FIFO t=
o the
> +	 * destination, then data loss "might" occur (say if we write to an=
 UART
> +	 * and the UART is not accepting any further data).

I don't know if you have checked it, but probably the TX DMA could be a=
lso
used when the PRZEFETCH is disabled for the channel? Just a guess

> +	 */
> +	else if (c->desc->dir =3D=3D DMA_DEV_TO_MEM)
> +		can_pause =3D true;
> +
> +	if (can_pause && !c->paused) {
> +		ret =3D omap_dma_stop(c);
> +		if (!ret)
> +			c->paused =3D true;
>  	}
> +out:
> +	spin_unlock_irqrestore(&od->irq_lock, flags);
> =20
> -	return 0;
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
> @@ -1082,9 +1134,11 @@ static int omap_dma_resume(struct dma_chan *ch=
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
P=C3=A9ter
