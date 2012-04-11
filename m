From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Wed, 11 Apr 2012 18:43:34 +0530
Message-ID: <CAMrsUd+-5_6dFxcj=BCt+gHwnzA7zBev0t_nQ3dQAGZzWq8X0w@mail.gmail.com>
References: <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk>
 <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com>
 <WC20120330075339.4017FC@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
 <WC20120330092609.901834@terrafix.co.uk> <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com>
 <WC20120330110442.381887@terrafix.co.uk> <CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com>
 <CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com>
 <alpine.DEB.2.00.1204040852460.8000@utopia.booyaka.com> <CAMrsUd+WZcUvHGdR4WyF4uh35D17K9DXFAqpLHKBUbL1_5viDA@mail.gmail.com>
 <alpine.DEB.2.00.1204051812320.10302@utopia.booyaka.com> <87iphdeyaf.fsf@ti.com>
 <CAMrsUdLMYVwd3rupHtrNKC0rMvx1-3B=4usOh8cwTUy8DX_hVg@mail.gmail.com>
 <87zkalc75h.fsf@ti.com> <alpine.DEB.2.00.1204090944191.6640@utopia.booyaka.com>
 <874nssde5h.fsf@ti.com> <CAMrsUd+SLko-L=B9gfqSpdcYQrqmAgXa0yFVWrR2YXuW9FBLmQ@mail.gmail.com>
 <87fwcb5urr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51020 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753367Ab2DKNN4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 09:13:56 -0400
Received: by obbef5 with SMTP id ef5so1268518obb.38
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 06:13:54 -0700 (PDT)
In-Reply-To: <87fwcb5urr.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de, linux-serial@vger.kernel.org

On Tue, Apr 10, 2012 at 11:33 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Raja, Govindraj" <govindraj.raja@ti.com> writes:
>
>> Hi Kevin,
>>
>> On Mon, Apr 9, 2012 at 10:40 PM, Kevin Hilman <khilman@ti.com> wrote:
>>> Paul Walmsley <paul@pwsan.com> writes:

[...]

>>
>> Just to summarize on how the behavior should be IIUC if user disables uart
>> wakeup from sysfs and does system wide suspend it should _not_ wakeup
>> from uart.
>
> Correct.
>
>> And if the system is woken up from suspend due to keypad press and
>> uart resumes we have keep module level wakeup enabled from here.
>
> Keypad press, or any other wakeup source, yes.
>
> Basically, UART wakeups (module and IO) should be enabled all the time,
> *except* when suspending and wakeups were disabled by sysfs control.
>

Here is the patch [1] to do the same.

Tested on beagle-XM  with retention and off mode in suspend path and
idle path by disabling/enabling the uart wakeups from sysfs for the console.

--
Thanks,
Govindraj.R

[1]:

>From 4e2502015e8b69d3a5047ae9f92820e4833e6d74 Mon Sep 17 00:00:00 2001
From: "Govindraj.R" <govindraj.raja@ti.com>
Date: Tue, 27 Mar 2012 18:55:00 +0530
Subject: [PATCH] OMAP2+: UART: Correct the module level wakeup enable/disable
 mechanism

The commit (62f3ec5  ARM: OMAP2+: UART: Add wakeup mechanism for omap-uarts)
removed module level wakeup enable/disable mechanism and retained only
the pad wakeup handling.

On 24xx/34xx/36xx Module level wakeup events are enabled/disabled using
PM_WKEN1_CORE/PM_WKEN_PER regs. The module level wakeups are enabled by
default from bootloader, however the wakeups can be enabled/disabled
using sysfs entry
echo disabled > /sys/devices/platform/omap/omap_uart.X/power/wakeup
[X=0,1,2,3]

Since module level wakeups were left enabled from bootup and when
wakeups were disabled from sysfs uart module level wakeups were
still happening as they were not getting disabled.

The wakeup can be left enabled by default and should be disabled only
when disabled from sysfs and thus prevent system from uart wakeup in suspend
path. However in idle path the wakeup can be enabled and thus uart can wakeup
after gating of uart functional clocks.

Thanks to Kevin Hilman <khilman@ti.com> for suggesting this.
Discussion References:
http://www.spinics.net/lists/linux-omap/msg67764.html
http://www.spinics.net/lists/linux-omap/msg67838.html

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c     |   88 +++++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/omap-serial.c |   30 +++++--------
 2 files changed, 97 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0cdd359..9312d6b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -41,6 +41,7 @@
 #include "prm-regbits-34xx.h"
 #include "control.h"
 #include "mux.h"
+#include "iomap.h"

 /*
  * NOTE: By default the serial auto_suspend timeout is disabled as it causes
@@ -55,6 +56,10 @@
 struct omap_uart_state {
 	int num;

+	void __iomem *wk_st;
+	void __iomem *wk_en;
+	u32 wk_mask;
+
 	struct list_head node;
 	struct omap_hwmod *oh;
 };
@@ -80,17 +85,46 @@ static struct omap_uart_port_info
omap_serial_default_info[] __initdata = {
 };

 #ifdef CONFIG_PM
+
+static void omap_uart_disable_module_wakeup(struct omap_uart_state *uart)
+{
+	/* Clear wake-enable bit */
+	if (uart->wk_en && uart->wk_mask) {
+		u32 v = __raw_readl(uart->wk_en);
+		v &= ~uart->wk_mask;
+		__raw_writel(v, uart->wk_en);
+	}
+}
+
+static void omap_uart_enable_module_wakeup(struct omap_uart_state *uart)
+{
+	/* Set wake-enable bit */
+	if (uart->wk_en && uart->wk_mask) {
+		u32 v = __raw_readl(uart->wk_en);
+		v |= uart->wk_mask;
+		__raw_writel(v, uart->wk_en);
+	}
+}
+
 static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
 {
 	struct omap_device *od = to_omap_device(pdev);
+	struct omap_uart_state *uart;

 	if (!od)
 		return;

-	if (enable)
+	list_for_each_entry(uart, &uart_list, node)
+		if (pdev->id == uart->num)
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
@@ -112,7 +146,56 @@ static void omap_uart_set_smartidle(struct
platform_device *pdev)
 	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_SMART);
 }

+static void omap_uart_idle_init(struct omap_uart_state *uart)
+{
+	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
+		u32 mod = (uart->num == 2) ? OMAP3430_PER_MOD : CORE_MOD;
+
+		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
+		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
+		switch (uart->num) {
+		case 0:
+			uart->wk_mask = OMAP3430_ST_UART1_MASK;
+			break;
+		case 1:
+			uart->wk_mask = OMAP3430_ST_UART2_MASK;
+			break;
+		case 2:
+			uart->wk_mask = OMAP3430_ST_UART3_MASK;
+			break;
+		case 3:
+			uart->wk_mask = OMAP3630_ST_UART4_MASK;
+			break;
+		}
+	} else if (cpu_is_omap24xx()) {
+
+		if (cpu_is_omap2430()) {
+			uart->wk_en = OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKEN1);
+			uart->wk_st = OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKST1);
+		} else if (cpu_is_omap2420()) {
+			uart->wk_en = OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKEN1);
+			uart->wk_st = OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKST1);
+		}
+		switch (uart->num) {
+		case 0:
+			uart->wk_mask = OMAP24XX_ST_UART1_MASK;
+			break;
+		case 1:
+			uart->wk_mask = OMAP24XX_ST_UART2_MASK;
+			break;
+		case 2:
+			uart->wk_mask = OMAP24XX_ST_UART3_MASK;
+			break;
+		}
+	} else {
+		uart->wk_en = 0;
+		uart->wk_st = 0;
+		uart->wk_mask = 0;
+	}
+}
+
 #else
+static void omap_uart_idle_init(struct omap_uart_state *uart) {}
 static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
 {}
 static void omap_uart_set_noidle(struct platform_device *pdev) {}
@@ -343,6 +426,7 @@ void __init omap_serial_init_port(struct
omap_board_data *bdata,
 	oh = uart->oh;
 	name = DRIVER_NAME;

+	omap_uart_idle_init(uart);
 	omap_up.dma_enabled = info->dma_enabled;
 	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
 	omap_up.flags = UPF_BOOT_AUTOCONF;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0121486..3dec1cf 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -930,13 +930,6 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);

-	if (!device_may_wakeup(&up->pdev->dev)) {
-		if (!state)
-			pm_runtime_forbid(&up->pdev->dev);
-		else
-			pm_runtime_allow(&up->pdev->dev);
-	}
-
 	pm_runtime_put(&up->pdev->dev);
 }

@@ -1184,10 +1177,16 @@ static struct uart_driver serial_omap_reg = {
 static int serial_omap_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
+	struct omap_uart_port_info *pdata = dev->platform_data;

 	if (up) {
 		uart_suspend_port(&serial_omap_reg, &up->port);
 		flush_work_sync(&up->qos_work);
+
+		if (!device_may_wakeup(dev)) {
+			pdata->enable_wakeup(up->pdev, false);
+			up->wakeups_enabled = false;
+		}
 	}

 	return 0;
@@ -1585,18 +1584,6 @@ static int serial_omap_runtime_suspend(struct
device *dev)
 	if (pdata->get_context_loss_count)
 		up->context_loss_cnt = pdata->get_context_loss_count(dev);

-	if (device_may_wakeup(dev)) {
-		if (!up->wakeups_enabled) {
-			pdata->enable_wakeup(up->pdev, true);
-			up->wakeups_enabled = true;
-		}
-	} else {
-		if (up->wakeups_enabled) {
-			pdata->enable_wakeup(up->pdev, false);
-			up->wakeups_enabled = false;
-		}
-	}
-
 	/* Errata i291 */
 	if (up->use_dma && pdata->set_forceidle &&
 			(up->errata & UART_ERRATA_i291_DMA_FORCEIDLE))
@@ -1621,6 +1608,11 @@ static int serial_omap_runtime_resume(struct device *dev)
 				serial_omap_restore_context(up);
 		}

+		if (!up->wakeups_enabled) {
+			pdata->enable_wakeup(up->pdev, true);
+			up->wakeups_enabled = true;
+		}
+
 		/* Errata i291 */
 		if (up->use_dma && pdata->set_noidle &&
 				(up->errata & UART_ERRATA_i291_DMA_FORCEIDLE))
-- 
1.7.9
