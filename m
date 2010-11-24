From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
 disabled
Date: Wed, 24 Nov 2010 16:49:05 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56340 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab0KXXtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 18:49:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, tom.leiming@gmail.com, pramod.gurav@ti.com, thomas.petazzoni@free-electrons.com, jean.pihet@newoldbits.com, govindraj.raja@ti.com


The console semaphore must be held while the OMAP UART devices are
disabled, lest a console write cause an ARM abort (and a kernel crash)
when the underlying console device is inaccessible.  These crashes
only occur when the console is on one of the OMAP internal serial
ports.

While this problem has been latent in the PM idle loop for some time,
the crash was not triggerable with an unmodified kernel until commit
6f251e9db1093c187addc309b5f2f7fe3efd2995 ("OMAP: UART: omap_device
conversions, remove implicit 8520 assumptions").  After this patch, a
console write often occurs after the console UART has been disabled in
the idle loop, crashing the system.  Several users have encountered
this bug:

    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38396.html

    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36602.html

The same commit also introduced new code that disabled the UARTs
during init, in omap_serial_init_port().  The kernel will also crash
in this code when earlyconsole and extra debugging is enabled:

    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36411.html

The minimal fix for the -rc series is to hold the console semaphore
while the OMAP UARTs are disabled.  This is a somewhat overbroad fix,
since the console may not be located on an OMAP UART, as is the case
with the GPMC UART on Zoom3.  While it is technically possible to
determine which devices the console or earlyconsole is actually
running on, it is not a trivial problem to solve, and the code to do
so is not really appropriate for the -rc series.

The right long-term fix is to ensure that no code outside of the OMAP
serial driver can disable an OMAP UART.  As I understand it, code to
implement this is under development by TI.

This patch is a collaboration between Paul Walmsley <paul@pwsan.com>
and Tony Lindgren <tony@atomide.com>.  Thanks to Ming Lei
<tom.leiming@gmail.com> and Pramod <pramod.gurav@ti.com> for their
feedback on earlier versions of this patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Cc: Pramod <pramod.gurav@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c |    7 +++++++
 arch/arm/mach-omap2/pm34xx.c |   10 ++++++++++
 arch/arm/mach-omap2/serial.c |    5 +++++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index a40457d..c85923e5 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/time.h>
 #include <linux/gpio.h>
+#include <linux/console.h>
 
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
@@ -118,6 +119,10 @@ static void omap2_enter_full_retention(void)
 	if (omap_irq_pending())
 		goto no_sleep;
 
+	/* Block console output in case it is on one of the OMAP UARTs */
+	if (try_acquire_console_sem())
+		goto no_sleep;
+
 	omap_uart_prepare_idle(0);
 	omap_uart_prepare_idle(1);
 	omap_uart_prepare_idle(2);
@@ -131,6 +136,8 @@ static void omap2_enter_full_retention(void)
 	omap_uart_resume_idle(1);
 	omap_uart_resume_idle(0);
 
+	release_console_sem();
+
 no_sleep:
 	if (omap2_pm_debug) {
 		unsigned long long tmp;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 75c0cd1..0ec8a04 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,6 +28,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/console.h>
 
 #include <plat/sram.h>
 #include <plat/clockdomain.h>
@@ -385,6 +386,12 @@ void omap_sram_idle(void)
 		omap3_enable_io_chain();
 	}
 
+	/* Block console output in case it is on one of the OMAP UARTs */
+	if (per_next_state < PWRDM_POWER_ON ||
+	    core_next_state < PWRDM_POWER_ON)
+		if (try_acquire_console_sem())
+			goto console_still_active;
+
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
@@ -463,6 +470,9 @@ void omap_sram_idle(void)
 		omap_uart_resume_idle(3);
 	}
 
+	release_console_sem();
+
+console_still_active:
 	/* Disable IO-PAD and IO-CHAIN wakeup */
 	if (omap3_has_io_wakeup() &&
 	    (per_next_state < PWRDM_POWER_ON ||
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index edd7c99..18935ea 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/serial_8250.h>
 #include <linux/pm_runtime.h>
+#include <linux/console.h>
 
 #ifdef CONFIG_SERIAL_OMAP
 #include <plat/omap-serial.h>
@@ -810,6 +811,8 @@ void __init omap_serial_init_port(int port)
 
 	oh->dev_attr = uart;
 
+	acquire_console_sem(); /* in case the earlycon is on the UART */
+
 	/*
 	 * Because of early UART probing, UART did not get idled
 	 * on init.  Now that omap_device is ready, ensure full idle
@@ -834,6 +837,8 @@ void __init omap_serial_init_port(int port)
 	omap_uart_block_sleep(uart);
 	uart->timeout = DEFAULT_TIMEOUT;
 
+	release_console_sem();
+
 	if ((cpu_is_omap34xx() && uart->padconf) ||
 	    (uart->wk_en && uart->wk_mask)) {
 		device_init_wakeup(&od->pdev.dev, true);
-- 
1.7.2.3

