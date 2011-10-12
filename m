From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for
 omap-serial driver
Date: Wed, 12 Oct 2011 16:07:50 +0530
Message-ID: <CAAL8m4x_VDKvSHS-CSq_+PiGeR8g7rJz4mPbk9BZT=Zty69tYA@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
 <1317380495-584-9-git-send-email-govindraj.raja@ti.com> <8739f0ct2o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <8739f0ct2o.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 11, 2011 at 5:12 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Adapts omap-serial driver to use pm_runtime API's.
>
> [...]
>
>> @@ -1065,19 +1123,18 @@ static struct uart_driver serial_omap_reg =3D=
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
>> =A0 =A0 =A0 if (up)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_suspend_port(&serial_omap_reg, &up-=
>port);
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
>
> These functions need to be wrapped in #ifdef CONFIG_SUSPEND, otherwis=
e,
> when building with !CONFIG_SUSPEND you'll get :
>
> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:1134:12: warnin=
g: 'serial_omap_suspend' defined but not used
> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:1150:12: warnin=
g: 'serial_omap_resume' defined but not used
>
>
> [...]
>
>> +static int serial_omap_runtime_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct omap_uart_port_info *pdata =3D dev->platform_data;
>> +
>> + =A0 =A0 if (!up)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 if (!pdata->enable_wakeup || !pdata->get_context_loss_coun=
t)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 if (pdata->get_context_loss_count)
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->context_loss_cnt =3D pdata->get_contex=
t_loss_count(dev);
>> +
>> + =A0 =A0 if (device_may_wakeup(dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!up->wakeups_enabled) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->enable_wakeup(up->p=
dev, true);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->wakeups_enabled =3D tr=
ue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (up->wakeups_enabled) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->enable_wakeup(up->p=
dev, false);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->wakeups_enabled =3D fa=
lse;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int serial_omap_runtime_resume(struct device *dev)
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_oma=
p_restore_context(up);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 return 0;
>> =A0}
>
> Similarily, thse need to be wrapped with #ifdef CONFIG_PM_RUNTIME,
> otherwise, when !CONFIG_PM_RUNTIME:
>
> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:1498:12: warnin=
g: 'serial_omap_runtime_suspend' defined but not used
> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:1531:12: warnin=
g: 'serial_omap_runtime_resume' defined but not used
>
>> +static const struct dev_pm_ops serial_omap_dev_pm_ops =3D {
>> + =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_r=
esume)
>> + =A0 =A0 SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_oma=
p_runtime_resume, NULL)
>> +};
>> +
>
> Note that you don't need #else parts to the above #ifdefs since
> the SET_*_OPS() macros used here take care of that.
>

Yes fine, Corrected

Thanks for catching this.

--
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
