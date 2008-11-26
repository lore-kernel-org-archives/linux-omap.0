From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc6-omap] twl4030: linkage fix for generic power scripts
Date: Wed, 26 Nov 2008 13:07:44 -0800
Message-ID: <200811261307.44357.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:28550 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751189AbYKZVJK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2008 16:09:10 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Section fixes for generic twl4030 power scripts.

NOTE:  doesn't fix the bug whereby Beagle won't reset when
these scripts are loaded.  Or fix SDP section warnings.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-omap3beagle.c       |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c          |    2 +-
 arch/arm/mach-omap2/board-overo.c             |    2 +-
 arch/arm/mach-omap2/twl4030-generic-scripts.c |    3 +++
 arch/arm/mach-omap2/twl4030-generic-scripts.h |    5 +++++
 5 files changed, 11 insertions(+), 3 deletions(-)

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -206,7 +206,7 @@ static struct twl4030_platform_data beag
 	/* platform_data for children goes here */
 	.usb		= &beagle_usb_data,
 	.gpio		= &beagle_gpio_data,
-	.power		= &generic3430_t2scripts_data,
+	.power		= GENERIC3430_T2SCRIPTS_DATA,
 	.vmmc1		= &beagle_vmmc1,
 	.vsim		= &beagle_vsim,
 	.vdac		= &beagle_vdac,
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -139,7 +139,7 @@ static struct twl4030_platform_data omap
 	.keypad		= &omap3evm_kp_data,
 	.madc		= &omap3evm_madc_data,
 	.usb		= &omap3evm_usb_data,
-	.power		= &generic3430_t2scripts_data,
+	.power		= GENERIC3430_T2SCRIPTS_DATA,
 	.gpio		= &omap3evm_gpio_data,
 };
 
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -162,7 +162,7 @@ static struct twl4030_platform_data over
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &overo_gpio_data,
 	.usb		= &overo_usb_data,
-	.power		= &generic3430_t2scripts_data,
+	.power		= GENERIC3430_T2SCRIPTS_DATA,
 };
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
--- a/arch/arm/mach-omap2/twl4030-generic-scripts.c
+++ b/arch/arm/mach-omap2/twl4030-generic-scripts.c
@@ -23,6 +23,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef CONFIG_TWL4030_POWER
+
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -76,3 +78,4 @@ struct twl4030_power_data generic3430_t2
 };
 
 
+#endif /* CONFIG_TWL4030_POWER */
--- a/arch/arm/mach-omap2/twl4030-generic-scripts.h
+++ b/arch/arm/mach-omap2/twl4030-generic-scripts.h
@@ -3,6 +3,11 @@
 
 #include <linux/i2c/twl4030.h>
 
+#ifdef CONFIG_TWL4030_POWER
 extern struct twl4030_power_data generic3430_t2scripts_data;
+#define GENERIC3430_T2SCRIPTS_DATA &generic3430_t2scripts_data
+#else
+#define GENERIC3430_T2SCRIPTS_DATA NULL
+#endif /* CONFIG_TWL4030_POWER */
 
 #endif
