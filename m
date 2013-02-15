From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Fri, 15 Feb 2013 07:40:04 -0800
Message-ID: <87obfl60x7.fsf@linaro.org>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
	<1360840554-26901-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:48112 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932605Ab3BOPkH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 10:40:07 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so647778pbb.6
        for <linux-omap@vger.kernel.org>; Fri, 15 Feb 2013 07:40:06 -0800 (PST)
In-Reply-To: <1360840554-26901-2-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Thu, 14 Feb 2013 13:15:53 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Felipe Balbi <balbi@ti.com> writes:

> Currently the omap-serial driver will not
> work properly if booted via DT with CPUIDLE
> enabled because it depends on function pointers
> provided by hwmod to change its own SYSCONFIG
> register.
>
> Remove that relyance on hwmod by moving SYSCONFIG
> handling to driver itself. Note that this also
> fixes a possible corner case bug where we could
> be putting UART in Force Idle mode if we called
> omap_serial_enable_wakeup(up, false) after setting
> NOIDLE to the idle mode. This is because hwmod
> has no protection against that situation.
>
> NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>

Here's another approach to getting rid of the sysconfig twiddling in the
driver.  I wrote this some time ago at my former company ;) but don't
think I ever got around to posting it.

It doesn't solve the whole problem (e.g. doesn't address the
context_loss or enable_wakeup func pointers), but at least gets rid of
the need for any SYSCONFIG access in the driver for the idle modes.

Needs more thorough testing.

Kevin


>From 3d3956472d2375b5ed939d1d0165e439aa47262f Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Wed, 26 Sep 2012 18:36:43 -0700
Subject: [PATCH] ARM: OMAP2+: serial/hwmod: use SW supported slave idle for
 all UARTs

Due to various errata, we have several hacks involving modifying the
slave idle mode of the UARTs at runtime.  Since the UART driver has
been using the autosuspend feature of runtime PM, each UART is kept in
NO_IDLE during activity, and SMART_IDLE during activity.

The omap_hwmod layer has the per-device HWMOD_SWSUP_SIDLE flag which
will have the exact same behavior, with the benefit of simplifying the
device and driver layers.  Switch to using hwmod to automatically
manage the slave idle mode.

This also enables the removal of a couple pdata function pointers from
the driver, which facilitates the conversion to device tree.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  3 ++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  4 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  4 +++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  4 +++
 arch/arm/mach-omap2/serial.c                       | 35 ----------------------
 arch/arm/plat-omap/include/plat/omap-serial.h      |  2 --
 drivers/tty/serial/omap-serial.c                   | 23 --------------
 7 files changed, 15 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index bd9220e..0d3c1a6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -509,6 +509,7 @@ struct omap_hwmod omap2xxx_uart1_hwmod = {
 		},
 	},
 	.class		= &omap2_uart_class,
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* UART2 */
@@ -528,6 +529,7 @@ struct omap_hwmod omap2xxx_uart2_hwmod = {
 		},
 	},
 	.class		= &omap2_uart_class,
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* UART3 */
@@ -547,6 +549,7 @@ struct omap_hwmod omap2xxx_uart3_hwmod = {
 		},
 	},
 	.class		= &omap2_uart_class,
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* dss */
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 59d5c1c..1a41f93 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -1903,6 +1903,7 @@ static struct omap_hwmod am33xx_uart1_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 static struct omap_hwmod_irq_info am33xx_uart2_irqs[] = {
@@ -1923,6 +1924,7 @@ static struct omap_hwmod am33xx_uart2_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* uart3 */
@@ -1950,6 +1952,7 @@ static struct omap_hwmod am33xx_uart3_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 static struct omap_hwmod_irq_info am33xx_uart4_irqs[] = {
@@ -1970,6 +1973,7 @@ static struct omap_hwmod am33xx_uart4_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 static struct omap_hwmod_irq_info am33xx_uart5_irqs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index f67b7ee..99ada6a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -497,6 +497,7 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 		},
 	},
 	.class		= &omap2_uart_class,
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* UART2 */
@@ -515,6 +516,7 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 		},
 	},
 	.class		= &omap2_uart_class,
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* UART3 */
@@ -533,6 +535,7 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 		},
 	},
 	.class		= &omap2_uart_class,
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* UART4 */
@@ -562,6 +565,7 @@ static struct omap_hwmod omap36xx_uart4_hwmod = {
 		},
 	},
 	.class		= &omap2_uart_class,
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 static struct omap_hwmod_irq_info am35xx_uart4_mpu_irqs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 652d028..5373e58 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3397,6 +3397,7 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* uart2 */
@@ -3425,6 +3426,7 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* uart3 */
@@ -3454,6 +3456,7 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* uart4 */
@@ -3482,6 +3485,7 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index a507cd6..e9d69a9 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -94,39 +94,6 @@ static void omap_uart_enable_wakeup(struct device *dev, bool enable)
 	else
 		omap_hwmod_disable_wakeup(od->hwmods[0]);
 }
-
-/*
- * Errata i291: [UART]:Cannot Acknowledge Idle Requests
- * in Smartidle Mode When Configured for DMA Operations.
- * WA: configure uart in force idle mode.
- */
-static void omap_uart_set_noidle(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_device *od = to_omap_device(pdev);
-
-	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_NO);
-}
-
-static void omap_uart_set_smartidle(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_device *od = to_omap_device(pdev);
-	u8 idlemode;
-
-	if (od->hwmods[0]->class->sysc->idlemodes & SIDLE_SMART_WKUP)
-		idlemode = HWMOD_IDLEMODE_SMART_WKUP;
-	else
-		idlemode = HWMOD_IDLEMODE_SMART;
-
-	omap_hwmod_set_slave_idlemode(od->hwmods[0], idlemode);
-}
-
-#else
-static void omap_uart_enable_wakeup(struct device *dev, bool enable)
-{}
-static void omap_uart_set_noidle(struct device *dev) {}
-static void omap_uart_set_smartidle(struct device *dev) {}
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_OMAP_MUX
@@ -299,8 +266,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
 	omap_up.flags = UPF_BOOT_AUTOCONF;
 	omap_up.get_context_loss_count = omap_pm_get_dev_context_loss_count;
-	omap_up.set_forceidle = omap_uart_set_smartidle;
-	omap_up.set_noidle = omap_uart_set_noidle;
 	omap_up.enable_wakeup = omap_uart_enable_wakeup;
 	omap_up.dma_rx_buf_size = info->dma_rx_buf_size;
 	omap_up.dma_rx_timeout = info->dma_rx_timeout;
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 1957a85..b9a712c 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -72,8 +72,6 @@ struct omap_uart_port_info {
 	int			DTR_present;
 
 	int (*get_context_loss_count)(struct device *);
-	void (*set_forceidle)(struct device *);
-	void (*set_noidle)(struct device *);
 	void (*enable_wakeup)(struct device *, bool);
 };
 
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6d3d26a..8e4e39f 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -151,26 +151,6 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
 	return pdata->get_context_loss_count(up->dev);
 }
 
-static void serial_omap_set_forceidle(struct uart_omap_port *up)
-{
-	struct omap_uart_port_info *pdata = up->dev->platform_data;
-
-	if (!pdata || !pdata->set_forceidle)
-		return;
-
-	pdata->set_forceidle(up->dev);
-}
-
-static void serial_omap_set_noidle(struct uart_omap_port *up)
-{
-	struct omap_uart_port_info *pdata = up->dev->platform_data;
-
-	if (!pdata || !pdata->set_noidle)
-		return;
-
-	pdata->set_noidle(up->dev);
-}
-
 static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 {
 	struct omap_uart_port_info *pdata = up->dev->platform_data;
@@ -229,8 +209,6 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		serial_out(up, UART_IER, up->ier);
 	}
 
-	serial_omap_set_forceidle(up);
-
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 }
@@ -298,7 +276,6 @@ static void serial_omap_start_tx(struct uart_port *port)
 
 	pm_runtime_get_sync(up->dev);
 	serial_omap_enable_ier_thri(up);
-	serial_omap_set_noidle(up);
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 }
-- 
1.8.1.2

