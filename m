From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap: serial: Fix the boot-up crash/reboot without CONFIG_PM
Date: Mon, 11 Oct 2010 16:35:18 +0530
Message-ID: <1286795118-11490-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58611 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862Ab0JKLF1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Oct 2010 07:05:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Charulatha V <charu@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

The omap2plus_defconfig doesn't boot up when built with CONFIG_PM
disabled on the latest linux-omap master. Below are the observations
1. OMAP3 reboots in the middle of boot
--------------------------------------------------
[    0.000000] Calibrating delay loop... 494.72 BogoMIPS (lpj=1933312)
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.000000] Security Framework initialized
[    0.000000] Mount-cache hash table entries: 512
[    0.000000] CPU: Testing write buffer coherency: ok
[    0.000000] Brought up 1 CPUs
[    0.000000] SMP: Total of 1 processors activated (494.72 BogoMIPS).
[    0.000000] regulator: core version 0.5
[    0.000000] NET: Registered protocol family 16

U-Boot 1.1.4 (Feb 11 2009 - 16:10:23)

OMAP3430-GP rev 2, CPU-OPP2 L3-165MHz
TI 3430SDP 1.0 Version + mDDR (Boot NOR)
DRAM:  128 MB
Flash: 128 MB
NAND:128 MiB
--------------------------------------------------

2. OMAP4 does a kernel PANIC
-------------------------------------
[    0.000000] Calibrating delay loop... 1195.29 BogoMIPS (lpj=4669440)
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.000000] Security Framework initialized
[    0.000000] Mount-cache hash table entries: 512
[    0.000000] CPU: Testing write buffer coherency: ok
[    0.000000] L310 cache controller enabled
[    0.000000] l2x0: 16 ways, CACHE_ID 0x410000c2, AUX_CTRL 0x0e050000
[    0.000000] CPU1: Booted secondary processor
[    0.000000] Brought up 2 CPUs
[    0.000000] SMP: Total of 2 processors activated (2395.78 BogoMIPS).
[    0.000000] regulator: core version 0.5
[    0.000000] NET: Registered protocol family 16
[    0.000000] mux: Could not set signal i2c2_scl.i2c2_scl
[    0.000000] mux: Could not set signal i2c2_sda.i2c2_sda
[    0.000000] mux: Could not set signal i2c3_scl.i2c3_scl
[    0.000000] mux: Could not set signal i2c3_sda.i2c3_sda
[    0.000000] mux: Could not set signal i2c4_scl.i2c4_scl
[    0.000000] mux: Could not set signal i2c4_sda.i2c4_sda
-------------------------------------

This is happening because 'omap_serial_init()' is hanging in the boot.
On OMAP3 the watchdog is generating reboot because devices_init doesn't
happens where as on OMAP4 it just hangs without reboot.
The uart clock is not getting enabled after omap_device_idle as part
of omap_serial_init.
The omap_device_idle(will disable the clock) then omap_uart_block_sleep()
should enable clock back disabled during the boot up phase.
But omap_uart_block_sleep() stuffed version is binded only under
CONFIG_PM and other version is just empty. Hence it is not enabling
clock back as expected

This patch adds uart clock enable code to omap_uart_block_sleep() function
built with CONFIG_PM disabled.
Thanks to Charulatha and Govindraj for their help on this debug.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
Boot tested on OMAP3430 and OMAP4430 SDP
 arch/arm/mach-omap2/serial.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 338e46a..ba8a5cc 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -608,7 +608,11 @@ static DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show,
 #define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
 #else
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
-static void omap_uart_block_sleep(struct omap_uart_state *uart) {}
+static void omap_uart_block_sleep(struct omap_uart_state *uart)
+{
+	/* Needed to enable UART clocks when built without CONFIG_PM */
+	omap_uart_enable_clocks(uart);
+}
 #define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */
 
-- 
1.6.0.4

