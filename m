From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 5/7] Serial: OMAP: add runtime pm support for omap-serial driver
Date: Tue, 8 Mar 2011 19:34:01 +0530
Message-ID: <AANLkTim35McK1cFFEXyS49D6b8CT+4pQfmKAswOn3e7_@mail.gmail.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
 <1298903958-6496-6-git-send-email-govindraj.raja@ti.com> <87r5am499h.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87r5am499h.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 5, 2011 at 7:29 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Adapts omap-serial driver to use pm_runtime api's.
>>
>> 1.) Populate reg values to uart port which can be used for context r=
estore.
>> 2.) Moved Erratum handling func to driver from serial.c
>> 3.) adding port_enable/disable func to enable/disable given uart por=
t.
>> 4.) using prepare/resume api's to cut and enable back uart func_clks=
=2E
>> 5.) using timer to set flag to cut uart clocks based on this flag in
>> =A0 =A0 sram_idle path.
>
> At least the errata handling should be in a separate patch as it's no=
t
> related to runtime PM.
>

ok. will move to separate patch


> Also, please be sure to test building this driver as a module. =A0Bec=
ause
> of direct access to hwmod in this patch, it will currently build as a=
 module.
>

yes will check this out. I can check this only
on zoom board I think as most of other boards
seem to use omap-uart as console uart.


>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0drivers/tty/serial/omap-serial.c | =A0304 +++++++++++++++++++++++=
++++++++++++---
>> =A01 files changed, 283 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/o=
map-serial.c
>> index d40924a..bc877b9 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -33,10 +33,21 @@
>> =A0#include <linux/clk.h>
>> =A0#include <linux/serial_core.h>
>> =A0#include <linux/irq.h>
>> +#include <linux/pm_runtime.h>
>>
>> =A0#include <plat/dma.h>
>> =A0#include <plat/dmtimer.h>
>> =A0#include <plat/omap-serial.h>
>> +#include <plat/serial.h>
>> +#include <plat/omap_device.h>
>> +
>> +#ifdef CONFIG_SERIAL_OMAP_CONSOLE
>> +#define omap_uart_console(port) ((port)->cons && (port)->cons->inde=
x =3D=3D (port)->line)
>> +#else
>> +#define omap_uart_console(port) =A0 =A0 =A0NULL
>> +#endif
>> +
>> +#define OMAP_UART_CLK_PUT_DELAY (5 * HZ)
>>
>> =A0static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>>
>> @@ -44,6 +55,7 @@ static struct uart_omap_port *ui[OMAP_MAX_HSUART_P=
ORTS];
>> =A0static void uart_tx_dma_callback(int lch, u16 ch_status, void *da=
ta);
>> =A0static void serial_omap_rx_timeout(unsigned long uart_no);
>> =A0static int serial_omap_start_rxdma(struct uart_omap_port *up);
>> +static void omap_uart_mdr1_errataset(struct uart_omap_port *up);
>>
>> =A0static inline unsigned int serial_in(struct uart_omap_port *up, i=
nt offset)
>> =A0{
>> @@ -90,6 +102,73 @@ serial_omap_get_divisor(struct uart_port *port, =
unsigned int baud)
>> =A0 =A0 =A0 return port->uartclk/(baud * divisor);
>> =A0}
>>
>> +static void omap_uart_smart_idle(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 struct platform_device *pdev =3D up->pdev;
>> + =A0 =A0 struct omap_device *od =3D container_of(pdev, struct omap_=
device, pdev);
>> +
>> + =A0 =A0 omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMOD=
E_SMART);
>> +}
>> +
>> +static void serial_omap_port_disable(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 if (!pm_runtime_suspended(&up->pdev->dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 del_timer(&up->inactivity_timer);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (omap_uart_console(&up->port))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_stop(up->port.cons=
);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(&up->pdev->dev);
>> + =A0 =A0 }
>> +}
>
> This function should not be needed.
>
> The timer should be replaced by the auto-suspend feature of runtime P=
M.

If I use autosuspend based on timer runtime framework
will disable clocks based on autosuspend timeout.

But if I cut clocks outside sram idle path module level wakeup
will not work. if I cut func clocks outside prepare for idle
wake_up is a problem. So I am going with existing model
where we are cutting clocks in prepare idle and enabling the
clock back in resume_idle based on wakeup event as any other
combination doesn't seem to work.

[As stated in other thread to reproduce the issue
with module level wakeup]

Even with existing framework if I try to experiment
by cutting clocks after uart timeout in allow_sleep
func, module level wakeup doesn't seem to happen.

>
> Instead of calling omap_port_disable() callers should call
> pm_runtime_put_autosuspend(), and the console_stop() should be part o=
f
> the ->runtime_suspend() callback.
>
> Also, why do you check for pm_runtime_suspended()? =A0Just call it fo=
r
> every time and we get runtime PM use-counting and statistics for free
> and the ->runtime_suspend() callback will be called when the usecount
> goes to zero.
>

Yes correct, but I can't balance the put_sync and get_sync
as said above. I can call put_sync only once in prepare_idle
to cut clocks. But having put_sync outside prepare_idle, if
clocks are cut module level wakeup doesn't seem to happen.


>> +static void serial_omap_inactivity_timer(unsigned long uart_no)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D ui[uart_no];
>> +
>> + =A0 =A0 up->can_sleep =3D 1;
>> + =A0 =A0 omap_uart_smart_idle(up);
>> +}
>
> This will not be needed if using the autosuspend feature.

Using autosuspend, module level wakeup will not happen
since autosuspend cuts clocks outside prepare_idle
based on autosuspend timeout.

>
>> +static void serial_omap_port_enable(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 if (pm_runtime_suspended(&up->pdev->dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (omap_uart_console(&up->port))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_start(up->port.con=
s);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 up->can_sleep =3D 0;
>> + =A0 =A0 mod_timer(&up->inactivity_timer, jiffies + OMAP_UART_CLK_P=
UT_DELAY);
>> +}
>
> Similarily to the disable side, callers of this function should call
> pm_runtime_get_sync() and the console_start() should be in the
> ->runtime_resume method.

Agree, will move console_start/console_stop func
to runtime sync callbacks.

>
> Again, no need to check pm_runtime_suspended() since the runtime PM c=
ore
> does usecounting already.
>

Agree, but balancing put_sync is an issue currently
for uart with get_sync as we can use put_sync
just once in prepare_idle.


>> +void omap_uart_prepare_idle(int num)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D ui[num];
>> +
>> + =A0 =A0 if (up && up->can_sleep)
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_put_autosuspend()
>
>> +}
>> +
>> +void omap_uart_resume_idle(int num)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D ui[num];
>> + =A0 =A0 struct omap_device *od;
>> + =A0 =A0 struct platform_device *pdev;
>> +
>> + =A0 =A0 if (!up)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 pdev =3D up->pdev;
>> + =A0 =A0 od =3D container_of(pdev, struct omap_device, pdev);
>
> =A0 =A0 =A0 =A0od =3D to_omap_device(pdev);
>
>> + =A0 =A0 if (omap_hmwod_pad_wakeup_status(od->hwmods[0]) =3D=3D tru=
e)
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_enable(up);
>> +
>> + =A0 =A0 if (up->wk_st && (__raw_readl(up->wk_st) & up->wk_mask))
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_enable(up);
>> +}
>
> c.f. comments from PATCH 2/7
>
> Also, direct hwmod access and PRCM accesses do not belong in drivers.
>
> Until it is understood why wakeups are not working, these hacks shoul=
d
> stay in mach-omap2/serial.c
>

Ok. I will add callbacks to handle wk_mask and wk_st
will retain these funcs in serial.c but new format of this func can use
uart_port id based on which i can select wk_st and wk_mask
values and then read/write into these.


>> =A0static void serial_omap_stop_rxdma(struct uart_omap_port *up)
>> =A0{
>> =A0 =A0 =A0 if (up->uart_dma.rx_dma_used) {
>> @@ -105,6 +184,7 @@ static void serial_omap_enable_ms(struct uart_po=
rt *port)
>> =A0{
>> =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)p=
ort;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>
> =A0 =A0 =A0 =A0pm_runtime_put_autosuspend()
>
> similarily for all calls to omap_port_enable()
>
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->=
pdev->id);
>> =A0 =A0 =A0 up->ier |=3D UART_IER_MSI;
>> =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
>> @@ -114,6 +194,7 @@ static void serial_omap_stop_tx(struct uart_port=
 *port)
>> =A0{
>> =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)p=
ort;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 if (up->use_dma &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_channel !=3D OMAP_UA=
RT_DMA_CH_FREE) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> @@ -137,6 +218,7 @@ static void serial_omap_stop_rx(struct uart_port=
 *port)
>> =A0{
>> =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)p=
ort;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 if (up->use_dma)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_rxdma(up);
>> =A0 =A0 =A0 up->ier &=3D ~UART_IER_RLSI;
>> @@ -258,6 +340,7 @@ static void serial_omap_start_tx(struct uart_por=
t *port)
>> =A0 =A0 =A0 unsigned int start;
>> =A0 =A0 =A0 int ret =3D 0;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 if (!up->use_dma) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_enable_ier_thri(up);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> @@ -351,6 +434,7 @@ static inline irqreturn_t serial_omap_irq(int ir=
q, void *dev_id)
>> =A0 =A0 =A0 unsigned int iir, lsr;
>> =A0 =A0 =A0 unsigned long flags;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 iir =3D serial_in(up, UART_IIR);
>> =A0 =A0 =A0 if (iir & UART_IIR_NO_INT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> @@ -385,6 +469,7 @@ static unsigned int serial_omap_tx_empty(struct =
uart_port *port)
>> =A0 =A0 =A0 unsigned long flags =3D 0;
>> =A0 =A0 =A0 unsigned int ret =3D 0;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->p=
dev->id);
>> =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>> =A0 =A0 =A0 ret =3D serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSE=
R_TEMT : 0;
>> @@ -399,6 +484,7 @@ static unsigned int serial_omap_get_mctrl(struct=
 uart_port *port)
>> =A0 =A0 =A0 unsigned char status;
>> =A0 =A0 =A0 unsigned int ret =3D 0;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 status =3D check_modem_status(up);
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_get_mctrl+%d\n", up->=
pdev->id);
>>
>> @@ -419,6 +505,7 @@ static void serial_omap_set_mctrl(struct uart_po=
rt *port, unsigned int mctrl)
>> =A0 =A0 =A0 unsigned char mcr =3D 0;
>>
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_set_mctrl+%d\n", up->=
pdev->id);
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 if (mctrl & TIOCM_RTS)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_RTS;
>> =A0 =A0 =A0 if (mctrl & TIOCM_DTR)
>> @@ -440,6 +527,7 @@ static void serial_omap_break_ctl(struct uart_po=
rt *port, int break_state)
>> =A0 =A0 =A0 unsigned long flags =3D 0;
>>
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->=
pdev->id);
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>> =A0 =A0 =A0 if (break_state =3D=3D -1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->lcr |=3D UART_LCR_SBC;
>> @@ -465,6 +553,7 @@ static int serial_omap_startup(struct uart_port =
*port)
>>
>> =A0 =A0 =A0 dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->pd=
ev->id);
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Clear the FIFO buffers and disable them.
>> =A0 =A0 =A0 =A0* (they will be reenabled in set_termios())
>> @@ -530,6 +619,8 @@ static void serial_omap_shutdown(struct uart_por=
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
>> @@ -668,6 +759,10 @@ serial_omap_set_termios(struct uart_port *port,=
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
>> @@ -677,6 +772,7 @@ serial_omap_set_termios(struct uart_port *port, =
struct ktermios *termios,
>> =A0 =A0 =A0 =A0* Ok, we're now changing the port state. Do it with
>> =A0 =A0 =A0 =A0* interrupts disabled.
>> =A0 =A0 =A0 =A0*/
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>>
>> =A0 =A0 =A0 /*
>> @@ -755,8 +851,11 @@ serial_omap_set_termios(struct uart_port *port,=
 struct ktermios *termios,
>> =A0 =A0 =A0 serial_out(up, UART_MCR, up->mcr);
>>
>> =A0 =A0 =A0 /* Protocol, Baud Rate, and Interrupt Settings */
>> + =A0 =A0 if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_mdr1_errataset(up);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, up->mdr1);
>>
>> - =A0 =A0 serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
>> =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>>
>> =A0 =A0 =A0 up->efr =3D serial_in(up, UART_EFR);
>> @@ -766,8 +865,8 @@ serial_omap_set_termios(struct uart_port *port, =
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
>> @@ -777,9 +876,14 @@ serial_omap_set_termios(struct uart_port *port,=
 struct ktermios *termios,
>> =A0 =A0 =A0 serial_out(up, UART_LCR, cval);
>>
>> =A0 =A0 =A0 if (baud > 230400 && baud !=3D 3000000)
>> - =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, UART_OMAP_M=
DR1_13X_MODE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->mdr1 =3D UART_OMAP_MDR1_13X_MODE;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->mdr1 =3D UART_OMAP_MDR1_16X_MODE;
>> +
>> + =A0 =A0 if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_mdr1_errataset(up);
>> =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, UART_OMAP_M=
DR1_16X_MODE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, up->mdr1);
>>
>> =A0 =A0 =A0 /* Hardware Flow Control Configuration */
>>
>> @@ -818,6 +922,8 @@ serial_omap_pm(struct uart_port *port, unsigned =
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
>> @@ -827,6 +933,8 @@ serial_omap_pm(struct uart_port *port, unsigned =
int state,
>> =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>> =A0 =A0 =A0 serial_out(up, UART_EFR, efr);
>> =A0 =A0 =A0 serial_out(up, UART_LCR, 0);
>> + =A0 =A0 if (state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);
>
> FYI... this change doesn't apply when basing on the commit you mentio=
ned
> in PATCH 0/7.
>

this patch series will apply on top the
dependency patches specified in cover letter.

Specially needs
https://patchwork.kernel.org/patch/501211/
without which it will fail here.

>> =A0}
>>
>> =A0static void serial_omap_release_port(struct uart_port *port)
>> @@ -904,6 +1012,8 @@ static inline void wait_for_xmitr(struct uart_o=
map_port *up)
>> =A0static void serial_omap_poll_put_char(struct uart_port *port, uns=
igned char ch)
>> =A0{
>> =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)p=
ort;
>> +
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 wait_for_xmitr(up);
>> =A0 =A0 =A0 serial_out(up, UART_TX, ch);
>> =A0}
>> @@ -911,8 +1021,10 @@ static void serial_omap_poll_put_char(struct u=
art_port *port, unsigned char ch)
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
>> @@ -922,7 +1034,6 @@ static int serial_omap_poll_get_char(struct uar=
t_port *port)
>> =A0#endif /* CONFIG_CONSOLE_POLL */
>>
>> =A0#ifdef CONFIG_SERIAL_OMAP_CONSOLE
>> -
>> =A0static struct uart_omap_port *serial_omap_console_ports[4];
>>
>> =A0static struct uart_driver serial_omap_reg;
>> @@ -931,6 +1042,7 @@ static void serial_omap_console_putchar(struct =
uart_port *port, int ch)
>> =A0{
>> =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)p=
ort;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 wait_for_xmitr(up);
>> =A0 =A0 =A0 serial_out(up, UART_TX, ch);
>> =A0}
>> @@ -944,6 +1056,7 @@ serial_omap_console_write(struct console *co, c=
onst char *s,
>> =A0 =A0 =A0 unsigned int ier;
>> =A0 =A0 =A0 int locked =3D 1;
>>
>> + =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 local_irq_save(flags);
>> =A0 =A0 =A0 if (up->port.sysrq)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 locked =3D 0;
>> @@ -1058,22 +1171,25 @@ static struct uart_driver serial_omap_reg =3D=
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -static int serial_omap_resume(struct platform_device *dev)
>> +static int serial_omap_resume(struct device *dev)
>> =A0{
>> - =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(dev);
>> + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>>
>> =A0 =A0 =A0 if (up)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_resume_port(&serial_omap_reg, &up->=
port);
>> +
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> @@ -1221,9 +1337,10 @@ static void uart_tx_dma_callback(int lch, u16=
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
>> @@ -1273,12 +1390,23 @@ static int serial_omap_probe(struct platform=
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
>> +
>> + =A0 =A0 up->wk_st =3D omap_up_info->wk_st;
>> + =A0 =A0 up->wk_en =3D omap_up_info->wk_en;
>> + =A0 =A0 up->wk_mask =3D omap_up_info->wk_mask;
>>
>> =A0 =A0 =A0 if (omap_up_info->dma_enabled) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.uart_dma_tx =3D dma_tx->sta=
rt;
>> @@ -1291,19 +1419,35 @@ static int serial_omap_probe(struct platform=
_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_channel =3D OMAP_UAR=
T_DMA_CH_FREE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_channel =3D OMAP_UAR=
T_DMA_CH_FREE;
>> =A0 =A0 =A0 }
>> + =A0 =A0 init_timer(&(up->inactivity_timer));
>> + =A0 =A0 up->inactivity_timer.function =3D serial_omap_inactivity_t=
imer;
>> + =A0 =A0 up->inactivity_timer.data =3D up->pdev->id;
>> +
>> + =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>
> The changelog should describe why the IRQ-safe mode is needed.

yes will add.
we need to use get_sync in irq_context hence needed.

>
>> + =A0 =A0 if (omap_up_info->console_uart) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 od =3D container_of(pdev, struct omap_devi=
ce, pdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hwmod_idle(od->hwmods[0]);
>
> This was only in mach-omap2/serial.c because the early UART probing w=
as
> accessing registers. =A0With this driver becoming runtime PM aware, t=
his
> hack should not be needed, and the
>
> =A0 =A0 =A0 =A0oh->flags |=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESE=
T;
>
> should be removed from mach-omap2/serial.c


Yes. Since any omap-uart can be used as
console uart and the console uart can be used
for earlyprintk's.

=46or earlyprintk's the early console driver will
use printch from debug macro to print through uart
during which hwmod is getting initialized

--> _setup
    --> _idle
     ---> _disable_clocks

at this point of time while printch is happening and
hwmod disables uart clocks I dont have uart-console
driver available which can enable clocks back.

So I have to use those flags when earlyprintk
is enabled. I have added some more changes
into omap_serial_early_init which uses these flags
only when earlyprintk config is defined and
earlyprintk word is used in bootarg, snip below.

<<Function SNIP>>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
static int __init omap_serial_early_init(void)
{
#ifdef CONFIG_EARLY_PRINTK
        int i =3D 0;
        char omap_tty_name[MAX_UART_HWMOD_NAME_LEN];
        struct omap_hwmod *oh;

        if (!cmdline_find_option("earlyprintk"))
                return 0;

        for (i =3D 0; i < OMAP_MAX_HSUART_PORTS; i++) {
                snprintf(omap_tty_name, MAX_UART_HWMOD_NAME_LEN,
                        "%s%d", OMAP_SERIAL_NAME, i);
                if (cmdline_find_option(omap_tty_name)) {
                        omap_uart_con_id =3D i;
                        oh =3D omap_uart_hwmod_lookup(i);
                        oh->flags |=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_=
NO_RESET;
                        return 0;
                }
        }
#endif
        return 0;
}
core_initcall(omap_serial_early_init);

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_enable(up);
>> + =A0 =A0 }
>>
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
>> @@ -1315,20 +1459,138 @@ static int serial_omap_remove(struct platfo=
rm_device *dev)
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
>> +/*
>> + * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
>> + * The access to uart register after MDR1 Access
>> + * causes UART to corrupt data.
>> + *
>> + * Need a delay =3D
>> + * 5 L4 clock cycles + 5 UART functional clock cycle (@48MHz =3D ~0=
=2E2uS)
>> + * give 10 times as much
>> + */
>> +static void omap_uart_mdr1_errataset(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 u8 timeout =3D 255;
>> +
>> + =A0 =A0 serial_out(up, UART_OMAP_MDR1, up->mdr1);
>> + =A0 =A0 udelay(2);
>> + =A0 =A0 serial_out(up, UART_FCR, up->fcr | UART_FCR_CLEAR_XMIT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART_FCR_CLEAR_RCVR);
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Wait for FIFO to empty: when empty, RX_FIFO_E bit is =
0 and
>> + =A0 =A0 =A0* TX_FIFO_E bit is 1.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 while (UART_LSR_THRE !=3D (serial_in(up, UART_LSR) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (UART_LSR_=
THRE | UART_LSR_DR))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 timeout--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!timeout) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Should *never* happen. =
we warn and carry on */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_crit(&up->pdev->dev, "=
Errata i202: timedout %x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_in(up, UART_LSR));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> + =A0 =A0 }
>> +}
>> +
>> +static void omap_uart_restore_context(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 u16 efr =3D 0;
>> +
>> + =A0 =A0 if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_mdr1_errataset(up);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, up->mdr1);
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
>> + =A0 =A0 serial_out(up, UART_LCR, UART_LCR_WLEN8);
>> + =A0 =A0 if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_mdr1_errataset(up);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* UART 16x mode */
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, up->mdr1);
>> +}
>> +
>> +static void omap_uart_enable_wakeup(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 /* Set wake-enable bit */
>> + =A0 =A0 if (up->wk_en && up->wk_mask) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 v =3D __raw_readl(up->wk_en);
>> + =A0 =A0 =A0 =A0 =A0 =A0 v |=3D up->wk_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(v, up->wk_en);
>> + =A0 =A0 }
>> +}
>> +
>> +static void omap_uart_disable_wakeup(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 /* Clear wake-enable bit */
>> + =A0 =A0 if (up->wk_en && up->wk_mask) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 v =3D __raw_readl(up->wk_en);
>> + =A0 =A0 =A0 =A0 =A0 =A0 v &=3D ~up->wk_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(v, up->wk_en);
>> + =A0 =A0 }
>> +}
>
> Again, driver should not be doing direct PRCM accesses here.
>
> For now, how about leaving these also in mach-omap2/serial.c and call=
ing
> them via pdata function pointers:
>
> =A0if (pdata->enable_wakeup)
> =A0 =A0 =A0pdata->enable_wakeup()
>

Agree will move these func's and use func. pointer.

--
Thanks,
Govindraj.R


>> +static int omap_serial_runtime_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 if (!up)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> +
>> + =A0 =A0 if (device_may_wakeup(&up->pdev->dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_enable_wakeup(up);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_disable_wakeup(up);
>> +done:
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_serial_runtime_resume(struct device *dev)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 if (!up)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> +
>> + =A0 =A0 omap_uart_restore_context(up);
>> +done:
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
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
