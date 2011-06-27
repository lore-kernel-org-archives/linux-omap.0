From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3 11/12] OMAP2: Serial: Add has_async_wake flag.
Date: Mon, 27 Jun 2011 18:39:54 +0530
Message-ID: <BANLkTik9ZLyA4+1VMFj08Zke151OqAhATQ@mail.gmail.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-12-git-send-email-govindraj.raja@ti.com>
	<87y60qpxcq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87y60qpxcq.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 25, 2011 at 5:59 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Prior to this patch the uart_clock was cut using prepare/resume calls si=
nce
>> these funcs are no more available with runtime changes use has_async_wake
>> flag to keep clock active during bootup otherwise uart port will disabled
>> during boot-up and cannot be enabled back.
>
> Is this only a bootup issue, or a runtime PM issue? =A0It appears to me
> that with this patch, runtime PM is effectively disabled for the whole
> time.
>

it boots up fine, its a runtime PM issue where there is
no mechanism to wakeup after clock cutting from
runtime autosuspend.


> Why not just use pm_runtime_disable() in _probe() for devices with no
> async wakeup.
>

Agree.
can drop of this patch and bind below changes in runtime conversion patch  =
04/12

do pm_runtime_enable only if device_may_wakeup
is true in probe.

<<SNIP>>
in serial_omap_probe

if (device_may_wakeup(&pdev->dev)) {
	pm_runtime_use_autosuspend(&pdev->dev);
	pm_runtime_set_autosuspend_delay(&pdev->dev,
				OMAP_UART_AUTOSUSPEND_DELAY);
	pm_runtime_enable(&pdev->dev);
	pm_runtime_irq_safe(&pdev->dev);
}


>> Also based on this flag we can disable uart port during suspend and
>> enable back during resume for omap_socs that have not set
>> has_async_wake.
>
> Then you can use pm_runtime_enable() in ->prepare() and
> pm_runtime_disable() in ->complete()
>

u mean runtime enable in suspend and runtime disable in resume
if device_may_wakeup is false.

<<SNIP>>
in serial_omap_suspend

if (!device_may_wakeup(&pdev->dev))
	pm_runtime_enable(&pdev->dev);


--
Thanks,
Govindraj.R

> Kevin
>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A03 +++
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 14 =
++++++++++++++
>> =A03 files changed, 18 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>> index 4bc5914..0a95c95 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -266,6 +266,7 @@ static void omap_uart_idle_init(struct omap_uart_por=
t_info *uart,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->wk_mask =3D wk_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 uart->has_async_wake =3D true;
>> =A0 =A0 =A0 } else if (cpu_is_omap24xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 wk_mask =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 wk_en =3D PM_WKEN1, wk_st =3D PM_WKST1;
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/pl=
at-omap/include/plat/omap-serial.h
>> index b5117bd..69e6d4b 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -79,6 +79,7 @@ struct omap_uart_port_info {
>> =A0 =A0 =A0 void __iomem *wk_st;
>> =A0 =A0 =A0 void __iomem *wk_en;
>> =A0 =A0 =A0 u32 wk_mask;
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0has_async_wake;
>> =A0};
>>
>> =A0struct uart_omap_dma {
>> @@ -134,6 +135,8 @@ struct uart_omap_port {
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0errata;
>> =A0 =A0 =A0 void (*enable_wakeup)(struct platform_device *, bool);
>> =A0 =A0 =A0 bool (*chk_wakeup)(struct platform_device *);
>> +
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0has_async_wake;
>> =A0};
>>
>> =A0#endif /* __OMAP_SERIAL_H__ */
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-=
serial.c
>> index c3561dd..dbe76f3 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -1181,6 +1181,13 @@ static int serial_omap_suspend(struct device *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_suspend_port(&serial_omap_reg, &up->por=
t);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_trylock();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_pm(&up->port, 3, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* OMAP2 dont have async wakeup from prcm.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* For such socs clocks will be kept active =
from probe and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* cut only in suspend path.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!up->has_async_wake)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 return 0;
>> =A0}
>> @@ -1192,6 +1199,9 @@ static int serial_omap_resume(struct device *dev)
>> =A0 =A0 =A0 if (up) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_resume_port(&serial_omap_reg, &up->port=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_unlock();
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!up->has_async_wake)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_enable(up);
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 return 0;
>> @@ -1415,6 +1425,7 @@ static int serial_omap_probe(struct platform_devic=
e *pdev)
>> =A0 =A0 =A0 up->errata =3D omap_up_info->errata;
>> =A0 =A0 =A0 up->enable_wakeup =3D omap_up_info->enable_wakeup;
>> =A0 =A0 =A0 up->chk_wakeup =3D omap_up_info->chk_wakeup;
>> + =A0 =A0 up->has_async_wake =3D omap_up_info->has_async_wake;
>>
>> =A0 =A0 =A0 if (omap_up_info->dma_enabled) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.uart_dma_tx =3D dma_tx->start;
>> @@ -1443,6 +1454,9 @@ static int serial_omap_probe(struct platform_devic=
e *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (!up->has_async_wake)
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_enable(up);
>> +
>> =A0 =A0 =A0 ui[pdev->id] =3D up;
>> =A0 =A0 =A0 serial_omap_add_console_port(up);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
