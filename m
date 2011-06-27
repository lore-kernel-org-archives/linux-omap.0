From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3 04/12] Serial: OMAP: Add runtime pm support for
 omap-serial driver
Date: Mon, 27 Jun 2011 20:01:57 +0530
Message-ID: <BANLkTikH9CZxMF8RNCYTisuLEyOFBHvcMQ@mail.gmail.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
 <1307532194-13039-5-git-send-email-govindraj.raja@ti.com> <8739iyu7rh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41938 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab1F0OcV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 10:32:21 -0400
In-Reply-To: <8739iyu7rh.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Sat, Jun 25, 2011 at 5:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Adapts omap-serial driver to use pm_runtime api's.
>>
>> 1.) Populate reg values to uart port which can be used for context r=
estore.
>
> Please make this part a separate patch.
>
>> 2.) Moving context_restore func to driver from serial.c
>> 3.) Adding port_enable/disable func to enable/disable given uart por=
t.
>> =A0 =A0 enable port using get_sync and disable using autosuspend.
>> 4.) using runtime irq safe api to make get_sync be called from irq c=
ontext.
>
>>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> This is great! =A0we're almost there. =A0 Some minor comments below..=
=2E
>
>> ---
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 22 +++
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A02 +
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
212 ++++++++++++++++++++++---
>> =A03 files changed, 210 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index 8c1a4c7..1651c2c 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -189,6 +189,27 @@ static void omap_serial_fill_default_pads(struc=
t omap_board_data *bdata)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static void omap_uart_wakeup_enable(struct platform_device *pdev, b=
ool enable)
>> +{
>> + =A0 =A0 struct omap_uart_port_info *up =3D pdev->dev.platform_data=
;
>> +
>> + =A0 =A0 /* Set or clear wake-enable bit */
>> + =A0 =A0 if (up->wk_en && up->wk_mask) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 v =3D __raw_readl(up->wk_en);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v |=3D up->wk_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v &=3D ~up->wk_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(v, up->wk_en);
>> + =A0 =A0 }
>
> I think I asked this in previous series, but can't remember the answe=
r
> now... =A0can't we enable bits in the WKEN registers once at init tim=
e,
> and then just use omap_hwmod_[enable|disable]_wakeup() here?
>

by default all bits are enabled in WKEN,

I will use omap_hwmod_[enable|disable]_wakeup() api's

if these API's take care of WKEN regs, then no issue
using the same.


>> + =A0 =A0 /* Enable or clear io-pad wakeup */
>> + =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_device_enable_ioring_wakeup(pdev);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_device_disable_ioring_wakeup(pdev);
>> +}
>> +
>> =A0static void omap_uart_idle_init(struct omap_uart_port_info *uart,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned=
 short num)
>> =A0{
>> @@ -332,6 +353,7 @@ void __init omap_serial_init_port(struct omap_bo=
ard_data *bdata)
>>
>> =A0 =A0 =A0 pdata->uartclk =3D OMAP24XX_BASE_BAUD * 16;
>> =A0 =A0 =A0 pdata->flags =3D UPF_BOOT_AUTOCONF;
>> + =A0 =A0 pdata->enable_wakeup =3D omap_uart_wakeup_enable;
>> =A0 =A0 =A0 if (bdata->id =3D=3D omap_uart_con_id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->console_uart =3D true;
>>
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/ar=
m/plat-omap/include/plat/omap-serial.h
>> index 2ca885b..ac30de8 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -65,6 +65,7 @@ struct omap_uart_port_info {
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0errata;
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0console_uart;
>>
>> + =A0 =A0 void (*enable_wakeup)(struct platform_device *, bool);
>> =A0 =A0 =A0 void __iomem *wk_st;
>> =A0 =A0 =A0 void __iomem *wk_en;
>> =A0 =A0 =A0 u32 wk_mask;
>> @@ -120,6 +121,7 @@ struct uart_omap_port {
>> =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name[20];
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 port_activity;
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0errata;
>> + =A0 =A0 void (*enable_wakeup)(struct platform_device *, bool);
>> =A0};
>>
>> =A0#endif /* __OMAP_SERIAL_H__ */
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/o=
map-serial.c
>> index 47cadf4..897416f 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -37,10 +37,14 @@
>> =A0#include <linux/clk.h>
>> =A0#include <linux/serial_core.h>
>> =A0#include <linux/irq.h>
>> +#include <linux/pm_runtime.h>
>>
>> =A0#include <plat/dma.h>
>> =A0#include <plat/dmtimer.h>
>> =A0#include <plat/omap-serial.h>
>> +#include <plat/omap_device.h>
>> +
>> +#define OMAP_UART_AUTOSUSPEND_DELAY (30 * HZ) /* Value is msecs */
>
> As Jon already pointed out, the HZ here is wrong. =A0Please define th=
is
> value in msecs.
>

corrected.

>> =A0static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>>
>> @@ -94,6 +98,17 @@ serial_omap_get_divisor(struct uart_port *port, u=
nsigned int baud)
>> =A0 =A0 =A0 return port->uartclk/(baud * divisor);
>> =A0}
>>
>> +static inline void serial_omap_port_disable(struct uart_omap_port *=
up)
>> +{
>> + =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->dev);
>> + =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->dev);
>> +}
>> +
>> +static inline void serial_omap_port_enable(struct uart_omap_port *u=
p)
>> +{
>> + =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
>> +}
>
> These inlines are not needed. =A0Please use runtime PM calls directly=
 in
> the code. =A0For _enable(), this is straight forward. =A0For _disable=
()
> though, I don't think you want (or need) to _mark_last_busy() for eve=
ry
> instance of omap_port_disable(). =A0You only need to do this for ones
> TX/RX transactions...
>

=46ine. will modify.


>> =A0static void serial_omap_stop_rxdma(struct uart_omap_port *up)
>> =A0{
>> =A0 =A0 =A0 if (up->uart_dma.rx_dma_used) {
>> @@ -110,8 +125,11 @@ static void serial_omap_enable_ms(struct uart_p=
ort *port)
>> =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)p=
ort;
>>
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->=
pdev->id);
>> +
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 up->ier |=3D UART_IER_MSI;
>> =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
>> + =A0 =A0 serial_omap_port_disable(up);
>
> ...for example, this one is not really activity based, so should
> probably just be pm_runtime_get_sync(), write the register, then
> pm_runtime_put() (async version.)
>
> I didn't look at all the others below, but they should be looked at
> individually.
>

ok. I will check them.

>> =A0}
>>
>> =A0static void serial_omap_stop_tx(struct uart_port *port)
>> @@ -131,21 +149,26 @@ static void serial_omap_stop_tx(struct uart_po=
rt *port)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_channel =3D OMAP_UAR=
T_DMA_CH_FREE;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 if (up->ier & UART_IER_THRI) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->ier &=3D ~UART_IER_THRI;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
>> =A0 =A0 =A0 }
>> +
>> + =A0 =A0 serial_omap_port_disable(up);
>> =A0}
>>
>> =A0static void serial_omap_stop_rx(struct uart_port *port)
>> =A0{
>> =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)p=
ort;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 if (up->use_dma)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_rxdma(up);
>> =A0 =A0 =A0 up->ier &=3D ~UART_IER_RLSI;
>> =A0 =A0 =A0 up->port.read_status_mask &=3D ~UART_LSR_DR;
>> =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
>> + =A0 =A0 serial_omap_port_disable(up);
>> =A0}
>>
>> =A0static inline void receive_chars(struct uart_omap_port *up, int *=
status)
>> @@ -261,8 +284,10 @@ static void serial_omap_start_tx(struct uart_po=
rt *port)
>> =A0 =A0 =A0 unsigned int start;
>> =A0 =A0 =A0 int ret =3D 0;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 if (!up->use_dma) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_enable_ier_thri(up);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>>
>> @@ -354,9 +379,12 @@ static inline irqreturn_t serial_omap_irq(int i=
rq, void *dev_id)
>> =A0 =A0 =A0 unsigned int iir, lsr;
>> =A0 =A0 =A0 unsigned long flags;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 iir =3D serial_in(up, UART_IIR);
>> - =A0 =A0 if (iir & UART_IIR_NO_INT)
>> + =A0 =A0 if (iir & UART_IIR_NO_INT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>> =A0 =A0 =A0 lsr =3D serial_in(up, UART_LSR);
>> @@ -378,6 +406,8 @@ static inline irqreturn_t serial_omap_irq(int ir=
q, void *dev_id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 transmit_chars(up);
>>
>> =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
>> + =A0 =A0 serial_omap_port_disable(up);
>> +
>> =A0 =A0 =A0 up->port_activity =3D jiffies;
>> =A0 =A0 =A0 return IRQ_HANDLED;
>> =A0}
>> @@ -388,11 +418,12 @@ static unsigned int serial_omap_tx_empty(struc=
t uart_port *port)
>> =A0 =A0 =A0 unsigned long flags =3D 0;
>> =A0 =A0 =A0 unsigned int ret =3D 0;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->p=
dev->id);
>> =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>> =A0 =A0 =A0 ret =3D serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSE=
R_TEMT : 0;
>> =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
>> -
>> + =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> @@ -402,7 +433,10 @@ static unsigned int serial_omap_get_mctrl(struc=
t uart_port *port)
>> =A0 =A0 =A0 unsigned char status;
>> =A0 =A0 =A0 unsigned int ret =3D 0;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 status =3D check_modem_status(up);
>> + =A0 =A0 serial_omap_port_disable(up);
>> +
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_get_mctrl+%d\n", up->=
pdev->id);
>>
>> =A0 =A0 =A0 if (status & UART_MSR_DCD)
>> @@ -434,7 +468,9 @@ static void serial_omap_set_mctrl(struct uart_po=
rt *port, unsigned int mctrl)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_LOOP;
>>
>> =A0 =A0 =A0 mcr |=3D up->mcr;
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 serial_out(up, UART_MCR, mcr);
>> + =A0 =A0 serial_omap_port_disable(up);
>> =A0}
>>
>> =A0static void serial_omap_break_ctl(struct uart_port *port, int bre=
ak_state)
>> @@ -443,6 +479,7 @@ static void serial_omap_break_ctl(struct uart_po=
rt *port, int break_state)
>> =A0 =A0 =A0 unsigned long flags =3D 0;
>>
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->=
pdev->id);
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>> =A0 =A0 =A0 if (break_state =3D=3D -1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->lcr |=3D UART_LCR_SBC;
>> @@ -450,6 +487,7 @@ static void serial_omap_break_ctl(struct uart_po=
rt *port, int break_state)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->lcr &=3D ~UART_LCR_SBC;
>> =A0 =A0 =A0 serial_out(up, UART_LCR, up->lcr);
>> =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
>> + =A0 =A0 serial_omap_port_disable(up);
>> =A0}
>>
>> =A0static int serial_omap_startup(struct uart_port *port)
>> @@ -468,6 +506,7 @@ static int serial_omap_startup(struct uart_port =
*port)
>>
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->pd=
ev->id);
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Clear the FIFO buffers and disable them.
>> =A0 =A0 =A0 =A0* (they will be reenabled in set_termios())
>> @@ -523,6 +562,7 @@ static int serial_omap_startup(struct uart_port =
*port)
>> =A0 =A0 =A0 /* Enable module level wake up */
>> =A0 =A0 =A0 serial_out(up, UART_OMAP_WER, OMAP_UART_WER_MOD_WKUP);
>>
>> + =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 up->port_activity =3D jiffies;
>> =A0 =A0 =A0 return 0;
>> =A0}
>> @@ -533,6 +573,8 @@ static void serial_omap_shutdown(struct uart_por=
t *port)
>> =A0 =A0 =A0 unsigned long flags =3D 0;
>>
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->p=
dev->id);
>> +
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Disable interrupts from this port
>> =A0 =A0 =A0 =A0*/
>> @@ -566,6 +608,7 @@ static void serial_omap_shutdown(struct uart_por=
t *port)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf_dma_=
phys);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf =3D NULL;
>> =A0 =A0 =A0 }
>> + =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 free_irq(up->port.irq, up);
>> =A0}
>>
>> @@ -671,6 +714,10 @@ serial_omap_set_termios(struct uart_port *port,=
 struct ktermios *termios,
>> =A0 =A0 =A0 baud =3D uart_get_baud_rate(port, termios, old, 0, port-=
>uartclk/13);
>> =A0 =A0 =A0 quot =3D serial_omap_get_divisor(port, baud);
>>
>> + =A0 =A0 up->dll =3D quot & 0xff;
>> + =A0 =A0 up->dlh =3D quot >> 8;
>> + =A0 =A0 up->mdr1 =3D UART_OMAP_MDR1_DISABLE;
>> +
>> =A0 =A0 =A0 up->fcr =3D UART_FCR_R_TRIG_01 | UART_FCR_T_TRIG_01 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART_FCR_ENABLE_FIFO;
>> =A0 =A0 =A0 if (up->use_dma)
>> @@ -680,6 +727,7 @@ serial_omap_set_termios(struct uart_port *port, =
struct ktermios *termios,
>> =A0 =A0 =A0 =A0* Ok, we're now changing the port state. Do it with
>> =A0 =A0 =A0 =A0* interrupts disabled.
>> =A0 =A0 =A0 =A0*/
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>>
>> =A0 =A0 =A0 /*
>> @@ -723,6 +771,7 @@ serial_omap_set_termios(struct uart_port *port, =
struct ktermios *termios,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->ier |=3D UART_IER_MSI;
>> =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
>> =A0 =A0 =A0 serial_out(up, UART_LCR, cval); =A0 =A0 =A0 =A0 /* reset=
 DLAB */
>> + =A0 =A0 up->lcr =3D cval;
>>
>> =A0 =A0 =A0 /* FIFOs and DMA Settings */
>>
>> @@ -758,8 +807,7 @@ serial_omap_set_termios(struct uart_port *port, =
struct ktermios *termios,
>> =A0 =A0 =A0 serial_out(up, UART_MCR, up->mcr);
>>
>> =A0 =A0 =A0 /* Protocol, Baud Rate, and Interrupt Settings */
>> -
>> - =A0 =A0 serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
>> + =A0 =A0 serial_out(up, UART_OMAP_MDR1, up->mdr1);
>> =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>>
>> =A0 =A0 =A0 up->efr =3D serial_in(up, UART_EFR);
>> @@ -769,8 +817,8 @@ serial_omap_set_termios(struct uart_port *port, =
struct ktermios *termios,
>> =A0 =A0 =A0 serial_out(up, UART_IER, 0);
>> =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>>
>> - =A0 =A0 serial_out(up, UART_DLL, quot & 0xff); =A0 =A0 =A0 =A0 =A0=
/* LS of divisor */
>> - =A0 =A0 serial_out(up, UART_DLM, quot >> 8); =A0 =A0 =A0 =A0 =A0 =A0=
/* MS of divisor */
>> + =A0 =A0 serial_out(up, UART_DLL, up->dll); =A0 =A0 =A0/* LS of div=
isor */
>> + =A0 =A0 serial_out(up, UART_DLM, up->dlh); =A0 =A0 =A0/* MS of div=
isor */
>>
>> =A0 =A0 =A0 serial_out(up, UART_LCR, 0);
>> =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
>> @@ -780,9 +828,11 @@ serial_omap_set_termios(struct uart_port *port,=
 struct ktermios *termios,
>> =A0 =A0 =A0 serial_out(up, UART_LCR, cval);
>>
>> =A0 =A0 =A0 if (baud > 230400 && baud !=3D 3000000)
>> - =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, UART_OMAP_M=
DR1_13X_MODE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->mdr1 =3D UART_OMAP_MDR1_13X_MODE;
>> =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, UART_OMAP_M=
DR1_16X_MODE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->mdr1 =3D UART_OMAP_MDR1_16X_MODE;
>> +
>> + =A0 =A0 serial_out(up, UART_OMAP_MDR1, up->mdr1)
>>
>> =A0 =A0 =A0 /* Hardware Flow Control Configuration */
>>
>> @@ -810,6 +860,7 @@ serial_omap_set_termios(struct uart_port *port, =
struct ktermios *termios,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_configure_xonxoff(up, termio=
s);
>>
>> =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
>> + =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up=
->pdev->id);
>> =A0}
>>
>> @@ -821,6 +872,8 @@ serial_omap_pm(struct uart_port *port, unsigned =
int state,
>> =A0 =A0 =A0 unsigned char efr;
>>
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->pdev->i=
d);
>> +
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>> =A0 =A0 =A0 efr =3D serial_in(up, UART_EFR);
>> =A0 =A0 =A0 serial_out(up, UART_EFR, efr | UART_EFR_ECB);
>> @@ -830,6 +883,10 @@ serial_omap_pm(struct uart_port *port, unsigned=
 int state,
>> =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>> =A0 =A0 =A0 serial_out(up, UART_EFR, efr);
>> =A0 =A0 =A0 serial_out(up, UART_LCR, 0);
>> + =A0 =A0 if (state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(&up->pdev->dev);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);
>
> OK, so this boils down to either a _put_sync() or a _mark_last_busy +
> _put_autosuspend(), depending on whether this is suspending or resumi=
ng,
> right?
>

yes also during bootup.
disable the ports immediately that are not used during bootup.

> Why the difference?

Need to put the ports down immediately during system wide suspend
other wise autosuspend delay will prevent system to enter
suspend state immediately.

>
>> =A0}
>>
>> =A0static void serial_omap_release_port(struct uart_port *port)
>> @@ -907,25 +964,31 @@ static inline void wait_for_xmitr(struct uart_=
omap_port *up)
>> =A0static void serial_omap_poll_put_char(struct uart_port *port, uns=
igned char ch)
>> =A0{
>> =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)p=
ort;
>> +
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 wait_for_xmitr(up);
>> =A0 =A0 =A0 serial_out(up, UART_TX, ch);
>> + =A0 =A0 serial_omap_port_disable(up);
>> =A0}
>>
>> =A0static int serial_omap_poll_get_char(struct uart_port *port)
>> =A0{
>> =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)p=
ort;
>> - =A0 =A0 unsigned int status =3D serial_in(up, UART_LSR);
>> + =A0 =A0 unsigned int status;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> + =A0 =A0 status =3D serial_in(up, UART_LSR);
>> =A0 =A0 =A0 if (!(status & UART_LSR_DR))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_POLL_CHAR;
>>
>> - =A0 =A0 return serial_in(up, UART_RX);
>> + =A0 =A0 status =3D serial_in(up, UART_RX);
>> + =A0 =A0 serial_omap_port_disable(up);
>> + =A0 =A0 return status;
>> =A0}
>>
>> =A0#endif /* CONFIG_CONSOLE_POLL */
>>
>> =A0#ifdef CONFIG_SERIAL_OMAP_CONSOLE
>> -
>> =A0static struct uart_omap_port *serial_omap_console_ports[4];
>>
>> =A0static struct uart_driver serial_omap_reg;
>> @@ -955,6 +1018,8 @@ serial_omap_console_write(struct console *co, c=
onst char *s,
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&up->port.lock);
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> +
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* First save the IER then disable the interrupts
>> =A0 =A0 =A0 =A0*/
>> @@ -979,6 +1044,7 @@ serial_omap_console_write(struct console *co, c=
onst char *s,
>> =A0 =A0 =A0 if (up->msr_saved_flags)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_modem_status(up);
>>
>> + =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 if (locked)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&up->port.lock);
>> =A0 =A0 =A0 local_irq_restore(flags);
>> @@ -1061,22 +1127,27 @@ static struct uart_driver serial_omap_reg =3D=
 {
>> =A0 =A0 =A0 .cons =A0 =A0 =A0 =A0 =A0 =3D OMAP_CONSOLE,
>> =A0};
>>
>> -static int
>> -serial_omap_suspend(struct platform_device *pdev, pm_message_t stat=
e)
>> +static int serial_omap_suspend(struct device *dev)
>> =A0{
>> - =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(pdev);
>> + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>>
>> - =A0 =A0 if (up)
>> + =A0 =A0 if (up) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_suspend_port(&serial_omap_reg, &up-=
>port);
>> + =A0 =A0 =A0 =A0 =A0 =A0 console_trylock();
>
> This locking needs to be explained. =A0Why it is needed, but very
> importantly, why you are not checking the return value of the _tryloc=
k()
>

any print after this point can result in failure of immediate system su=
spending
due to delayed autosuspend from omap_console_write.

log prints after uart suspend and print them during resume.


>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_pm(&up->port, 3, 0);
>
> Why is this call needed?
>

Actually this is needed if no_console_suspend is used, for that
case the console will remain active since serial_omap_pm is not
getting called from serial_core and port is not suspended
immediately with put_sync.

prints during system wide suspend and delayed autosuspend
from console_write keeps system active in no_console_suspend case
so put in forced suspend state and log all prints to be printed later.

probably needs to a condition check if (no_console_suspend)


> uart_suspend_port() calls uart_change_pm() which should call the ->pm
> method of struct uart_ops (which is serial_omap_pm). =A0What am I mis=
sing?
>
> Also notice you're not calling serial_omap_pm() in the resume method
> below to change it back.
>
>> + =A0 =A0 }
>> =A0 =A0 =A0 return 0;
>> =A0}
>
> Also, device wakeup capability should be checked and enabled/disabled=
 in
> the suspend path (not only the runtime suspend path.)
>

ok.


>> -static int serial_omap_resume(struct platform_device *dev)
>> +static int serial_omap_resume(struct device *dev)
>> =A0{
>> - =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(dev);
>> + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>>
>> - =A0 =A0 if (up)
>> + =A0 =A0 if (up) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_resume_port(&serial_omap_reg, &up->=
port);
>> + =A0 =A0 =A0 =A0 =A0 =A0 console_unlock();
>
> Again, please describe locking in comments.
>
> Also, what happens here if the console_trylock() in your suspend meth=
od
> failed?
>

need to add a flag to check and unlock
from return status of trylock.

>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> @@ -1097,6 +1168,7 @@ static void serial_omap_rx_timeout(unsigned lo=
ng uart_no)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_rxdma(u=
p);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->ier |=3D (UART_IER_R=
DI | UART_IER_RLSI);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER,=
 up->ier);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(u=
p);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>> @@ -1128,6 +1200,9 @@ static void serial_omap_rx_timeout(unsigned lo=
ng uart_no)
>>
>> =A0static void uart_rx_dma_callback(int lch, u16 ch_status, void *da=
ta)
>> =A0{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)dat=
a;
>> +
>> + =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 return;
>> =A0}
>>
>> @@ -1135,6 +1210,7 @@ static int serial_omap_start_rxdma(struct uart=
_omap_port *up)
>> =A0{
>> =A0 =A0 =A0 int ret =3D 0;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 if (up->uart_dma.rx_dma_channel =3D=3D -1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_request_dma(up->uart_dma.ua=
rt_dma_rx,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "UART Rx=
 DMA",
>> @@ -1214,6 +1290,7 @@ static void uart_tx_dma_callback(int lch, u16 =
ch_status, void *data)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_tx(&up->port);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_used =3D false;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&(up->uart_dma.tx_lock));
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_stop_dma(up->uart_dma.tx_dma_channe=
l);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_continue_tx(up);
>> @@ -1224,9 +1301,10 @@ static void uart_tx_dma_callback(int lch, u16=
 ch_status, void *data)
>>
>> =A0static int serial_omap_probe(struct platform_device *pdev)
>> =A0{
>> - =A0 =A0 struct uart_omap_port =A0 *up;
>> + =A0 =A0 struct uart_omap_port =A0 *up =3D NULL;
>> =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *mem, *irq, *dma_tx, *dm=
a_rx;
>> =A0 =A0 =A0 struct omap_uart_port_info *omap_up_info =3D pdev->dev.p=
latform_data;
>> + =A0 =A0 struct omap_device *od;
>> =A0 =A0 =A0 int ret =3D -ENOSPC;
>>
>> =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> @@ -1276,12 +1354,20 @@ static int serial_omap_probe(struct platform=
_device *pdev)
>> =A0 =A0 =A0 up->port.ops =3D &serial_omap_pops;
>> =A0 =A0 =A0 up->port.line =3D pdev->id;
>>
>> - =A0 =A0 up->port.membase =3D omap_up_info->membase;
>> - =A0 =A0 up->port.mapbase =3D omap_up_info->mapbase;
>> + =A0 =A0 up->port.mapbase =3D mem->start;
>> + =A0 =A0 up->port.membase =3D ioremap(mem->start, mem->end - mem->s=
tart);
>> +
>> + =A0 =A0 if (!up->port.membase) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't ioremap UART\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 up->port.flags =3D omap_up_info->flags;
>> - =A0 =A0 up->port.irqflags =3D omap_up_info->irqflags;
>> =A0 =A0 =A0 up->port.uartclk =3D omap_up_info->uartclk;
>> =A0 =A0 =A0 up->uart_dma.uart_base =3D mem->start;
>> + =A0 =A0 up->errata =3D omap_up_info->errata;
>> + =A0 =A0 up->enable_wakeup =3D omap_up_info->enable_wakeup;
>>
>> =A0 =A0 =A0 if (omap_up_info->dma_enabled) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.uart_dma_tx =3D dma_tx->sta=
rt;
>> @@ -1295,18 +1381,36 @@ static int serial_omap_probe(struct platform=
_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_channel =3D OMAP_UAR=
T_DMA_CH_FREE;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 pm_runtime_use_autosuspend(&pdev->dev);
>> + =A0 =A0 pm_runtime_set_autosuspend_delay(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_UART_AUTOSUSPEND_DELA=
Y);
>> +
>> + =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> +
>> + =A0 =A0 if (omap_up_info->console_uart) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 od =3D to_omap_device(up->pdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hwmod_idle(od->hwmods[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_enable(up);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 ui[pdev->id] =3D up;
>> =A0 =A0 =A0 serial_omap_add_console_port(up);
>>
>> =A0 =A0 =A0 ret =3D uart_add_one_port(&serial_omap_reg, &up->port);
>> =A0 =A0 =A0 if (ret !=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto do_release_region;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>>
>> + =A0 =A0 dev_set_drvdata(&pdev->dev, up);
>> =A0 =A0 =A0 platform_set_drvdata(pdev, up);
>> +
>> =A0 =A0 =A0 return 0;
>> =A0err:
>> =A0 =A0 =A0 dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->id=
, __func__, ret);
>> +err1:
>> + =A0 =A0 kfree(up);
>> =A0do_release_region:
>> =A0 =A0 =A0 release_mem_region(mem->start, (mem->end - mem->start) +=
 1);
>> =A0 =A0 =A0 return ret;
>> @@ -1318,20 +1422,76 @@ static int serial_omap_remove(struct platfor=
m_device *dev)
>>
>> =A0 =A0 =A0 platform_set_drvdata(dev, NULL);
>> =A0 =A0 =A0 if (up) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_disable(&up->pdev->dev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_remove_one_port(&serial_omap_reg, &=
up->port);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(up);
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +static void omap_uart_restore_context(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 u16 efr =3D 0;
>> +
>> + =A0 =A0 serial_out(up, UART_OMAP_MDR1, up->mdr1);
>> + =A0 =A0 serial_out(up, UART_LCR, 0xBF); /* Config B mode */
>> + =A0 =A0 efr =3D serial_in(up, UART_EFR);
>> + =A0 =A0 serial_out(up, UART_EFR, UART_EFR_ECB);
>> + =A0 =A0 serial_out(up, UART_LCR, 0x0); /* Operational mode */
>> + =A0 =A0 serial_out(up, UART_IER, 0x0);
>> + =A0 =A0 serial_out(up, UART_LCR, 0xBF); /* Config B mode */
>> + =A0 =A0 serial_out(up, UART_DLL, up->dll);
>> + =A0 =A0 serial_out(up, UART_DLM, up->dlh);
>> + =A0 =A0 serial_out(up, UART_LCR, 0x0); /* Operational mode */
>> + =A0 =A0 serial_out(up, UART_IER, up->ier);
>> + =A0 =A0 serial_out(up, UART_FCR, up->fcr);
>> + =A0 =A0 serial_out(up, UART_LCR, 0x80);
>> + =A0 =A0 serial_out(up, UART_MCR, up->mcr);
>> + =A0 =A0 serial_out(up, UART_LCR, 0xBF); /* Config B mode */
>> + =A0 =A0 serial_out(up, UART_EFR, efr);
>> + =A0 =A0 serial_out(up, UART_LCR, up->lcr);
>> + =A0 =A0 /* UART 16x mode */
>> + =A0 =A0 serial_out(up, UART_OMAP_MDR1, up->mdr1);
>> +}
>> +
>> +static int omap_serial_runtime_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 if (!up)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> +
>> + =A0 =A0 if (device_may_wakeup(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->enable_wakeup(up->pdev, true);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->enable_wakeup(up->pdev, false);
>
> I know the earlier code was doing it this way too, but an optimizatio=
n
> would be to have the driver keep state whether the wakeups are enable=
d
> or disabled, so you don't have to keep calling this function (which c=
an
> be expensive with the PRCM reads/writes.
>

if dynamically disabled from user space from sys-fs interface.
it may not reflect disable_wakup immediately if internal state machine =
of
wakeup is maintained within uart driver.

also need to modify the internals of this func pointer to use
hmwod API's as commented above.

> That state can also be used in the suspend path, which should also be
> managing wakeups.
>

ok.

>> +done:
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_serial_runtime_resume(struct device *dev)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 if (up)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_restore_context(up);
>
> You only need to restore context when returning from off-mode. =A0You
> should be using omap_device_get_context_loss_count (called via pdata
> function pointer) for this. =A0See the MMC driver or DSS driver for h=
ow
> this is done.
>

agree, will use that API.

--
Thanks,
Govindraj.R

>> + =A0 =A0 return 0;
>> +}
>> +
>> +static const struct dev_pm_ops omap_serial_dev_pm_ops =3D {
>> + =A0 =A0 .suspend =3D serial_omap_suspend,
>> + =A0 =A0 .resume =3D serial_omap_resume,
>> + =A0 =A0 .runtime_suspend =3D omap_serial_runtime_suspend,
>> + =A0 =A0 .runtime_resume =3D omap_serial_runtime_resume,
>> +};
>> +
>> =A0static struct platform_driver serial_omap_driver =3D {
>> =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D serial_omap_probe,
>> =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D serial_omap_remove,
>> -
>> - =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D serial_omap_suspend,
>> - =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D serial_omap_resume,
>> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRIVER_NAME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &omap_serial_dev_pm_ops,
>> =A0 =A0 =A0 },
>> =A0};
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
