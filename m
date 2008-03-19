From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/7] I2C: TWL4030: Move twl4030's headers under include/linux/i2c/
Date: Wed, 19 Mar 2008 15:42:29 +0200
Message-ID: <1205934155-24070-2-git-send-email-felipe.balbi@nokia.com>
References: <1205934155-24070-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-fb01.nokia.com ([192.100.122.235]:45423 "EHLO
	mgw-fb01.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbYCSToz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 15:44:55 -0400
Received: from mgw-mx03.nokia.com (mgw-mx03.nokia.com [192.100.122.230])
	by mgw-fb01.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2JEHQkn030410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 16:17:27 +0200
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2JDjhBd003138
	for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 15:45:55 +0200
In-Reply-To: <1205934155-24070-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Now that we have this directory we can use it

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c         |    2 +-
 arch/arm/mach-omap2/board-sdp-hsmmc.c       |    2 +-
 drivers/i2c/chips/twl4030_core.c            |    2 +-
 drivers/i2c/chips/twl4030_gpio.c            |    2 +-
 drivers/i2c/chips/twl4030_poweroff.c        |    2 +-
 drivers/i2c/chips/twl4030_usb.c             |    2 +-
 drivers/input/keyboard/omap-twl4030keypad.c |    2 +-
 drivers/rtc/rtc-twl4030.c                   |    4 +-
 include/asm-arm/arch-omap/twl4030-rtc.h     |  230 ---------------------------
 include/asm-arm/arch-omap/twl4030.h         |  118 --------------
 include/linux/i2c/twl4030-rtc.h             |  230 +++++++++++++++++++++++++++
 include/linux/i2c/twl4030.h                 |  118 ++++++++++++++
 12 files changed, 357 insertions(+), 357 deletions(-)
 delete mode 100644 include/asm-arm/arch-omap/twl4030-rtc.h
 delete mode 100644 include/asm-arm/arch-omap/twl4030.h
 create mode 100644 include/linux/i2c/twl4030-rtc.h
 create mode 100644 include/linux/i2c/twl4030.h

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index f3a316f..1eb84a6 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -20,6 +20,7 @@
 #include <linux/workqueue.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/i2c/twl4030.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
@@ -28,7 +29,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <asm/arch/twl4030.h>
 #include <asm/arch/mcspi.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
diff --git a/arch/arm/mach-omap2/board-sdp-hsmmc.c b/arch/arm/mach-omap2/board-sdp-hsmmc.c
index 90e8def..49f454f 100644
--- a/arch/arm/mach-omap2/board-sdp-hsmmc.c
+++ b/arch/arm/mach-omap2/board-sdp-hsmmc.c
@@ -13,8 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/i2c/twl4030.h>
 #include <asm/hardware.h>
-#include <asm/arch/twl4030.h>
 #include <asm/arch/mmc.h>
 #include <asm/arch/board.h>
 #include <asm/io.h>
diff --git a/drivers/i2c/chips/twl4030_core.c b/drivers/i2c/chips/twl4030_core.c
index e733195..4f0f465 100644
--- a/drivers/i2c/chips/twl4030_core.c
+++ b/drivers/i2c/chips/twl4030_core.c
@@ -38,6 +38,7 @@
 #include <linux/kthread.h>
 
 #include <linux/i2c.h>
+#include <linux/i2c/twl4030.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -45,7 +46,6 @@
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 
-#include <asm/arch/twl4030.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
 
diff --git a/drivers/i2c/chips/twl4030_gpio.c b/drivers/i2c/chips/twl4030_gpio.c
index 9054cc9..a9f3b1d 100644
--- a/drivers/i2c/chips/twl4030_gpio.c
+++ b/drivers/i2c/chips/twl4030_gpio.c
@@ -36,9 +36,9 @@
 #include <linux/kthread.h>
 
 #include <linux/i2c.h>
+#include <linux/i2c/twl4030.h>
 #include <linux/slab.h>
 
-#include <asm/arch/twl4030.h>
 #include <asm/arch/irqs.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
diff --git a/drivers/i2c/chips/twl4030_poweroff.c b/drivers/i2c/chips/twl4030_poweroff.c
index 7a176d9..dbe413a 100644
--- a/drivers/i2c/chips/twl4030_poweroff.c
+++ b/drivers/i2c/chips/twl4030_poweroff.c
@@ -23,7 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/pm.h>
-#include <asm/arch/twl4030.h>
+#include <linux/i2c/twl4030.h>
 
 #define PWR_P1_SW_EVENTS	0x10
 #define PWR_DEVOFF	(1<<0)
diff --git a/drivers/i2c/chips/twl4030_usb.c b/drivers/i2c/chips/twl4030_usb.c
index b3365f6..cf86d3e 100644
--- a/drivers/i2c/chips/twl4030_usb.c
+++ b/drivers/i2c/chips/twl4030_usb.c
@@ -29,7 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/usb.h>
 
-#include <asm/arch/twl4030.h>
+#include <linux/i2c/twl4030.h>
 
 /* Register defines */
 
diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
index 4750dba..3bc3045 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -33,9 +33,9 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/i2c/twl4030.h>
 #include <asm/irq.h>
 #include <asm/arch/keypad.h>
-#include <asm/arch/twl4030.h>
 #include "twl4030-keypad.h"
 
 #define OMAP_TWL4030KP_LOG_LEVEL	0
diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
index b50de5f..929a788 100644
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -34,14 +34,14 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl4030-rtc.h>
 
 #include <asm/io.h>
 #include <asm/mach/time.h>
 #include <asm/system.h>
 #include <asm/hardware.h>
 #include <asm/irq.h>
-#include <asm/arch/twl4030.h>
-#include <asm/arch/twl4030-rtc.h>
 
 #define ALL_TIME_REGS		6
 
diff --git a/include/asm-arm/arch-omap/twl4030-rtc.h b/include/asm-arm/arch-omap/twl4030-rtc.h
deleted file mode 100644
index f3d96b3..0000000
--- a/include/asm-arm/arch-omap/twl4030-rtc.h
+++ /dev/null
@@ -1,230 +0,0 @@
-/*
- * include/asm-arm/arch-omap/twl4030-rtc.h
- *
- * Copyright (C) 2006 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __TWL4030_RTC_H__
-#define __TWL4030_RTC_H__
-
-#define REG_SECONDS_REG                          (0x0)
-#define REG_MINUTES_REG                          (0x1)
-#define REG_HOURS_REG                            (0x2)
-#define REG_DAYS_REG                             (0x3)
-#define REG_MONTHS_REG                           (0x4)
-#define REG_YEARS_REG                            (0x5)
-#define REG_WEEKS_REG                            (0x6)
-#define REG_ALARM_SECONDS_REG                    (0x7)
-#define REG_ALARM_MINUTES_REG                    (0x8)
-#define REG_ALARM_HOURS_REG                      (0x9)
-#define REG_ALARM_DAYS_REG                       (0xA)
-#define REG_ALARM_MONTHS_REG                     (0xB)
-#define REG_ALARM_YEARS_REG                      (0xC)
-#define REG_RTC_CTRL_REG                         (0xD)
-#define REG_RTC_STATUS_REG                       (0xE)
-#define REG_RTC_INTERRUPTS_REG                   (0xF)
-#define REG_RTC_COMP_LSB_REG                     (0x10)
-#define REG_RTC_COMP_MSB_REG                     (0x11)
-
-/* REVISIT: these TWL4030 power registers are only used
- * by rtc-twl4030 driver, move to an appropriate header
- * if other drivers need the registers
- */
-/* Power registers */
-#define REG_PWR_ISR1		0x00
-#define REG_PWR_IMR1		0x01
-#define REG_PWR_EDR1		0x05
-
-#define PWR_RTC_IT_UNMASK	 ~(0x08)
-#define PWR_RTC_INT_CLR          0x08
-
-/**** BitField Definitions */
-/* SECONDS_REG Fields */
-#define BIT_SECONDS_REG_SEC0                     (0x000)
-#define BIT_SECONDS_REG_SEC0_M                   (0x0000000F)
-#define BIT_SECONDS_REG_SEC1                     (0x004)
-#define BIT_SECONDS_REG_SEC1_M                   (0x00000070)
-/* MINUTES_REG Fields */
-#define BIT_MINUTES_REG_MIN0                     (0x000)
-#define BIT_MINUTES_REG_MIN0_M                   (0x0000000F)
-#define BIT_MINUTES_REG_MIN1                     (0x004)
-#define BIT_MINUTES_REG_MIN1_M                   (0x00000070)
-/* HOURS_REG Fields */
-#define BIT_HOURS_REG_HOUR0                      (0x000)
-#define BIT_HOURS_REG_HOUR0_M                    (0x0000000F)
-#define BIT_HOURS_REG_HOUR1                      (0x004)
-#define BIT_HOURS_REG_HOUR1_M                    (0x00000030)
-#define BIT_HOURS_REG_PM_NAM                     (0x007)
-#define BIT_HOURS_REG_PM_NAM_M                   (0x00000080)
-/* DAYS_REG Fields */
-#define BIT_DAYS_REG_DAY0                        (0x000)
-#define BIT_DAYS_REG_DAY0_M                      (0x0000000F)
-#define BIT_DAYS_REG_DAY1                        (0x004)
-#define BIT_DAYS_REG_DAY1_M                      (0x00000030)
-/* MONTHS_REG Fields */
-#define BIT_MONTHS_REG_MONTH0                    (0x000)
-#define BIT_MONTHS_REG_MONTH0_M                  (0x0000000F)
-#define BIT_MONTHS_REG_MONTH1                    (0x004)
-#define BIT_MONTHS_REG_MONTH1_M                  (0x00000010)
-/* YEARS_REG Fields */
-#define BIT_YEARS_REG_YEAR0                      (0x000)
-#define BIT_YEARS_REG_YEAR0_M                    (0x0000000F)
-#define BIT_YEARS_REG_YEAR1                      (0x004)
-#define BIT_YEARS_REG_YEAR1_M                    (0x000000F0)
-/* WEEKS_REG Fields */
-#define BIT_WEEKS_REG_WEEK                       (0x000)
-#define BIT_WEEKS_REG_WEEK_M                     (0x00000007)
-/* ALARM_SECONDS_REG Fields */
-#define BIT_ALARM_SECONDS_REG_ALARM_SEC0         (0x000)
-#define BIT_ALARM_SECONDS_REG_ALARM_SEC0_M       (0x0000000F)
-#define BIT_ALARM_SECONDS_REG_ALARM_SEC1         (0x004)
-#define BIT_ALARM_SECONDS_REG_ALARM_SEC1_M       (0x00000070)
-/* ALARM_MINUTES_REG Fields */
-#define BIT_ALARM_MINUTES_REG_ALARM_MIN0         (0x000)
-#define BIT_ALARM_MINUTES_REG_ALARM_MIN0_M       (0x0000000F)
-#define BIT_ALARM_MINUTES_REG_ALARM_MIN1         (0x004)
-#define BIT_ALARM_MINUTES_REG_ALARM_MIN1_M       (0x00000070)
-/* ALARM_HOURS_REG Fields */
-#define BIT_ALARM_HOURS_REG_ALARM_HOUR0          (0x000)
-#define BIT_ALARM_HOURS_REG_ALARM_HOUR0_M        (0x0000000F)
-#define BIT_ALARM_HOURS_REG_ALARM_HOUR1          (0x004)
-#define BIT_ALARM_HOURS_REG_ALARM_HOUR1_M        (0x00000030)
-#define BIT_ALARM_HOURS_REG_ALARM_PM_NAM         (0x007)
-#define BIT_ALARM_HOURS_REG_ALARM_PM_NAM_M       (0x00000080)
-/* ALARM_DAYS_REG Fields */
-#define BIT_ALARM_DAYS_REG_ALARM_DAY0            (0x000)
-#define BIT_ALARM_DAYS_REG_ALARM_DAY0_M          (0x0000000F)
-#define BIT_ALARM_DAYS_REG_ALARM_DAY1            (0x004)
-#define BIT_ALARM_DAYS_REG_ALARM_DAY1_M          (0x00000030)
-/* ALARM_MONTHS_REG Fields */
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0        (0x000)
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0_M      (0x0000000F)
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1        (0x004)
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1_M      (0x00000010)
-/* ALARM_YEARS_REG Fields */
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR0          (0x000)
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR0_M        (0x0000000F)
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR1          (0x004)
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR1_M        (0x000000F0)
-/* RTC_CTRL_REG Fields */
-#define BIT_RTC_CTRL_REG_STOP_RTC                (0x000)
-#define BIT_RTC_CTRL_REG_STOP_RTC_M              (0x00000001)
-#define BIT_RTC_CTRL_REG_ROUND_30S               (0x001)
-#define BIT_RTC_CTRL_REG_ROUND_30S_M             (0x00000002)
-#define BIT_RTC_CTRL_REG_AUTO_COMP               (0x002)
-#define BIT_RTC_CTRL_REG_AUTO_COMP_M             (0x00000004)
-#define BIT_RTC_CTRL_REG_MODE_12_24              (0x003)
-#define BIT_RTC_CTRL_REG_MODE_12_24_M            (0x00000008)
-#define BIT_RTC_CTRL_REG_TEST_MODE               (0x004)
-#define BIT_RTC_CTRL_REG_TEST_MODE_M             (0x00000010)
-#define BIT_RTC_CTRL_REG_SET_32_COUNTER          (0x005)
-#define BIT_RTC_CTRL_REG_SET_32_COUNTER_M        (0x00000020)
-#define BIT_RTC_CTRL_REG_GET_TIME                (0x006)
-#define BIT_RTC_CTRL_REG_GET_TIME_M              (0x00000040)
-/* RTC_STATUS_REG Fields */
-#define BIT_RTC_STATUS_REG_RUN                   (0x001)
-#define BIT_RTC_STATUS_REG_RUN_M                 (0x00000002)
-#define BIT_RTC_STATUS_REG_1S_EVENT              (0x002)
-#define BIT_RTC_STATUS_REG_1S_EVENT_M            (0x00000004)
-#define BIT_RTC_STATUS_REG_1M_EVENT              (0x003)
-#define BIT_RTC_STATUS_REG_1M_EVENT_M            (0x00000008)
-#define BIT_RTC_STATUS_REG_1H_EVENT              (0x004)
-#define BIT_RTC_STATUS_REG_1H_EVENT_M            (0x00000010)
-#define BIT_RTC_STATUS_REG_1D_EVENT              (0x005)
-#define BIT_RTC_STATUS_REG_1D_EVENT_M            (0x00000020)
-#define BIT_RTC_STATUS_REG_ALARM                 (0x006)
-#define BIT_RTC_STATUS_REG_ALARM_M               (0x00000040)
-#define BIT_RTC_STATUS_REG_POWER_UP              (0x007)
-#define BIT_RTC_STATUS_REG_POWER_UP_M            (0x00000080)
-
-/* RTC_INTERRUPTS_REG Fields */
-#define BIT_RTC_INTERRUPTS_REG_EVERY             (0x000)
-#define BIT_RTC_INTERRUPTS_REG_EVERY_M           (0x00000003)
-#define BIT_RTC_INTERRUPTS_REG_IT_TIMER          (0x002)
-#define BIT_RTC_INTERRUPTS_REG_IT_TIMER_M        (0x00000004)
-#define BIT_RTC_INTERRUPTS_REG_IT_ALARM          (0x003)
-#define BIT_RTC_INTERRUPTS_REG_IT_ALARM_M        (0x00000008)
-/* RTC_COMP_LSB_REG Fields */
-#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB        (0x000)
-#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB_M      (0x000000FF)
-/* RTC_COMP_MSB_REG Fields */
-#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB        (0x000)
-#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB_M      (0x000000FF)
-
-/* ALARM_DAYS_REG Fields */
-#define BIT_ALARM_DAYS_REG_ALARM_DAY1            (0x004)
-#define BIT_ALARM_DAYS_REG_ALARM_DAY1_M          (0x00000030)
-/* ALARM_MONTHS_REG Fields */
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0        (0x000)
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0_M      (0x0000000F)
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1        (0x004)
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1_M      (0x00000010)
-/* ALARM_YEARS_REG Fields */
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR0          (0x000)
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR0_M        (0x0000000F)
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR1          (0x004)
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR1_M        (0x000000F0)
-/* RTC_CTRL_REG Fields */
-#define BIT_RTC_CTRL_REG_STOP_RTC                (0x000)
-#define BIT_RTC_CTRL_REG_STOP_RTC_M              (0x00000001)
-#define BIT_RTC_CTRL_REG_ROUND_30S               (0x001)
-#define BIT_RTC_CTRL_REG_ROUND_30S_M             (0x00000002)
-#define BIT_RTC_CTRL_REG_AUTO_COMP               (0x002)
-#define BIT_RTC_CTRL_REG_AUTO_COMP_M             (0x00000004)
-#define BIT_RTC_CTRL_REG_MODE_12_24              (0x003)
-#define BIT_RTC_CTRL_REG_MODE_12_24_M            (0x00000008)
-#define BIT_RTC_CTRL_REG_TEST_MODE               (0x004)
-#define BIT_RTC_CTRL_REG_TEST_MODE_M             (0x00000010)
-#define BIT_RTC_CTRL_REG_SET_32_COUNTER          (0x005)
-#define BIT_RTC_CTRL_REG_SET_32_COUNTER_M        (0x00000020)
-#define BIT_RTC_CTRL_REG_GET_TIME                (0x006)
-#define BIT_RTC_CTRL_REG_GET_TIME_M              (0x00000040)
-/* RTC_STATUS_REG Fields */
-#define BIT_RTC_STATUS_REG_RUN                   (0x001)
-#define BIT_RTC_STATUS_REG_RUN_M                 (0x00000002)
-#define BIT_RTC_STATUS_REG_1S_EVENT              (0x002)
-#define BIT_RTC_STATUS_REG_1S_EVENT_M            (0x00000004)
-#define BIT_RTC_STATUS_REG_1M_EVENT              (0x003)
-#define BIT_RTC_STATUS_REG_1M_EVENT_M            (0x00000008)
-#define BIT_RTC_STATUS_REG_1H_EVENT              (0x004)
-#define BIT_RTC_STATUS_REG_1H_EVENT_M            (0x00000010)
-#define BIT_RTC_STATUS_REG_1D_EVENT              (0x005)
-#define BIT_RTC_STATUS_REG_1D_EVENT_M            (0x00000020)
-#define BIT_RTC_STATUS_REG_ALARM                 (0x006)
-#define BIT_RTC_STATUS_REG_ALARM_M               (0x00000040)
-#define BIT_RTC_STATUS_REG_POWER_UP              (0x007)
-#define BIT_RTC_STATUS_REG_POWER_UP_M            (0x00000080)
-/* RTC_INTERRUPTS_REG Fields */
-#define BIT_RTC_INTERRUPTS_REG_EVERY             (0x000)
-#define BIT_RTC_INTERRUPTS_REG_EVERY_M           (0x00000003)
-#define BIT_RTC_INTERRUPTS_REG_IT_TIMER          (0x002)
-#define BIT_RTC_INTERRUPTS_REG_IT_TIMER_M        (0x00000004)
-#define BIT_RTC_INTERRUPTS_REG_IT_ALARM          (0x003)
-#define BIT_RTC_INTERRUPTS_REG_IT_ALARM_M        (0x00000008)
-/* RTC_COMP_LSB_REG Fields */
-#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB        (0x000)
-#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB_M      (0x000000FF)
-/* RTC_COMP_MSB_REG Fields */
-#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB        (0x000)
-#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB_M      (0x000000FF)
-
-
-struct twl4030rtc_platform_data {
-        int (*init)(void);
-        void (*exit)(void);
-};
-
-#endif				/* End of __TWL4030_RTC_H__ */
diff --git a/include/asm-arm/arch-omap/twl4030.h b/include/asm-arm/arch-omap/twl4030.h
deleted file mode 100644
index 7f9b90d..0000000
--- a/include/asm-arm/arch-omap/twl4030.h
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * twl4030.h - header for TWL4030 PM and audio CODEC device
- *
- * Copyright (C) 2005-2006 Texas Instruments, Inc.
- *
- * Based on tlv320aic23.c:
- * Copyright (c) by Kai Svahn <kai.svahn@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- */
-
-#ifndef __TWL4030_H_
-#define __TWL4030_H_
-
-/* USB ID */
-#define TWL4030_MODULE_USB		0x00
-/* AUD ID */
-#define TWL4030_MODULE_AUDIO_VOICE	0x01
-#define TWL4030_MODULE_GPIO		0x02
-#define TWL4030_MODULE_INTBR		0x03
-#define TWL4030_MODULE_PIH		0x04
-#define TWL4030_MODULE_TEST		0x05
-/* AUX ID */
-#define TWL4030_MODULE_KEYPAD		0x06
-#define TWL4030_MODULE_MADC		0x07
-#define TWL4030_MODULE_INTERRUPTS	0x08
-#define TWL4030_MODULE_LED		0x09
-#define TWL4030_MODULE_MAIN_CHARGE	0x0A
-#define TWL4030_MODULE_PRECHARGE	0x0B
-#define TWL4030_MODULE_PWM0		0x0C
-#define TWL4030_MODULE_PWM1		0x0D
-#define TWL4030_MODULE_PWMA		0x0E
-#define TWL4030_MODULE_PWMB		0x0F
-/* POWER ID */
-#define TWL4030_MODULE_BACKUP		0x10
-#define TWL4030_MODULE_INT		0x11
-#define TWL4030_MODULE_PM_MASTER	0x12
-#define TWL4030_MODULE_PM_RECEIVER	0x13
-#define TWL4030_MODULE_RTC		0x14
-#define TWL4030_MODULE_SECURED_REG	0x15
-
-/* IRQ information-need base */
-#include <asm/arch/irqs.h>
-/* TWL4030 interrupts */
-
-#define TWL4030_MODIRQ_GPIO		(IH_TWL4030_BASE + 0)
-#define TWL4030_MODIRQ_KEYPAD		(IH_TWL4030_BASE + 1)
-#define TWL4030_MODIRQ_BCI		(IH_TWL4030_BASE + 2)
-#define TWL4030_MODIRQ_MADC		(IH_TWL4030_BASE + 3)
-#define TWL4030_MODIRQ_USB		(IH_TWL4030_BASE + 4)
-#define TWL4030_MODIRQ_PWR		(IH_TWL4030_BASE + 5)
-/* Rest are unsued currently*/
-
-/* Offsets to Power Registers */
-#define TWL4030_VDAC_DEV_GRP		0x3B
-#define TWL4030_VDAC_DEDICATED		0x3E
-#define TWL4030_VAUX2_DEV_GRP		0x1B
-#define TWL4030_VAUX2_DEDICATED		0x1E
-#define TWL4030_VAUX3_DEV_GRP		0x1F
-#define TWL4030_VAUX3_DEDICATED		0x22
-
-/* TWL4030 GPIO interrupt definitions */
-
-#define TWL4030_GPIO_MIN		0
-#define TWL4030_GPIO_MAX		18
-#define TWL4030_GPIO_MAX_CD		2
-#define TWL4030_GPIO_IRQ_NO(n)		(IH_TWL4030_GPIO_BASE+n)
-#define TWL4030_GPIO_IS_INPUT		1
-#define TWL4030_GPIO_IS_OUTPUT		0
-#define TWL4030_GPIO_IS_ENABLE		1
-#define TWL4030_GPIO_IS_DISABLE		0
-#define TWL4030_GPIO_PULL_UP		0
-#define TWL4030_GPIO_PULL_DOWN		1
-#define TWL4030_GPIO_PULL_NONE		2
-#define TWL4030_GPIO_EDGE_NONE		0
-#define TWL4030_GPIO_EDGE_RISING	1
-#define TWL4030_GPIO_EDGE_FALLING	2
-
-/* Functions to read and write from TWL4030 */
-
-/*
- * IMP NOTE:
- * The base address of the module will be added by the triton driver
- * It is the caller's responsibility to ensure sane values
- */
-int twl4030_i2c_write_u8(u8 mod_no, u8 val, u8 reg);
-int twl4030_i2c_read_u8(u8 mod_no, u8* val, u8 reg);
-
- /*
-  * i2c_write: IMPORTANT - Allocate value num_bytes+1 and valid data starts at
-  *		Offset 1.
-  */
-int twl4030_i2c_write(u8 mod_no, u8 * value, u8 reg, u8 num_bytes);
-int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes);
-
-/*
- * Exported TWL4030 GPIO APIs
- */
-int twl4030_get_gpio_datain(int gpio);
-int twl4030_request_gpio(int gpio);
-int twl4030_set_gpio_edge_ctrl(int gpio, int edge);
-int twl4030_set_gpio_debounce(int gpio, int enable);
-int twl4030_free_gpio(int gpio);
-
-#endif /* End of __TWL4030_H */
diff --git a/include/linux/i2c/twl4030-rtc.h b/include/linux/i2c/twl4030-rtc.h
new file mode 100644
index 0000000..f3d96b3
--- /dev/null
+++ b/include/linux/i2c/twl4030-rtc.h
@@ -0,0 +1,230 @@
+/*
+ * include/asm-arm/arch-omap/twl4030-rtc.h
+ *
+ * Copyright (C) 2006 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __TWL4030_RTC_H__
+#define __TWL4030_RTC_H__
+
+#define REG_SECONDS_REG                          (0x0)
+#define REG_MINUTES_REG                          (0x1)
+#define REG_HOURS_REG                            (0x2)
+#define REG_DAYS_REG                             (0x3)
+#define REG_MONTHS_REG                           (0x4)
+#define REG_YEARS_REG                            (0x5)
+#define REG_WEEKS_REG                            (0x6)
+#define REG_ALARM_SECONDS_REG                    (0x7)
+#define REG_ALARM_MINUTES_REG                    (0x8)
+#define REG_ALARM_HOURS_REG                      (0x9)
+#define REG_ALARM_DAYS_REG                       (0xA)
+#define REG_ALARM_MONTHS_REG                     (0xB)
+#define REG_ALARM_YEARS_REG                      (0xC)
+#define REG_RTC_CTRL_REG                         (0xD)
+#define REG_RTC_STATUS_REG                       (0xE)
+#define REG_RTC_INTERRUPTS_REG                   (0xF)
+#define REG_RTC_COMP_LSB_REG                     (0x10)
+#define REG_RTC_COMP_MSB_REG                     (0x11)
+
+/* REVISIT: these TWL4030 power registers are only used
+ * by rtc-twl4030 driver, move to an appropriate header
+ * if other drivers need the registers
+ */
+/* Power registers */
+#define REG_PWR_ISR1		0x00
+#define REG_PWR_IMR1		0x01
+#define REG_PWR_EDR1		0x05
+
+#define PWR_RTC_IT_UNMASK	 ~(0x08)
+#define PWR_RTC_INT_CLR          0x08
+
+/**** BitField Definitions */
+/* SECONDS_REG Fields */
+#define BIT_SECONDS_REG_SEC0                     (0x000)
+#define BIT_SECONDS_REG_SEC0_M                   (0x0000000F)
+#define BIT_SECONDS_REG_SEC1                     (0x004)
+#define BIT_SECONDS_REG_SEC1_M                   (0x00000070)
+/* MINUTES_REG Fields */
+#define BIT_MINUTES_REG_MIN0                     (0x000)
+#define BIT_MINUTES_REG_MIN0_M                   (0x0000000F)
+#define BIT_MINUTES_REG_MIN1                     (0x004)
+#define BIT_MINUTES_REG_MIN1_M                   (0x00000070)
+/* HOURS_REG Fields */
+#define BIT_HOURS_REG_HOUR0                      (0x000)
+#define BIT_HOURS_REG_HOUR0_M                    (0x0000000F)
+#define BIT_HOURS_REG_HOUR1                      (0x004)
+#define BIT_HOURS_REG_HOUR1_M                    (0x00000030)
+#define BIT_HOURS_REG_PM_NAM                     (0x007)
+#define BIT_HOURS_REG_PM_NAM_M                   (0x00000080)
+/* DAYS_REG Fields */
+#define BIT_DAYS_REG_DAY0                        (0x000)
+#define BIT_DAYS_REG_DAY0_M                      (0x0000000F)
+#define BIT_DAYS_REG_DAY1                        (0x004)
+#define BIT_DAYS_REG_DAY1_M                      (0x00000030)
+/* MONTHS_REG Fields */
+#define BIT_MONTHS_REG_MONTH0                    (0x000)
+#define BIT_MONTHS_REG_MONTH0_M                  (0x0000000F)
+#define BIT_MONTHS_REG_MONTH1                    (0x004)
+#define BIT_MONTHS_REG_MONTH1_M                  (0x00000010)
+/* YEARS_REG Fields */
+#define BIT_YEARS_REG_YEAR0                      (0x000)
+#define BIT_YEARS_REG_YEAR0_M                    (0x0000000F)
+#define BIT_YEARS_REG_YEAR1                      (0x004)
+#define BIT_YEARS_REG_YEAR1_M                    (0x000000F0)
+/* WEEKS_REG Fields */
+#define BIT_WEEKS_REG_WEEK                       (0x000)
+#define BIT_WEEKS_REG_WEEK_M                     (0x00000007)
+/* ALARM_SECONDS_REG Fields */
+#define BIT_ALARM_SECONDS_REG_ALARM_SEC0         (0x000)
+#define BIT_ALARM_SECONDS_REG_ALARM_SEC0_M       (0x0000000F)
+#define BIT_ALARM_SECONDS_REG_ALARM_SEC1         (0x004)
+#define BIT_ALARM_SECONDS_REG_ALARM_SEC1_M       (0x00000070)
+/* ALARM_MINUTES_REG Fields */
+#define BIT_ALARM_MINUTES_REG_ALARM_MIN0         (0x000)
+#define BIT_ALARM_MINUTES_REG_ALARM_MIN0_M       (0x0000000F)
+#define BIT_ALARM_MINUTES_REG_ALARM_MIN1         (0x004)
+#define BIT_ALARM_MINUTES_REG_ALARM_MIN1_M       (0x00000070)
+/* ALARM_HOURS_REG Fields */
+#define BIT_ALARM_HOURS_REG_ALARM_HOUR0          (0x000)
+#define BIT_ALARM_HOURS_REG_ALARM_HOUR0_M        (0x0000000F)
+#define BIT_ALARM_HOURS_REG_ALARM_HOUR1          (0x004)
+#define BIT_ALARM_HOURS_REG_ALARM_HOUR1_M        (0x00000030)
+#define BIT_ALARM_HOURS_REG_ALARM_PM_NAM         (0x007)
+#define BIT_ALARM_HOURS_REG_ALARM_PM_NAM_M       (0x00000080)
+/* ALARM_DAYS_REG Fields */
+#define BIT_ALARM_DAYS_REG_ALARM_DAY0            (0x000)
+#define BIT_ALARM_DAYS_REG_ALARM_DAY0_M          (0x0000000F)
+#define BIT_ALARM_DAYS_REG_ALARM_DAY1            (0x004)
+#define BIT_ALARM_DAYS_REG_ALARM_DAY1_M          (0x00000030)
+/* ALARM_MONTHS_REG Fields */
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0        (0x000)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0_M      (0x0000000F)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1        (0x004)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1_M      (0x00000010)
+/* ALARM_YEARS_REG Fields */
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR0          (0x000)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR0_M        (0x0000000F)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR1          (0x004)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR1_M        (0x000000F0)
+/* RTC_CTRL_REG Fields */
+#define BIT_RTC_CTRL_REG_STOP_RTC                (0x000)
+#define BIT_RTC_CTRL_REG_STOP_RTC_M              (0x00000001)
+#define BIT_RTC_CTRL_REG_ROUND_30S               (0x001)
+#define BIT_RTC_CTRL_REG_ROUND_30S_M             (0x00000002)
+#define BIT_RTC_CTRL_REG_AUTO_COMP               (0x002)
+#define BIT_RTC_CTRL_REG_AUTO_COMP_M             (0x00000004)
+#define BIT_RTC_CTRL_REG_MODE_12_24              (0x003)
+#define BIT_RTC_CTRL_REG_MODE_12_24_M            (0x00000008)
+#define BIT_RTC_CTRL_REG_TEST_MODE               (0x004)
+#define BIT_RTC_CTRL_REG_TEST_MODE_M             (0x00000010)
+#define BIT_RTC_CTRL_REG_SET_32_COUNTER          (0x005)
+#define BIT_RTC_CTRL_REG_SET_32_COUNTER_M        (0x00000020)
+#define BIT_RTC_CTRL_REG_GET_TIME                (0x006)
+#define BIT_RTC_CTRL_REG_GET_TIME_M              (0x00000040)
+/* RTC_STATUS_REG Fields */
+#define BIT_RTC_STATUS_REG_RUN                   (0x001)
+#define BIT_RTC_STATUS_REG_RUN_M                 (0x00000002)
+#define BIT_RTC_STATUS_REG_1S_EVENT              (0x002)
+#define BIT_RTC_STATUS_REG_1S_EVENT_M            (0x00000004)
+#define BIT_RTC_STATUS_REG_1M_EVENT              (0x003)
+#define BIT_RTC_STATUS_REG_1M_EVENT_M            (0x00000008)
+#define BIT_RTC_STATUS_REG_1H_EVENT              (0x004)
+#define BIT_RTC_STATUS_REG_1H_EVENT_M            (0x00000010)
+#define BIT_RTC_STATUS_REG_1D_EVENT              (0x005)
+#define BIT_RTC_STATUS_REG_1D_EVENT_M            (0x00000020)
+#define BIT_RTC_STATUS_REG_ALARM                 (0x006)
+#define BIT_RTC_STATUS_REG_ALARM_M               (0x00000040)
+#define BIT_RTC_STATUS_REG_POWER_UP              (0x007)
+#define BIT_RTC_STATUS_REG_POWER_UP_M            (0x00000080)
+
+/* RTC_INTERRUPTS_REG Fields */
+#define BIT_RTC_INTERRUPTS_REG_EVERY             (0x000)
+#define BIT_RTC_INTERRUPTS_REG_EVERY_M           (0x00000003)
+#define BIT_RTC_INTERRUPTS_REG_IT_TIMER          (0x002)
+#define BIT_RTC_INTERRUPTS_REG_IT_TIMER_M        (0x00000004)
+#define BIT_RTC_INTERRUPTS_REG_IT_ALARM          (0x003)
+#define BIT_RTC_INTERRUPTS_REG_IT_ALARM_M        (0x00000008)
+/* RTC_COMP_LSB_REG Fields */
+#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB        (0x000)
+#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB_M      (0x000000FF)
+/* RTC_COMP_MSB_REG Fields */
+#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB        (0x000)
+#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB_M      (0x000000FF)
+
+/* ALARM_DAYS_REG Fields */
+#define BIT_ALARM_DAYS_REG_ALARM_DAY1            (0x004)
+#define BIT_ALARM_DAYS_REG_ALARM_DAY1_M          (0x00000030)
+/* ALARM_MONTHS_REG Fields */
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0        (0x000)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0_M      (0x0000000F)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1        (0x004)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1_M      (0x00000010)
+/* ALARM_YEARS_REG Fields */
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR0          (0x000)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR0_M        (0x0000000F)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR1          (0x004)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR1_M        (0x000000F0)
+/* RTC_CTRL_REG Fields */
+#define BIT_RTC_CTRL_REG_STOP_RTC                (0x000)
+#define BIT_RTC_CTRL_REG_STOP_RTC_M              (0x00000001)
+#define BIT_RTC_CTRL_REG_ROUND_30S               (0x001)
+#define BIT_RTC_CTRL_REG_ROUND_30S_M             (0x00000002)
+#define BIT_RTC_CTRL_REG_AUTO_COMP               (0x002)
+#define BIT_RTC_CTRL_REG_AUTO_COMP_M             (0x00000004)
+#define BIT_RTC_CTRL_REG_MODE_12_24              (0x003)
+#define BIT_RTC_CTRL_REG_MODE_12_24_M            (0x00000008)
+#define BIT_RTC_CTRL_REG_TEST_MODE               (0x004)
+#define BIT_RTC_CTRL_REG_TEST_MODE_M             (0x00000010)
+#define BIT_RTC_CTRL_REG_SET_32_COUNTER          (0x005)
+#define BIT_RTC_CTRL_REG_SET_32_COUNTER_M        (0x00000020)
+#define BIT_RTC_CTRL_REG_GET_TIME                (0x006)
+#define BIT_RTC_CTRL_REG_GET_TIME_M              (0x00000040)
+/* RTC_STATUS_REG Fields */
+#define BIT_RTC_STATUS_REG_RUN                   (0x001)
+#define BIT_RTC_STATUS_REG_RUN_M                 (0x00000002)
+#define BIT_RTC_STATUS_REG_1S_EVENT              (0x002)
+#define BIT_RTC_STATUS_REG_1S_EVENT_M            (0x00000004)
+#define BIT_RTC_STATUS_REG_1M_EVENT              (0x003)
+#define BIT_RTC_STATUS_REG_1M_EVENT_M            (0x00000008)
+#define BIT_RTC_STATUS_REG_1H_EVENT              (0x004)
+#define BIT_RTC_STATUS_REG_1H_EVENT_M            (0x00000010)
+#define BIT_RTC_STATUS_REG_1D_EVENT              (0x005)
+#define BIT_RTC_STATUS_REG_1D_EVENT_M            (0x00000020)
+#define BIT_RTC_STATUS_REG_ALARM                 (0x006)
+#define BIT_RTC_STATUS_REG_ALARM_M               (0x00000040)
+#define BIT_RTC_STATUS_REG_POWER_UP              (0x007)
+#define BIT_RTC_STATUS_REG_POWER_UP_M            (0x00000080)
+/* RTC_INTERRUPTS_REG Fields */
+#define BIT_RTC_INTERRUPTS_REG_EVERY             (0x000)
+#define BIT_RTC_INTERRUPTS_REG_EVERY_M           (0x00000003)
+#define BIT_RTC_INTERRUPTS_REG_IT_TIMER          (0x002)
+#define BIT_RTC_INTERRUPTS_REG_IT_TIMER_M        (0x00000004)
+#define BIT_RTC_INTERRUPTS_REG_IT_ALARM          (0x003)
+#define BIT_RTC_INTERRUPTS_REG_IT_ALARM_M        (0x00000008)
+/* RTC_COMP_LSB_REG Fields */
+#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB        (0x000)
+#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB_M      (0x000000FF)
+/* RTC_COMP_MSB_REG Fields */
+#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB        (0x000)
+#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB_M      (0x000000FF)
+
+
+struct twl4030rtc_platform_data {
+        int (*init)(void);
+        void (*exit)(void);
+};
+
+#endif				/* End of __TWL4030_RTC_H__ */
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
new file mode 100644
index 0000000..7f9b90d
--- /dev/null
+++ b/include/linux/i2c/twl4030.h
@@ -0,0 +1,118 @@
+/*
+ * twl4030.h - header for TWL4030 PM and audio CODEC device
+ *
+ * Copyright (C) 2005-2006 Texas Instruments, Inc.
+ *
+ * Based on tlv320aic23.c:
+ * Copyright (c) by Kai Svahn <kai.svahn@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#ifndef __TWL4030_H_
+#define __TWL4030_H_
+
+/* USB ID */
+#define TWL4030_MODULE_USB		0x00
+/* AUD ID */
+#define TWL4030_MODULE_AUDIO_VOICE	0x01
+#define TWL4030_MODULE_GPIO		0x02
+#define TWL4030_MODULE_INTBR		0x03
+#define TWL4030_MODULE_PIH		0x04
+#define TWL4030_MODULE_TEST		0x05
+/* AUX ID */
+#define TWL4030_MODULE_KEYPAD		0x06
+#define TWL4030_MODULE_MADC		0x07
+#define TWL4030_MODULE_INTERRUPTS	0x08
+#define TWL4030_MODULE_LED		0x09
+#define TWL4030_MODULE_MAIN_CHARGE	0x0A
+#define TWL4030_MODULE_PRECHARGE	0x0B
+#define TWL4030_MODULE_PWM0		0x0C
+#define TWL4030_MODULE_PWM1		0x0D
+#define TWL4030_MODULE_PWMA		0x0E
+#define TWL4030_MODULE_PWMB		0x0F
+/* POWER ID */
+#define TWL4030_MODULE_BACKUP		0x10
+#define TWL4030_MODULE_INT		0x11
+#define TWL4030_MODULE_PM_MASTER	0x12
+#define TWL4030_MODULE_PM_RECEIVER	0x13
+#define TWL4030_MODULE_RTC		0x14
+#define TWL4030_MODULE_SECURED_REG	0x15
+
+/* IRQ information-need base */
+#include <asm/arch/irqs.h>
+/* TWL4030 interrupts */
+
+#define TWL4030_MODIRQ_GPIO		(IH_TWL4030_BASE + 0)
+#define TWL4030_MODIRQ_KEYPAD		(IH_TWL4030_BASE + 1)
+#define TWL4030_MODIRQ_BCI		(IH_TWL4030_BASE + 2)
+#define TWL4030_MODIRQ_MADC		(IH_TWL4030_BASE + 3)
+#define TWL4030_MODIRQ_USB		(IH_TWL4030_BASE + 4)
+#define TWL4030_MODIRQ_PWR		(IH_TWL4030_BASE + 5)
+/* Rest are unsued currently*/
+
+/* Offsets to Power Registers */
+#define TWL4030_VDAC_DEV_GRP		0x3B
+#define TWL4030_VDAC_DEDICATED		0x3E
+#define TWL4030_VAUX2_DEV_GRP		0x1B
+#define TWL4030_VAUX2_DEDICATED		0x1E
+#define TWL4030_VAUX3_DEV_GRP		0x1F
+#define TWL4030_VAUX3_DEDICATED		0x22
+
+/* TWL4030 GPIO interrupt definitions */
+
+#define TWL4030_GPIO_MIN		0
+#define TWL4030_GPIO_MAX		18
+#define TWL4030_GPIO_MAX_CD		2
+#define TWL4030_GPIO_IRQ_NO(n)		(IH_TWL4030_GPIO_BASE+n)
+#define TWL4030_GPIO_IS_INPUT		1
+#define TWL4030_GPIO_IS_OUTPUT		0
+#define TWL4030_GPIO_IS_ENABLE		1
+#define TWL4030_GPIO_IS_DISABLE		0
+#define TWL4030_GPIO_PULL_UP		0
+#define TWL4030_GPIO_PULL_DOWN		1
+#define TWL4030_GPIO_PULL_NONE		2
+#define TWL4030_GPIO_EDGE_NONE		0
+#define TWL4030_GPIO_EDGE_RISING	1
+#define TWL4030_GPIO_EDGE_FALLING	2
+
+/* Functions to read and write from TWL4030 */
+
+/*
+ * IMP NOTE:
+ * The base address of the module will be added by the triton driver
+ * It is the caller's responsibility to ensure sane values
+ */
+int twl4030_i2c_write_u8(u8 mod_no, u8 val, u8 reg);
+int twl4030_i2c_read_u8(u8 mod_no, u8* val, u8 reg);
+
+ /*
+  * i2c_write: IMPORTANT - Allocate value num_bytes+1 and valid data starts at
+  *		Offset 1.
+  */
+int twl4030_i2c_write(u8 mod_no, u8 * value, u8 reg, u8 num_bytes);
+int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes);
+
+/*
+ * Exported TWL4030 GPIO APIs
+ */
+int twl4030_get_gpio_datain(int gpio);
+int twl4030_request_gpio(int gpio);
+int twl4030_set_gpio_edge_ctrl(int gpio, int edge);
+int twl4030_set_gpio_debounce(int gpio, int enable);
+int twl4030_free_gpio(int gpio);
+
+#endif /* End of __TWL4030_H */
-- 
1.5.5.rc0.16.g02b00

