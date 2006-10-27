From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.19-rc3-omap] gpio init section cleanups
Date: Thu, 26 Oct 2006 21:41:39 -0700
Message-ID: <200610262141.40485.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Minor GPIO cleanups:  remove needless #include, and omap_gpio_init()
should be __init, as well as all the board init code calling it.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: osk2/arch/arm/plat-omap/gpio.c
===================================================================
--- osk2.orig/arch/arm/plat-omap/gpio.c	2006-10-25 14:06:19.000000000 -0700
+++ osk2/arch/arm/plat-omap/gpio.c	2006-10-25 14:55:01.000000000 -0700
@@ -13,7 +13,6 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/ptrace.h>
 #include <linux/sysdev.h>
@@ -1329,7 +1425,7 @@ void omap2_gpio_resume_after_retention(v
  * This may get called early from board specific init
  * for boards that have interrupts routed via FPGA.
  */
-int omap_gpio_init(void)
+int __init omap_gpio_init(void)
 {
 	if (!initialized)
 		return _omap_gpio_init();
Index: osk2/arch/arm/mach-omap1/board-innovator.c
===================================================================
--- osk2.orig/arch/arm/mach-omap1/board-innovator.c	2006-10-25 14:06:18.000000000 -0700
+++ osk2/arch/arm/mach-omap1/board-innovator.c	2006-10-25 14:46:23.000000000 -0700
@@ -308,7 +308,7 @@ static void __init innovator_init_smc91x
 	}
 }
 
-void innovator_init_irq(void)
+static void __init innovator_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
Index: osk2/arch/arm/mach-omap1/board-fsample.c
===================================================================
--- osk2.orig/arch/arm/mach-omap1/board-fsample.c	2006-10-25 14:06:18.000000000 -0700
+++ osk2/arch/arm/mach-omap1/board-fsample.c	2006-10-25 14:46:23.000000000 -0700
@@ -246,7 +246,7 @@ static void __init fsample_init_smc91x(v
 	mdelay(50);
 }
 
-void omap_fsample_init_irq(void)
+static void __init omap_fsample_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
Index: osk2/arch/arm/mach-omap1/board-h3.c
===================================================================
--- osk2.orig/arch/arm/mach-omap1/board-h3.c	2006-10-25 14:06:18.000000000 -0700
+++ osk2/arch/arm/mach-omap1/board-h3.c	2006-10-25 14:46:23.000000000 -0700
@@ -495,7 +495,7 @@ static void __init h3_init_smc91x(void)
 	}
 }
 
-void h3_init_irq(void)
+static void __init h3_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
Index: osk2/arch/arm/mach-omap1/board-perseus2.c
===================================================================
--- osk2.orig/arch/arm/mach-omap1/board-perseus2.c	2006-10-25 14:06:18.000000000 -0700
+++ osk2/arch/arm/mach-omap1/board-perseus2.c	2006-10-25 14:46:23.000000000 -0700
@@ -246,7 +246,7 @@ static void __init perseus2_init_smc91x(
 	mdelay(50);
 }
 
-void omap_perseus2_init_irq(void)
+static void __init omap_perseus2_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
