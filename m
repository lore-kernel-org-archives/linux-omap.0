From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2 04/12] Serial: OMAP: Add runtime pm support for
 omap-serial driver
Date: Thu, 5 May 2011 11:25:38 +0530
Message-ID: <BANLkTi=As9Q66x8gxPiUKkLE-KFsvd8Q5Q@mail.gmail.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-5-git-send-email-govindraj.raja@ti.com> <87hb9aqk53.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87hb9aqk53.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, May 5, 2011 at 2:05 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Adapts omap-serial driver to use pm_runtime api's.
>>
>> 1.) Populate reg values to uart port which can be used for context r=
estore.
>> 2.) Moving context_restore func to driver from serial.c
>> 3.) Adding port_enable/disable func to enable/disable given uart por=
t.
>> =A0 =A0 enable port using get_sync and disable using autosuspend.
>> 4.) using runtime irq safe api to make get_sync be called from irq c=
ontext.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 16 ++
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A02 +
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
211 ++++++++++++++++++++++---
>> =A03 files changed, 203 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index 8c1a4c7..314d82f 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -189,6 +189,21 @@ static void omap_serial_fill_default_pads(struc=
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
>> +}
>
> Rather than having the driver do this via the PRCM, can you do an
> experiment? =A0Can you try to leave the module-level wakeup enabled a=
ll
> the time in the PRCM, and the driver can then enable/disable
> module-level wakeups simply by toggling ENAWAKEUP in the module's
> SYSCONFIG? =A0If that works, than you can just use
> omap_hwmod_enable_wakeup() for this and not need the above function.
>

If we leave PRCM uart module level bit enabled all time and we disable
wakeup using sysfs

echo disabled > /sys/devices/platform/omap/omap_uart.0/power/wakeup

it wakes up after clock disable, however unsetting the bit ensures it d=
oesn't
wakeup after uart clocks are cut.

As Paul suggested, How about adding omap_device/omap_hwmod function
to set and unset the bit?

Using

=2Emodule_bit =3D OMAP3430_EN_UART1_SHIFT,

from hwmod data?


>> =A0static void omap_uart_idle_init(struct omap_uart_port_info *uart,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned=
 short num)
>> =A0{
>> @@ -332,6 +347,7 @@ void __init omap_serial_init_port(struct omap_bo=
ard_data *bdata)
>>
>> =A0 =A0 =A0 pdata->uartclk =3D OMAP24XX_BASE_BAUD * 16;
>> =A0 =A0 =A0 pdata->flags =3D UPF_BOOT_AUTOCONF;
>> + =A0 =A0 pdata->enable_wakeup =3D omap_uart_wakeup_enable;
>> =A0 =A0 =A0 if (bdata->id =3D=3D omap_uart_con_id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->console_uart =3D true;

<<SNIP>>

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
>
> Driver should have know knowlege of the underlying hwmod.
>
> I assume this is here because of the usage of HWMOD_INIT_NO_IDLE and
> HWMOD_INIT_NO_RESET, right?

 Yes correct.

>=A0With proper runtime PM, we should be able to remove the need for us=
ing those flags.


=46or omap-uart used for earlyprintk's the early_console driver will
use printch from debug macro to print through uart.

During omap-hwmod is getting initialized

--> _setup
   --> _idle
    ---> _disable_clocks

at this point of time while printch is happening and
hwmod disables uart clocks I dont have uart-console
driver available which can enable clocks back.

So I have to use those flags when earlyprintk is enabled.

--
Thanks,
Govindraj.R


>
> Kevin
>
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
>> @@ -1318,20 +1421,76 @@ static int serial_omap_remove(struct platfor=
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
>> + =A0 =A0 serial_out(up, UART_LCR, UART_LCR_WLEN8);
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
>> +
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
