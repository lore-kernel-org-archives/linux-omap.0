From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/3] tty: serial: OMAP: block idle while the UART is
 transferring data in PIO mode
Date: Fri, 27 Jan 2012 12:53:04 +0530
Message-ID: <CAAL8m4yOJ3Kqam7X_-q+UWS=OKM6rOi8KQHRFqv1V=_qjSfWxw@mail.gmail.com>
References: <20120126024903.31613.24730.stgit@dusk> <20120126025036.31613.67819.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48984 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751257Ab2A0HX0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jan 2012 02:23:26 -0500
In-Reply-To: <20120126025036.31613.67819.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, govindraj.r@ti.com, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Thu, Jan 26, 2012 at 8:20 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Prevent OMAP UARTs from going idle while they are still transferring
> data in PIO mode. =A0This works around an oversight in the OMAP UART
> hardware present in OMAP34xx and earlier: an idle UART won't send a
> wakeup when the TX FIFO threshold is reached. =A0This causes long del=
ays
> during data transmission when the MPU powerdomain enters a low-power
> mode. =A0The MPU interrupt controller is not able to respond to
> interrupts when it's in a low-power state, so the TX buffer is not
> refilled until another wakeup event occurs.
>
> This fix changes the erratum i291 DMA idle workaround. =A0Rather than
> toggling between force-idle and no-idle, it will toggle between
> smart-idle and no-idle. =A0The important part of the workaround is th=
e
> no-idle part, so this shouldn't result in any change in behavior.
>
> This fix should work on all OMAP UARTs. =A0Future patches intended fo=
r
> the 3.4 merge window will make this workaround conditional on a
> "feature" flag, and will use the OMAP36xx+ TX event wakeup support.
>
> Thanks to Kevin Hilman <khilman@ti.com> for mentioning the erratum i2=
91
> workaround, which led to the development of this approach.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Govindraj.R <govindraj.raja@ti.com>

> ---
> =A0arch/arm/mach-omap2/serial.c =A0 =A0 | =A0 =A08 ++++----
> =A0drivers/tty/serial/omap-serial.c | =A0 =A07 +++++++
> =A02 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seria=
l.c
> index 247d894..f590afc 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -107,18 +107,18 @@ static void omap_uart_set_noidle(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDL=
EMODE_NO);
> =A0}
>
> -static void omap_uart_set_forceidle(struct platform_device *pdev)
> +static void omap_uart_set_smartidle(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct omap_device *od =3D to_omap_device(pdev);
>
> - =A0 =A0 =A0 omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLE=
MODE_FORCE);
> + =A0 =A0 =A0 omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLE=
MODE_SMART);
> =A0}
>
> =A0#else
> =A0static void omap_uart_enable_wakeup(struct platform_device *pdev, =
bool enable)
> =A0{}
> =A0static void omap_uart_set_noidle(struct platform_device *pdev) {}
> -static void omap_uart_set_forceidle(struct platform_device *pdev) {}
> +static void omap_uart_set_smartidle(struct platform_device *pdev) {}
> =A0#endif /* CONFIG_PM */
>
> =A0#ifdef CONFIG_OMAP_MUX
> @@ -349,7 +349,7 @@ void __init omap_serial_init_port(struct omap_boa=
rd_data *bdata,
> =A0 =A0 =A0 =A0omap_up.uartclk =3D OMAP24XX_BASE_BAUD * 16;
> =A0 =A0 =A0 =A0omap_up.flags =3D UPF_BOOT_AUTOCONF;
> =A0 =A0 =A0 =A0omap_up.get_context_loss_count =3D omap_pm_get_dev_con=
text_loss_count;
> - =A0 =A0 =A0 omap_up.set_forceidle =3D omap_uart_set_forceidle;
> + =A0 =A0 =A0 omap_up.set_forceidle =3D omap_uart_set_smartidle;
> =A0 =A0 =A0 =A0omap_up.set_noidle =3D omap_uart_set_noidle;
> =A0 =A0 =A0 =A0omap_up.enable_wakeup =3D omap_uart_enable_wakeup;
> =A0 =A0 =A0 =A0omap_up.dma_rx_buf_size =3D info->dma_rx_buf_size;
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index c9c9ba2..11fa156 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -136,6 +136,7 @@ static void serial_omap_enable_ms(struct uart_por=
t *port)
> =A0static void serial_omap_stop_tx(struct uart_port *port)
> =A0{
> =A0 =A0 =A0 =A0struct uart_omap_port *up =3D (struct uart_omap_port *=
)port;
> + =A0 =A0 =A0 struct omap_uart_port_info *pdata =3D up->pdev->dev.pla=
tform_data;
>
> =A0 =A0 =A0 =A0if (up->use_dma &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->uart_dma.tx_dma_channel !=3D OMAP_=
UART_DMA_CH_FREE) {
> @@ -158,6 +159,9 @@ static void serial_omap_stop_tx(struct uart_port =
*port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_out(up, UART_IER, up->ier);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (!up->use_dma && pdata->set_forceidle)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->set_forceidle(up->pdev);
> +
> =A0 =A0 =A0 =A0pm_runtime_mark_last_busy(&up->pdev->dev);
> =A0 =A0 =A0 =A0pm_runtime_put_autosuspend(&up->pdev->dev);
> =A0}
> @@ -286,6 +290,7 @@ static inline void serial_omap_enable_ier_thri(st=
ruct uart_omap_port *up)
> =A0static void serial_omap_start_tx(struct uart_port *port)
> =A0{
> =A0 =A0 =A0 =A0struct uart_omap_port *up =3D (struct uart_omap_port *=
)port;
> + =A0 =A0 =A0 struct omap_uart_port_info *pdata =3D up->pdev->dev.pla=
tform_data;
> =A0 =A0 =A0 =A0struct circ_buf *xmit;
> =A0 =A0 =A0 =A0unsigned int start;
> =A0 =A0 =A0 =A0int ret =3D 0;
> @@ -293,6 +298,8 @@ static void serial_omap_start_tx(struct uart_port=
 *port)
> =A0 =A0 =A0 =A0if (!up->use_dma) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_omap_enable_ier_thri(up);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->set_noidle)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->set_noidle(up->p=
dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_mark_last_busy(&up->pdev->d=
ev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_put_autosuspend(&up->pdev->=
dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
