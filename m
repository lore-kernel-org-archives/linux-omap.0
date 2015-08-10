From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] tty: serial: 8250_omap: do not use RX DMA if pause is
 not supported
Date: Mon, 10 Aug 2015 14:54:10 +0300
Message-ID: <55C890E2.50208@ti.com>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
 <1438977619-15488-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438977619-15488-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vinod Koul <vinod.koul@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, peter@hurleysoftware.com
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de
List-Id: linux-omap@vger.kernel.org

On 08/07/2015 11:00 PM, Sebastian Andrzej Siewior wrote:
> The 8250-omap driver requires the DMA-engine driver to support the pa=
use
> command in order to properly turn off programmed RX transfer before t=
he
> driver stars manually reading from the FIFO.
> The lacking support of the requirement has been discovered recently. =
In
> order to stay safe here we disable support for RX-DMA as soon as we
> notice that it does not work. This should happen very early.
> If the user does not want to see this backtrace he can either disable
> DMA support (completely or RX-only) or backport the required patches =
for
> edma / omap-dma once they hit mainline.
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial=
/8250/8250_omap.c
> index 0340ee6ba970..07a11e0935e4 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -112,6 +112,7 @@ struct omap8250_priv {
>  	struct work_struct qos_work;
>  	struct uart_8250_dma omap8250_dma;
>  	spinlock_t rx_dma_lock;
> +	bool rx_dma_broken;
>  };
> =20
>  static u32 uart_read(struct uart_8250_port *up, u32 reg)
> @@ -761,6 +762,7 @@ static void omap_8250_rx_dma_flush(struct uart_82=
50_port *p)
>  	struct omap8250_priv	*priv =3D p->port.private_data;
>  	struct uart_8250_dma	*dma =3D p->dma;
>  	unsigned long		flags;
> +	int ret;
> =20
>  	spin_lock_irqsave(&priv->rx_dma_lock, flags);
> =20
> @@ -769,7 +771,9 @@ static void omap_8250_rx_dma_flush(struct uart_82=
50_port *p)
>  		return;
>  	}
> =20
> -	dmaengine_pause(dma->rxchan);
> +	ret =3D dmaengine_pause(dma->rxchan);
> +	if (WARN_ON_ONCE(ret))
> +		priv->rx_dma_broken =3D true;

I don't think this is good thing for the stable _and_ for the mainline =
at the
same time:
in stable the rx DMA should not be allowed since the stable kernels doe=
s not
allow pause/resume with omap-dma, so there the rx DMA should be just di=
sabled
for UART. This change will cause regression since it introduce a WARN_O=
N_ONCE,
which will be printed if the user tries to use non working feature.

In mainline you will eventually going to have pause/resume support so t=
his
patch will make no sense there.

> =20
>  	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
> =20
> @@ -813,6 +817,9 @@ static int omap_8250_rx_dma(struct uart_8250_port=
 *p, unsigned int iir)
>  		break;
>  	}
> =20
> +	if (priv->rx_dma_broken)
> +		return -EINVAL;
> +
>  	spin_lock_irqsave(&priv->rx_dma_lock, flags);
> =20
>  	if (dma->rx_running)
>=20


--=20
P=E9ter
