From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2 12/12] OMAP2: Serial: Add no async wake flag.
Date: Fri, 6 May 2011 15:04:28 +0530
Message-ID: <BANLkTimg2-eJtDnAykDmciEf7s9siuG_QA@mail.gmail.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-13-git-send-email-govindraj.raja@ti.com> <87k4e5hx32.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87k4e5hx32.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, May 5, 2011 at 11:02 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> For omap2 cpu_idle thread will not be available
>
> Why not?
>
>> and uart_clock cutting happens only in suspend path.
>
> Aren't clocks also cut after runtime PM autosuspend?
>
>> Prior to this patch the uart_clock was cut using prepare/resume
>> calls since these funcs are no more available with runtime
>> changes use no_async_wake flag to keep clock active during bootup
>> otherwise uart port will disabled during boot-up and cannot be
>> enabled back.
>
> This doesn't just keep clock active during bootup, but it keeps clock
> active always, except during suspend.
>
>> Also based on this flag we can disable uart port during suspend
>> and enable back during resume.
>
> I think disabling UART port during suspend should already be part of =
an
> earlier patch. =A0This patch should then only make it conditional.
>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A07 +++++++
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A03 +++
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 14 ++++++++++++++
>> =A03 files changed, 24 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index d4ef370..1af9fd5 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -245,6 +245,12 @@ static void omap_uart_wakeup_enable(struct plat=
form_device *pdev, bool enable)
>> =A0static void omap_uart_idle_init(struct omap_uart_port_info *uart,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned=
 short num)
>> =A0{
>> + =A0 =A0 /* On omap2 no cpu_idle and async wakeup from prcm_module.
>
> Please remove comments about CPU idle, as the need for this has nothi=
ng
> to do with CPU idle.
>
>> + =A0 =A0 =A0* This flag can be used to cut clocks only in suspend p=
ath.
>> + =A0 =A0 =A0* to avoid boot break due to aggressive clock cutting f=
rom
>> + =A0 =A0 =A0* omap-serial driver.
>> + =A0 =A0 =A0*/
>
> fix multi-line comment style throughout
>
>> + =A0 =A0 uart->no_async_wake =3D true;
>
> If needed (which I still don't think I understand),

Looking into the pm24xx.c code what I understood is..

(1) omap2_enter_full_retention was cutting and enabling the uart
clocks back whether in idle patch or in suspend path.

(2) since we cut clocks outside this retention path I don't know
how to wake back uart as don't see any irq_handlers servicing
wake-up events in pm24xx.c
[Correct me if I am missing something here.]

(3) Since there was no async wakeup mechanism I could see
on pm24xx.c so one approach was to use of these flags.
[If I cut clocks during boot using put_sync in uart code since no
wakeup mechanism will break boot]

(4) For socs with no aync wakeup we are keeping clocks active from
probe and disabling/enabling clocks in suspend/resume hooks.

> for readability sake
> this flag should be called 'has_async_wake', and default to false. =A0=
It
> should then be set to true on available SoCs.

Yes sure I can rename the flag and use above approach.

--
Thanks,
Govindraj.R


>
> Kevin
>
>> =A0 =A0 =A0 if (cpu_is_omap34xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 mod =3D num > 1 ? OMAP3430_PER_MOD :=
 CORE_MOD;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 wk_mask =3D 0;
>> @@ -266,6 +272,7 @@ static void omap_uart_idle_init(struct omap_uart=
_port_info *uart,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->wk_mask =3D wk_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 uart->no_async_wake =3D false;
>> =A0 =A0 =A0 } else if (cpu_is_omap24xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 wk_mask =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 wk_en =3D PM_WKEN1, wk_st =3D PM_WKS=
T1;
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/ar=
m/plat-omap/include/plat/omap-serial.h
>> index b5117bd..1de5bc4 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -79,6 +79,7 @@ struct omap_uart_port_info {
>> =A0 =A0 =A0 void __iomem *wk_st;
>> =A0 =A0 =A0 void __iomem *wk_en;
>> =A0 =A0 =A0 u32 wk_mask;
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0no_async_wake;
>> =A0};
>>
>> =A0struct uart_omap_dma {
>> @@ -134,6 +135,8 @@ struct uart_omap_port {
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0errata;
>> =A0 =A0 =A0 void (*enable_wakeup)(struct platform_device *, bool);
>> =A0 =A0 =A0 bool (*chk_wakeup)(struct platform_device *);
>> +
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0no_async_wake;
>> =A0};
>>
>> =A0#endif /* __OMAP_SERIAL_H__ */
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/o=
map-serial.c
>> index eea478c..59f548f 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -1168,6 +1168,13 @@ static int serial_omap_suspend(struct device =
*dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_suspend_port(&serial_omap_reg, &up-=
>port);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_trylock();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_pm(&up->port, 3, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* OMAP2 dont have cpu_idle thread and asy=
nc wakeup from prcm.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* For such socs clocks will be kept act=
ive from probe and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* cut only in suspend path.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (up->no_async_wake)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(u=
p);
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 return 0;
>> =A0}
>> @@ -1179,6 +1186,9 @@ static int serial_omap_resume(struct device *d=
ev)
>> =A0 =A0 =A0 if (up) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_resume_port(&serial_omap_reg, &up->=
port);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_unlock();
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (up->no_async_wake)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_enable(up=
);
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 return 0;
>> @@ -1402,6 +1412,7 @@ static int serial_omap_probe(struct platform_d=
evice *pdev)
>> =A0 =A0 =A0 up->errata =3D omap_up_info->errata;
>> =A0 =A0 =A0 up->enable_wakeup =3D omap_up_info->enable_wakeup;
>> =A0 =A0 =A0 up->chk_wakeup =3D omap_up_info->chk_wakeup;
>> + =A0 =A0 up->no_async_wake =3D omap_up_info->no_async_wake;
>>
>> =A0 =A0 =A0 if (omap_up_info->dma_enabled) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.uart_dma_tx =3D dma_tx->sta=
rt;
>> @@ -1430,6 +1441,9 @@ static int serial_omap_probe(struct platform_d=
evice *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (up->no_async_wake)
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_enable(up);
>> +
>> =A0 =A0 =A0 ui[pdev->id] =3D up;
>> =A0 =A0 =A0 serial_omap_add_console_port(up);
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
