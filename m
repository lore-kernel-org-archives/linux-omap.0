From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH v5 09/15] OMAP2+: UART: Add runtime pm support for
 omap-serial driver
Date: Thu, 22 Sep 2011 15:48:51 +0800
Message-ID: <CACVXFVMpvF5foA1asLYE5WbvHQ3b_eXaBpiMT7Q1h0KHDGLSCg@mail.gmail.com>
References: <1316607206-21669-1-git-send-email-govindraj.raja@ti.com>
	<1316607206-21669-7-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1316607206-21669-7-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 21, 2011 at 8:13 PM, Govindraj.R <govindraj.raja@ti.com> wr=
ote:
> Adapts omap-serial driver to use pm_runtime API's.

> =A0 =A0 =A0 =A0console_unlock();
>
> - =A0 =A0 =A0 if ((cpu_is_omap34xx() && bdata->pads) ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata->wk_en && pdata->wk_mask))
> + =A0 =A0 =A0 if ((cpu_is_omap34xx() && bdata->pads))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_init_wakeup(&pdev->dev, true);

Just a bit curious, why doesn't the code enable wakeup at default
on omap4, which will disable runtime pm of serial port on omap4.

I have tested your patches on omap4 panda(enable wakeup at
default manually), runtime pm of serial port 2 can work well and
remote wakeup too.

>
> =A0 =A0 =A0 =A0kfree(pdata);
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm=
/plat-omap/include/plat/omap-serial.h
> index 74822b3..8ef81ce 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -62,6 +62,9 @@ struct omap_uart_port_info {
> =A0 =A0 =A0 =A0upf_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags; =A0 =A0=
 =A0 =A0 =A0/* UPF_* flags */
>
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errata;
> +
> + =A0 =A0 =A0 void (*enable_wakeup)(struct platform_device *, bool);
> + =A0 =A0 =A0 u32 (*get_context_loss_count)(struct device *);
> =A0};
>
> =A0struct uart_omap_dma {
> @@ -113,6 +116,8 @@ struct uart_omap_port {
> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 msr_saved_flags;
> =A0 =A0 =A0 =A0char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name[20];
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 port_activity;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_los=
s_cnt;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wakeups_e=
nabled;
> =A0};
>
> =A0#endif /* __OMAP_SERIAL_H__ */
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index 9a0eac2..43c33da 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -37,11 +37,14 @@
> =A0#include <linux/clk.h>
> =A0#include <linux/serial_core.h>
> =A0#include <linux/irq.h>
> +#include <linux/pm_runtime.h>
>
> =A0#include <plat/dma.h>
> =A0#include <plat/dmtimer.h>
> =A0#include <plat/omap-serial.h>
>
> +#define OMAP_UART_AUTOSUSPEND_DELAY -1
> +
> =A0static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>
> =A0/* Forward declaration of functions */
> @@ -102,6 +105,8 @@ static void serial_omap_stop_rxdma(struct uart_om=
ap_port *up)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_free_dma(up->uart_dma.rx_dma_chan=
nel);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->uart_dma.rx_dma_channel =3D OMAP_U=
ART_DMA_CH_FREE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->uart_dma.rx_dma_used =3D false;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->de=
v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->d=
ev);
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -110,8 +115,11 @@ static void serial_omap_enable_ms(struct uart_po=
rt *port)
> =A0 =A0 =A0 =A0struct uart_omap_port *up =3D (struct uart_omap_port *=
)port;
>
> =A0 =A0 =A0 =A0dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up=
->pdev->id);
> +
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0up->ier |=3D UART_IER_MSI;
> =A0 =A0 =A0 =A0serial_out(up, UART_IER, up->ier);
> + =A0 =A0 =A0 pm_runtime_put(&up->pdev->dev);
> =A0}
>
> =A0static void serial_omap_stop_tx(struct uart_port *port)
> @@ -129,23 +137,32 @@ static void serial_omap_stop_tx(struct uart_por=
t *port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_stop_dma(up->uart_dma.tx_dma_chan=
nel);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_free_dma(up->uart_dma.tx_dma_chan=
nel);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->uart_dma.tx_dma_channel =3D OMAP_U=
ART_DMA_CH_FREE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->de=
v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->d=
ev);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0if (up->ier & UART_IER_THRI) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->ier &=3D ~UART_IER_THRI;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_out(up, UART_IER, up->ier);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->dev);
> + =A0 =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->dev);
> =A0}
>
> =A0static void serial_omap_stop_rx(struct uart_port *port)
> =A0{
> =A0 =A0 =A0 =A0struct uart_omap_port *up =3D (struct uart_omap_port *=
)port;
>
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0if (up->use_dma)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_omap_stop_rxdma(up);
> =A0 =A0 =A0 =A0up->ier &=3D ~UART_IER_RLSI;
> =A0 =A0 =A0 =A0up->port.read_status_mask &=3D ~UART_LSR_DR;
> =A0 =A0 =A0 =A0serial_out(up, UART_IER, up->ier);
> + =A0 =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->dev);
> + =A0 =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->dev);
> =A0}
>
> =A0static inline void receive_chars(struct uart_omap_port *up, int *s=
tatus)
> @@ -262,7 +279,10 @@ static void serial_omap_start_tx(struct uart_por=
t *port)
> =A0 =A0 =A0 =A0int ret =3D 0;
>
> =A0 =A0 =A0 =A0if (!up->use_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_omap_enable_ier_thri(up);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->de=
v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->d=
ev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> @@ -272,6 +292,7 @@ static void serial_omap_start_tx(struct uart_port=
 *port)
> =A0 =A0 =A0 =A0xmit =3D &up->port.state->xmit;
>
> =A0 =A0 =A0 =A0if (up->uart_dma.tx_dma_channel =3D=3D OMAP_UART_DMA_C=
H_FREE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D omap_request_dma(up->uart_dma.=
uart_dma_tx,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"UART =
Tx DMA",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(void =
*)uart_tx_dma_callback, up,
> @@ -354,9 +375,13 @@ static inline irqreturn_t serial_omap_irq(int ir=
q, void *dev_id)
> =A0 =A0 =A0 =A0unsigned int iir, lsr;
> =A0 =A0 =A0 =A0unsigned long flags;
>
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0iir =3D serial_in(up, UART_IIR);
> - =A0 =A0 =A0 if (iir & UART_IIR_NO_INT)
> + =A0 =A0 =A0 if (iir & UART_IIR_NO_INT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->de=
v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->d=
ev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_NONE;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&up->port.lock, flags);
> =A0 =A0 =A0 =A0lsr =3D serial_in(up, UART_LSR);
> @@ -378,6 +403,9 @@ static inline irqreturn_t serial_omap_irq(int irq=
, void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0transmit_chars(up);
>
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&up->port.lock, flags);
> + =A0 =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->dev);
> + =A0 =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->dev);
> +
> =A0 =A0 =A0 =A0up->port_activity =3D jiffies;
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
> @@ -388,11 +416,12 @@ static unsigned int serial_omap_tx_empty(struct=
 uart_port *port)
> =A0 =A0 =A0 =A0unsigned long flags =3D 0;
> =A0 =A0 =A0 =A0unsigned int ret =3D 0;
>
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up-=
>pdev->id);
> =A0 =A0 =A0 =A0spin_lock_irqsave(&up->port.lock, flags);
> =A0 =A0 =A0 =A0ret =3D serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOC=
SER_TEMT : 0;
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&up->port.lock, flags);
> -
> + =A0 =A0 =A0 pm_runtime_put(&up->pdev->dev);
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> @@ -402,7 +431,10 @@ static unsigned int serial_omap_get_mctrl(struct=
 uart_port *port)
> =A0 =A0 =A0 =A0unsigned char status;
> =A0 =A0 =A0 =A0unsigned int ret =3D 0;
>
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0status =3D check_modem_status(up);
> + =A0 =A0 =A0 pm_runtime_put(&up->pdev->dev);
> +
> =A0 =A0 =A0 =A0dev_dbg(up->port.dev, "serial_omap_get_mctrl+%d\n", up=
->pdev->id);
>
> =A0 =A0 =A0 =A0if (status & UART_MSR_DCD)
> @@ -433,9 +465,11 @@ static void serial_omap_set_mctrl(struct uart_po=
rt *port, unsigned int mctrl)
> =A0 =A0 =A0 =A0if (mctrl & TIOCM_LOOP)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcr |=3D UART_MCR_LOOP;
>
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0up->mcr =3D serial_in(up, UART_MCR);
> =A0 =A0 =A0 =A0up->mcr |=3D mcr;
> =A0 =A0 =A0 =A0serial_out(up, UART_MCR, up->mcr);
> + =A0 =A0 =A0 pm_runtime_put(&up->pdev->dev);
> =A0}
>
> =A0static void serial_omap_break_ctl(struct uart_port *port, int brea=
k_state)
> @@ -444,6 +478,7 @@ static void serial_omap_break_ctl(struct uart_por=
t *port, int break_state)
> =A0 =A0 =A0 =A0unsigned long flags =3D 0;
>
> =A0 =A0 =A0 =A0dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up=
->pdev->id);
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0spin_lock_irqsave(&up->port.lock, flags);
> =A0 =A0 =A0 =A0if (break_state =3D=3D -1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->lcr |=3D UART_LCR_SBC;
> @@ -451,6 +486,7 @@ static void serial_omap_break_ctl(struct uart_por=
t *port, int break_state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->lcr &=3D ~UART_LCR_SBC;
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, up->lcr);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&up->port.lock, flags);
> + =A0 =A0 =A0 pm_runtime_put(&up->pdev->dev);
> =A0}
>
> =A0static int serial_omap_startup(struct uart_port *port)
> @@ -469,6 +505,7 @@ static int serial_omap_startup(struct uart_port *=
port)
>
> =A0 =A0 =A0 =A0dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->=
pdev->id);
>
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Clear the FIFO buffers and disable them.
> =A0 =A0 =A0 =A0 * (they will be reenabled in set_termios())
> @@ -524,6 +561,8 @@ static int serial_omap_startup(struct uart_port *=
port)
> =A0 =A0 =A0 =A0/* Enable module level wake up */
> =A0 =A0 =A0 =A0serial_out(up, UART_OMAP_WER, OMAP_UART_WER_MOD_WKUP);
>
> + =A0 =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->dev);
> + =A0 =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->dev);
> =A0 =A0 =A0 =A0up->port_activity =3D jiffies;
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -534,6 +573,8 @@ static void serial_omap_shutdown(struct uart_port=
 *port)
> =A0 =A0 =A0 =A0unsigned long flags =3D 0;
>
> =A0 =A0 =A0 =A0dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up-=
>pdev->id);
> +
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Disable interrupts from this port
> =A0 =A0 =A0 =A0 */
> @@ -567,6 +608,7 @@ static void serial_omap_shutdown(struct uart_port=
 *port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->uart_dma.rx_buf_dm=
a_phys);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->uart_dma.rx_buf =3D NULL;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 pm_runtime_put(&up->pdev->dev);
> =A0 =A0 =A0 =A0free_irq(up->port.irq, up);
> =A0}
>
> @@ -682,6 +724,7 @@ serial_omap_set_termios(struct uart_port *port, s=
truct ktermios *termios,
> =A0 =A0 =A0 =A0 * Ok, we're now changing the port state. Do it with
> =A0 =A0 =A0 =A0 * interrupts disabled.
> =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0spin_lock_irqsave(&up->port.lock, flags);
>
> =A0 =A0 =A0 =A0/*
> @@ -814,6 +857,7 @@ serial_omap_set_termios(struct uart_port *port, s=
truct ktermios *termios,
> =A0 =A0 =A0 =A0serial_omap_configure_xonxoff(up, termios);
>
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&up->port.lock, flags);
> + =A0 =A0 =A0 pm_runtime_put(&up->pdev->dev);
> =A0 =A0 =A0 =A0dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", =
up->pdev->id);
> =A0}
>
> @@ -825,6 +869,8 @@ serial_omap_pm(struct uart_port *port, unsigned i=
nt state,
> =A0 =A0 =A0 =A0unsigned char efr;
>
> =A0 =A0 =A0 =A0dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->pdev-=
>id);
> +
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0efr =3D serial_in(up, UART_EFR);
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, efr | UART_EFR_ECB);
> @@ -834,6 +880,7 @@ serial_omap_pm(struct uart_port *port, unsigned i=
nt state,
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, efr);
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, 0);
> + =A0 =A0 =A0 pm_runtime_put(&up->pdev->dev);
> =A0}
>
> =A0static void serial_omap_release_port(struct uart_port *port)
> @@ -911,19 +958,26 @@ static inline void wait_for_xmitr(struct uart_o=
map_port *up)
> =A0static void serial_omap_poll_put_char(struct uart_port *port, unsi=
gned char ch)
> =A0{
> =A0 =A0 =A0 =A0struct uart_omap_port *up =3D (struct uart_omap_port *=
)port;
> +
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0wait_for_xmitr(up);
> =A0 =A0 =A0 =A0serial_out(up, UART_TX, ch);
> + =A0 =A0 =A0 pm_runtime_put(&up->pdev->dev);
> =A0}
>
> =A0static int serial_omap_poll_get_char(struct uart_port *port)
> =A0{
> =A0 =A0 =A0 =A0struct uart_omap_port *up =3D (struct uart_omap_port *=
)port;
> - =A0 =A0 =A0 unsigned int status =3D serial_in(up, UART_LSR);
> + =A0 =A0 =A0 unsigned int status;
>
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> + =A0 =A0 =A0 status =3D serial_in(up, UART_LSR);
> =A0 =A0 =A0 =A0if (!(status & UART_LSR_DR))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NO_POLL_CHAR;
>
> - =A0 =A0 =A0 return serial_in(up, UART_RX);
> + =A0 =A0 =A0 status =3D serial_in(up, UART_RX);
> + =A0 =A0 =A0 pm_runtime_put(&up->pdev->dev);
> + =A0 =A0 =A0 return status;
> =A0}
>
> =A0#endif /* CONFIG_CONSOLE_POLL */
> @@ -951,6 +1005,8 @@ serial_omap_console_write(struct console *co, co=
nst char *s,
> =A0 =A0 =A0 =A0unsigned int ier;
> =A0 =A0 =A0 =A0int locked =3D 1;
>
> + =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> +
> =A0 =A0 =A0 =A0local_irq_save(flags);
> =A0 =A0 =A0 =A0if (up->port.sysrq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0locked =3D 0;
> @@ -983,6 +1039,8 @@ serial_omap_console_write(struct console *co, co=
nst char *s,
> =A0 =A0 =A0 =A0if (up->msr_saved_flags)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_modem_status(up);
>
> + =A0 =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->dev);
> + =A0 =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->dev);
> =A0 =A0 =A0 =A0if (locked)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&up->port.lock);
> =A0 =A0 =A0 =A0local_irq_restore(flags);
> @@ -1065,19 +1123,18 @@ static struct uart_driver serial_omap_reg =3D=
 {
> =A0 =A0 =A0 =A0.cons =A0 =A0 =A0 =A0 =A0 =3D OMAP_CONSOLE,
> =A0};
>
> -static int
> -serial_omap_suspend(struct platform_device *pdev, pm_message_t state=
)
> +static int serial_omap_suspend(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(pdev=
);
> + =A0 =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>
> =A0 =A0 =A0 =A0if (up)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_suspend_port(&serial_omap_reg, &u=
p->port);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int serial_omap_resume(struct platform_device *dev)
> +static int serial_omap_resume(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(dev)=
;
> + =A0 =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>
> =A0 =A0 =A0 =A0if (up)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_resume_port(&serial_omap_reg, &up=
->port);
> @@ -1140,6 +1197,7 @@ static int serial_omap_start_rxdma(struct uart_=
omap_port *up)
> =A0 =A0 =A0 =A0int ret =3D 0;
>
> =A0 =A0 =A0 =A0if (up->uart_dma.rx_dma_channel =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D omap_request_dma(up->uart_dma.=
uart_dma_rx,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"UART =
Rx DMA",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(void =
*)uart_rx_dma_callback, up,
> @@ -1305,6 +1363,16 @@ static int serial_omap_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->uart_dma.rx_dma_channel =3D OMAP_U=
ART_DMA_CH_FREE;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 pm_runtime_use_autosuspend(&pdev->dev);
> + =A0 =A0 =A0 pm_runtime_set_autosuspend_delay(&pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_UART_AUTOSUSPEND_D=
ELAY);
> +
> + =A0 =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
> + =A0 =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&pdev->dev);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0ui[pdev->id] =3D up;
> =A0 =A0 =A0 =A0serial_omap_add_console_port(up);
>
> @@ -1312,6 +1380,7 @@ static int serial_omap_probe(struct platform_de=
vice *pdev)
> =A0 =A0 =A0 =A0if (ret !=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto do_release_region;
>
> + =A0 =A0 =A0 pm_runtime_put(&pdev->dev);
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, up);
> =A0 =A0 =A0 =A0return 0;
> =A0err:
> @@ -1326,22 +1395,96 @@ static int serial_omap_remove(struct platform=
_device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct uart_omap_port *up =3D platform_get_drvdata(dev=
);
>
> - =A0 =A0 =A0 platform_set_drvdata(dev, NULL);
> =A0 =A0 =A0 =A0if (up) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_disable(&up->pdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_remove_one_port(&serial_omap_reg,=
 &up->port);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(up);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 platform_set_drvdata(dev, NULL);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void serial_omap_restore_context(struct uart_omap_port *up)
> +{
> + =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, up->mdr1);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Conf=
ig B mode */
> + =A0 =A0 =A0 serial_out(up, UART_EFR, UART_EFR_ECB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, 0x0); /* Operational mode */
> + =A0 =A0 =A0 serial_out(up, UART_IER, 0x0);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Conf=
ig B mode */
> + =A0 =A0 =A0 serial_out(up, UART_DLL, up->dll);
> + =A0 =A0 =A0 serial_out(up, UART_DLM, up->dlh);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, 0x0); /* Operational mode */
> + =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
> + =A0 =A0 =A0 serial_out(up, UART_FCR, up->fcr);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
> + =A0 =A0 =A0 serial_out(up, UART_MCR, up->mcr);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Conf=
ig B mode */
> + =A0 =A0 =A0 serial_out(up, UART_EFR, up->efr);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, up->lcr);
> + =A0 =A0 =A0 /* UART 16x mode */
> + =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, up->mdr1);
> +}
> +
> +static int serial_omap_runtime_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct omap_uart_port_info *pdata =3D dev->platform_dat=
a;
> +
> + =A0 =A0 =A0 if (!up)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (!pdata->enable_wakeup || !pdata->get_context_loss_c=
ount)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (pdata->get_context_loss_count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->context_loss_cnt =3D pdata->get_con=
text_loss_count(dev);
> +
> + =A0 =A0 =A0 if (device_may_wakeup(dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!up->wakeups_enabled) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->enable_wakeup(up=
->pdev, true);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->wakeups_enabled =3D=
 true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (up->wakeups_enabled) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->enable_wakeup(up=
->pdev, false);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->wakeups_enabled =3D=
 false;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int serial_omap_runtime_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct omap_uart_port_info *pdata =3D dev->platform_dat=
a;
> +
> + =A0 =A0 =A0 if (up) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->get_context_loss_count) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 loss_cnt =3D pdata-=
>get_context_loss_count(dev);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (up->context_loss_cn=
t !=3D loss_cnt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_=
omap_restore_context(up);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static const struct dev_pm_ops serial_omap_dev_pm_ops =3D {
> + =A0 =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_oma=
p_resume)
> + =A0 =A0 =A0 SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_=
omap_runtime_resume, NULL)
> +};
> +
> =A0static struct platform_driver serial_omap_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D serial_omap_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D serial_omap_remove,
> -
> - =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D serial_omap_suspend,
> - =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D serial_omap_resume,
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D DRIVER_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &serial_omap_dev_pm_ops=
,
> =A0 =A0 =A0 =A0},
> =A0};
>
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>


thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
