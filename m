From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v4 07/11] Serial: OMAP: Add runtime pm support for
 omap-serial driver
Date: Fri, 9 Sep 2011 12:02:49 +0530
Message-ID: <CAAL8m4wpCVrhY7++ROwu0Whh4w_cF_dUr0t5622+WmJZah_FRA@mail.gmail.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
 <1315400013-4849-8-git-send-email-govindraj.raja@ti.com> <87obyu36lo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87obyu36lo.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 9, 2011 at 5:54 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Adapts omap-serial driver to use pm_runtime API's.
>>
>> 1.) Moving context_restore func to driver from serial.c
>> 2.) Use runtime irq safe to use get_sync from irq context.
>> 3.) autosuspend for port specific activities and put for reg access.
>
> Re: autosuspend, it looks like the driver now has 2 mechanisms for
> tracking activity. =A0The runtime PM 'mark last busy' and the existin=
g
> 'up->port_activity =3D jiffies' stuff. =A0Do you think those could be
> unified?
>

Is there a way where we can retrieve the last busy jiffie value
using runtime API? I don't find that available.


> At first glance, it looks like most places with a _mark_last_busy() a=
lso
> have a up->port_activity update. =A0I'm not familiar enough with the
> driver to make the call, but they look awfully similar.
>

Ok, I will check whether I can get rid if it.

>> 4.) for earlyprintk usage the debug macro will write to console uart
>> =A0 =A0 so keep uart clocks active from boot, idle using hwmod API's=
 re-enable back
>> =A0 =A0 using runtime API's.
>
> /me doesn't understand

I have added this reason in early mail reply to 04/11 patch review
[needed for earlyprintk option from low level debug ]


>
>> 5.) Moving context restore to runtime suspend and using reg values f=
rom port
>> =A0 =A0 structure to restore the uart port context based on context_=
loss_count.
>> =A0 =A0 Maintain internal state machine for avoiding repeated enable=
/disable of
>> =A0 =A0 uart port wakeup mechanism.
>> 6.) Add API to enable wakeup and check wakeup status.
>>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 49 ++++++
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 10 ++
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
211 ++++++++++++++++++++++---
>> =A03 files changed, 250 insertions(+), 20 deletions(-)
>>

[..]

>> +
>> +static void omap_uart_wakeup_enable(struct platform_device *pdev, b=
ool enable)
>> +{
>> + =A0 =A0 struct omap_device *od;
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
>> +
>> + =A0 =A0 od =3D to_omap_device(pdev);
>> + =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hwmod_enable_wakeup(od->hwmods[0]);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hwmod_disable_wakeup(od->hwmods[0]);
>> +}
>> +
>
> Here again, this is difficult to review because you removed the code =
in
> [4/11] and add it back here, but with rather different functionality
> with no description as to why.
>

will move this change as part of 4/11 itself.

> The previous version enabled wakeups at the PRCM and at the IO ring.
> This version enables wakeups at the PRCM as well but instead of enabl=
ing
> them at the IO ring, enables them at the module.
>

Since we are gating using prepare idle call I think
we can use this enable wake-up call as part of prepare idle call itself=
,
as done earlier.

>> =A0struct omap_hwmod *omap_uart_hwmod_lookup(int num)
>> =A0{
>> =A0 =A0 =A0 struct omap_hwmod *oh;
>> @@ -317,6 +363,9 @@ void __init omap_serial_init_port(struct omap_bo=
ard_data *bdata)
>>
>> =A0 =A0 =A0 pdata->uartclk =3D OMAP24XX_BASE_BAUD * 16;
>> =A0 =A0 =A0 pdata->flags =3D UPF_BOOT_AUTOCONF;
>> + =A0 =A0 pdata->enable_wakeup =3D omap_uart_wakeup_enable;
>> + =A0 =A0 pdata->chk_wakeup =3D omap_uart_chk_wakeup;
>> + =A0 =A0 pdata->get_context_loss_count =3D omap_pm_get_dev_context_=
loss_count;
>>
>> =A0 =A0 =A0 pdev =3D omap_device_build(name, bdata->id, oh, pdata,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(*=
pdata), omap_uart_latency,
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/ar=
m/plat-omap/include/plat/omap-serial.h
>> index 06e3aa2..7fc63b8 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -67,6 +67,9 @@ struct omap_uart_port_info {
>> =A0 =A0 =A0 void __iomem *wk_st;
>> =A0 =A0 =A0 void __iomem *wk_en;
>> =A0 =A0 =A0 u32 wk_mask;
>> + =A0 =A0 void (*enable_wakeup)(struct platform_device *, bool);
>> + =A0 =A0 bool (*chk_wakeup)(struct platform_device *);
>> + =A0 =A0 u32 (*get_context_loss_count)(struct device *);
>> =A0};
>>
>> =A0struct uart_omap_dma {
>> @@ -118,7 +121,14 @@ struct uart_omap_port {
>> =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 msr_saved_flags;
>> =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name[20];
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 port_activity;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_loss_c=
nt;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wake_status;
>> +
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0errata;
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0clocked;
>
> This is a legacy from serial.c and should not be needed. =A0Checking
> pm_runtime_suspended() will provide the same info.
>

Yes will try to use that.

>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0console_lock=
ed;
>> +
>> + =A0 =A0 bool (*chk_wakeup)(struct platform_device *);
>
> s/chk/check/ please. =A0It's not that much longer.
>

will change.

>> =A0};
>>
>> =A0#endif /* __OMAP_SERIAL_H__ */
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/o=
map-serial.c
>> index 6ac0ade..30bdd05 100644
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
>> +#define OMAP_UART_AUTOSUSPEND_DELAY 3000 =A0 =A0 /* Value is msecs =
*/
>
> Because of the character lost problem when UARTs are idled, Tony pref=
ers
> that the default on this be no auto timeout, like the current mainlin=
e
> code does.
>

Yes fine, IIUC this value should be -1 by default and can be later set =
using
sysfs entry.


>> =A0static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>>
>> @@ -102,6 +106,8 @@ static void serial_omap_stop_rxdma(struct uart_o=
map_port *up)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(up->uart_dma.rx_dma_channe=
l);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_channel =3D OMAP_UAR=
T_DMA_CH_FREE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_used =3D false;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->dev)=
;
>> =A0 =A0 =A0 }
>> =A0}
>>
>> @@ -110,8 +116,11 @@ static void serial_omap_enable_ms(struct uart_p=
ort *port)

[..]

>>
>> =A0#endif /* CONFIG_CONSOLE_POLL */
>>
>> =A0#ifdef CONFIG_SERIAL_OMAP_CONSOLE
>> -
>> =A0static struct uart_omap_port *serial_omap_console_ports[4];
>>
>> =A0static struct uart_driver serial_omap_reg;
>> @@ -951,6 +1004,8 @@ serial_omap_console_write(struct console *co, c=
onst char *s,
>> =A0 =A0 =A0 unsigned int ier;
>> =A0 =A0 =A0 int locked =3D 1;
>>
>> + =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
>> +
>> =A0 =A0 =A0 local_irq_save(flags);
>> =A0 =A0 =A0 if (up->port.sysrq)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 locked =3D 0;
>> @@ -983,9 +1038,12 @@ serial_omap_console_write(struct console *co, =
const char *s,
>> =A0 =A0 =A0 if (up->msr_saved_flags)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_modem_status(up);
>>
>> + =A0 =A0 pm_runtime_mark_last_busy(&up->pdev->dev);
>> + =A0 =A0 pm_runtime_put_autosuspend(&up->pdev->dev);
>> =A0 =A0 =A0 if (locked)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&up->port.lock);
>> =A0 =A0 =A0 local_irq_restore(flags);
>> + =A0 =A0 up->port_activity =3D jiffies;
>
> hmm, why? =A0this change looks suspicious.
>

Yes will try to unify with mark last busy.
But as said earlier can we have option to retrieve
last busy jiffies value.


>> =A0}
>>
>> =A0static int __init
>> @@ -1065,22 +1123,33 @@ static struct uart_driver serial_omap_reg =3D=
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (up->port.line =3D=3D up->port.cons->in=
dex &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !is_consol=
e_locked())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->console_locked =3D con=
sole_trylock();
>> + =A0 =A0 }
>> +
>
> Motiviation for console locking in this version of the series is not
> clear, and not described in the changelog.
>
> It's also present here in static suspend/resume but not in runtime
> suspend/resume, which also is suspicious.
>

Yes will add to change log,

We needed this for no console suspend use case
no console lock is taken in no_console_suspend is specified,

Since our pwr_dmn hooks disable clocks left enabled during suspend,
so any prints after pwr_dmn hooks can cause problems since clocks
are already cut from pwr_dmn hooks.

So buffer prints while entering suspend by taking console lock
if not taken already and print back after uart state machine restores
console uart.


>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -static int serial_omap_resume(struct platform_device *dev)
>> +static int serial_omap_resume(struct device *dev)
>> =A0{
>> - =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(dev);
>> + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>>
>> - =A0 =A0 if (up)
>> + =A0 =A0 if (up) {

[..]

>> + =A0 =A0 up->port.mapbase =3D mem->start;
>> + =A0 =A0 up->port.membase =3D ioremap(mem->start, mem->end - mem->s=
tart);
>
> The size is (end - start + 1), but please use the resource_size() hel=
per
> for this to avoid this common problem.
>

will change that.

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
>> + =A0 =A0 up->chk_wakeup =3D omap_up_info->chk_wakeup;
>>
>> =A0 =A0 =A0 if (omap_up_info->dma_enabled) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.uart_dma_tx =3D dma_tx->sta=
rt;
>> @@ -1299,18 +1378,34 @@ static int serial_omap_probe(struct platform=
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
>> + =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> + =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 od =3D to_omap_device(up->pdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hwmod_idle(od->hwmods[0]);
>
> No hwmod calls in drivers please.
>
> In this case, this is a legacy of using HWMOD_INIT_NO_IDLE and
> _NO_RESET. =A0That should be removed so this could be removed.
>

low level debug early printk use case as said earlier.


>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->clocked =3D 1;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 ui[pdev->id] =3D up;
>> =A0 =A0 =A0 serial_omap_add_console_port(up);
>>

[..]

>> + =A0 =A0 if (pdata->get_context_loss_count)
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->context_loss_cnt =3D pdata->get_contex=
t_loss_count(dev);
>
> You need
>
> =A0 =A0 =A0 =A0if (!pdata->enable_wakeup)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> here in case there is no ->enable_wakeup provided. =A0Otherwise...
>
>> + =A0 =A0 if (device_may_wakeup(dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!up->wake_status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->enable_wakeup(up->p=
dev, true);
>
> ...boom.
>

will correct it.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->wake_status =3D true;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (up->wake_status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->enable_wakeup(up->p=
dev, false);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->wake_status =3D false;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> up->wake_status would be better named ->wakeups_enabled;

sure.

>
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_serial_runtime_resume(struct device *dev)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct omap_uart_port_info *pdata =3D dev->platform_data;
>> +
>> + =A0 =A0 if (up) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->get_context_loss_count) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 loss_cnt =3D pdata->ge=
t_context_loss_count(dev);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (up->context_loss_cnt !=
=3D loss_cnt)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_=
restore_context(up);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_RUNTIME
>> +static const struct dev_pm_ops omap_serial_dev_pm_ops =3D {
>> + =A0 =A0 .suspend =3D serial_omap_suspend,
>> + =A0 =A0 .resume =3D serial_omap_resume,
>
> Static suspend operations should exists even when runtime PM is
> disabled.
>
>> + =A0 =A0 .runtime_suspend =3D omap_serial_runtime_suspend,
>> + =A0 =A0 .runtime_resume =3D omap_serial_runtime_resume,
>
> Note that some functions have serial_omap_ prefix and others have
> omap_serial_. =A0It looks like serial_omap_ is used througout the dri=
ver.
> Please unify.
>

yes sure. will change.

>> +};
>> +#define SERIAL_PM_OPS (&omap_serial_dev_pm_ops)
>> +#else
>> +#define SERIAL_PM_OPS NULL
>> +#endif
>
> Instead of this ifdef construct, please use SET_SYSTEM_SLEEP_PM_OPS()
> and SET_RUNTIME_PM_OPS() which take care of the right ifdefs for you,
> and also ensure that callbacks are available for suspend-to-disk (hib=
ernate):
>
> static const struct dev_pm_ops omap_serial_dev_pm_ops =3D {
> =A0 =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_=
resume),
> =A0 =A0 =A0 SET_RUNTIME_PM_OPS(runtime_suspend, runtime_resume, NULL)=
,
> };
>

yes will incorporate this.

Will give a quick respin and try to repost asap.

--
Thanks,
Govindraj.R


>> =A0static struct platform_driver serial_omap_driver =3D {
>> =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D serial_omap_probe,
>> =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D serial_omap_remove,
>> -
>> - =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D serial_omap_suspend,
>> - =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D serial_omap_resume,
>> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRIVER_NAME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D SERIAL_PM_OPS,
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
