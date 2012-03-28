From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Wed, 28 Mar 2012 16:29:53 +0530
Message-ID: <CAMrsUdKXZL4nT0MW=BcD53PsQFE+W1inij3XWe0e5+BjJF3odg@mail.gmail.com>
References: <WC20120322110946.6413AA@terrafix.co.uk> <87r4wka6bf.fsf@ti.com>
 <WC20120326134115.9815DF@terrafix.co.uk> <87haxaq3ua.fsf@ti.com>
 <CAMrsUd++maNjaK87bcRUqVHtz5zySujQXZK1YaMH9vnHVWCDag@mail.gmail.com> <878viln2t5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:40447 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752648Ab2C1LAQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 07:00:16 -0400
Received: by mail-ob0-f178.google.com with SMTP id uo19so1306182obb.9
        for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 04:00:14 -0700 (PDT)
In-Reply-To: <878viln2t5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

On Wed, Mar 28, 2012 at 3:07 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Raja, Govindraj" <govindraj.raja@ti.com> writes:
>
>> Hi Kevin,
>>
>> On Tue, Mar 27, 2012 at 6:04 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> +Govindraj,
>>>
>>> "Joe Woodward" <jw@terrafix.co.uk> writes:
>>>
>>>> Right, I've stepped back a bit and dug out a GUSMTIX Palo43 carrie=
r
>>>> board on which to test the Overo OMAP3530 COM and I've found:
>>>> =A0- Running a stock 3.3 (with absolutely no changes) does indeed =
suspend correctly.
>>>> =A0- Running the 3.3 kernel with my (minor) board modifications
>>>> =A0(basically defining some buttons) suspends correctly as well.
>>>>
>>>> Then I went back to my original board and the 3.3 still wakes up f=
rom
>>>> suspend immediately. So I had a think, and the only real differenc=
es
>>>> between my board the the GUMSTIX Palo43 board is that I am using
>>>> multiple UARTs.
>>>>
>>>> Up to this point I've only wanted to wake on the console (ttyO2), =
and
>>>> not any other UARTs so I've stopped them waking with:
>>>> =A0 echo disabled > /sys/devices/platform/omap/omap_uart.0/power/w=
akeup
>>>> =A0 echo disabled > /sys/devices/platform/omap/omap_uart.1/power/w=
akeup
>>>>
>>>> I wanted to check that this still worked, so tried disabling wakeu=
p on
>>>> the console (ttyO2):
>>>> =A0 echo disabled > /sys/devices/platform/omap/omap_uart.2/power/w=
akeup
>>>>
>>>> And if I do "echo mem > /sys/power/state" I was expecting to stay =
in
>>>> suspend when I typed on my keyboard... However, the kernel still w=
oke
>>>> from suspend, which leads me to believe that the UART wakeup hasn'=
t
>>>> been disabled?
>>>
>>> Just to confirm: did the above work for you before v3.3?
>>>
>>>> Could you test if this is also the case your end?
>>>
>>> Yes, I get the same behavior, which is indeed broken.
>>>
>>> Govindraj, can you look into this?
>>>
>>> A quick glance suggests that disabling wakeups via the sysfs file i=
s
>>> only disabling runtime PM, but not actually disabling wakups at the
>>> module-level or at the IO ring.
>>>
>>
>> I have started looking into this, disabling and enabling of wake-ups
>> from .runtime_suspend needs some changes as in here[1] with that I s=
ee pad
>> wakeup getting disabled and it doesn't wake up after enabling off mo=
de
>> and suspending.
>
> Thanks for looking into this.
>

Looks like the module wakeup event handling left to default
value during runtime clean up is causing the wakeup to happen

Here is the patch[1] to fix the same tested on 3430SDP.

--
Thanks,
Govindraj.R

[1]:


=46rom 5a5126750d527811547a45de9546c3e0f0fac77d Mon Sep 17 00:00:00 200=
1
=46rom: "Govindraj.R" <govindraj.raja@ti.com>
Date: Tue, 27 Mar 2012 18:55:00 +0530
Subject: [PATCH] OMAP2+: UART: Correct the module level wakeup enable/d=
isable
 mechanism

The commit (62f3ec5  ARM: OMAP2+: UART: Add wakeup mechanism for omap-u=
arts)
removed module level wakeup enable/disable mechanism and retained only
the pad wakeup handling.

On 24xx/34xx/36xx Module level wakeup events are enabled/disabled using
PM_WKEN1_CORE/PM_WKEN_PER regs. The module level wakeups are enabled by
default from bootloader, however the wakeups can be enabled/disabled
using sysfs entry
echo disabled > /sys/devices/platform/omap/omap_uart.X/power/wakeup
[X=3D0,1,2,3]

Since module level wakeups were left enabled from bootup and when
wakeups were disabled from sysfs uart module level wakeups were
still happening as they were not getting disabled.

Adding the support to handle module level wakeups for omap2/3 socs.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   95 ++++++++++++++++++++++++++++++++++=
+++++++-
 1 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index f590afc..92ff94c 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -56,6 +56,10 @@ struct omap_uart_state {
 	int num;
 	int can_sleep;

+	void __iomem *wk_st;
+	void __iomem *wk_en;
+	u32 wk_mask;
+
 	struct list_head node;
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
@@ -82,17 +86,46 @@ static struct omap_uart_port_info
omap_serial_default_info[] __initdata =3D {
 };

 #ifdef CONFIG_PM
+
+static void omap_uart_disable_module_wakeup(struct omap_uart_state *ua=
rt)
+{
+	/* Clear wake-enable bit */
+	if (uart->wk_en && uart->wk_mask) {
+		u32 v =3D __raw_readl(uart->wk_en);
+		v &=3D ~uart->wk_mask;
+		__raw_writel(v, uart->wk_en);
+	}
+}
+
+static void omap_uart_enable_module_wakeup(struct omap_uart_state *uar=
t)
+{
+	/* Set wake-enable bit */
+	if (uart->wk_en && uart->wk_mask) {
+		u32 v =3D __raw_readl(uart->wk_en);
+		v |=3D uart->wk_mask;
+		__raw_writel(v, uart->wk_en);
+	}
+}
+
 static void omap_uart_enable_wakeup(struct platform_device *pdev, bool=
 enable)
 {
 	struct omap_device *od =3D to_omap_device(pdev);
+	struct omap_uart_state *uart;

 	if (!od)
 		return;

-	if (enable)
+	list_for_each_entry(uart, &uart_list, node)
+		if (pdev->id =3D=3D uart->num)
+			break;
+
+	if (enable) {
+		omap_uart_enable_module_wakeup(uart);
 		omap_hwmod_enable_wakeup(od->hwmods[0]);
-	else
+	} else {
+		omap_uart_disable_module_wakeup(uart);
 		omap_hwmod_disable_wakeup(od->hwmods[0]);
+	}
 }

 /*
@@ -114,7 +147,64 @@ static void omap_uart_set_smartidle(struct
platform_device *pdev)
 	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_SMART);
 }

+static void omap_uart_idle_init(struct omap_uart_state *uart)
+{
+	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
+		u32 mod =3D (uart->num =3D=3D 2) ? OMAP3430_PER_MOD : CORE_MOD;
+
+		uart->wk_en =3D OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
+		uart->wk_st =3D OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
+		switch (uart->num) {
+		case 0:
+			uart->wk_mask =3D OMAP3430_ST_UART1_MASK;
+			break;
+		case 1:
+			uart->wk_mask =3D OMAP3430_ST_UART2_MASK;
+			break;
+		case 2:
+			uart->wk_mask =3D OMAP3430_ST_UART3_MASK;
+			break;
+		case 3:
+			uart->wk_mask =3D OMAP3630_ST_UART4_MASK;
+			break;
+		}
+	} else if (cpu_is_omap24xx()) {
+
+		if (cpu_is_omap2430()) {
+			uart->wk_en =3D OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKEN1);
+			uart->wk_st =3D OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKST1);
+		} else if (cpu_is_omap2420()) {
+			uart->wk_en =3D OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKEN1);
+			uart->wk_st =3D OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKST1);
+		}
+		switch (uart->num) {
+		case 0:
+			uart->wk_mask =3D OMAP24XX_ST_UART1_MASK;
+			break;
+		case 1:
+			uart->wk_mask =3D OMAP24XX_ST_UART2_MASK;
+			break;
+		case 2:
+			uart->wk_mask =3D OMAP24XX_ST_UART3_MASK;
+			break;
+		}
+	} else {
+		uart->wk_en =3D 0;
+		uart->wk_st =3D 0;
+		uart->wk_mask =3D 0;
+	}
+
+	/* Module level wakeups might be left enabled from
+	 * bootloader disable it. Module level wakeup/pad_wakeup
+	 * will be enabled if port is wakeup capaable after gating uart
+	 * port clocks from omap-serial driver.
+	 * Wakeup capability can be enabled or disbaled using sysfs entry.
+	 */
+	omap_uart_disable_module_wakeup(uart);
+}
+
 #else
+static void omap_uart_idle_init(struct omap_uart_state *uart) {}
 static void omap_uart_enable_wakeup(struct platform_device *pdev, bool=
 enable)
 {}
 static void omap_uart_set_noidle(struct platform_device *pdev) {}
@@ -345,6 +435,7 @@ void __init omap_serial_init_port(struct
omap_board_data *bdata,
 	oh =3D uart->oh;
 	name =3D DRIVER_NAME;

+	omap_uart_idle_init(uart);
 	omap_up.dma_enabled =3D info->dma_enabled;
 	omap_up.uartclk =3D OMAP24XX_BASE_BAUD * 16;
 	omap_up.flags =3D UPF_BOOT_AUTOCONF;
--=20
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
