From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 2/6] omap: voltage: change code to use new location of voltage.h and vp.h
Date: Mon, 18 Jul 2011 20:35:18 +0300
Message-ID: <1311010522-5868-3-git-send-email-t-kristo@ti.com>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34870 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754488Ab1GRRgH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jul 2011 13:36:07 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com

These are now under plat-omap/include/plat.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c                      |    2 +-
 arch/arm/mach-omap2/omap_opp_data.h           |    3 +--
 arch/arm/mach-omap2/omap_twl.c                |    2 +-
 arch/arm/mach-omap2/pm.c                      |    2 +-
 arch/arm/mach-omap2/powerdomain.h             |    3 +--
 arch/arm/mach-omap2/prm2xxx_3xxx.c            |    3 +--
 arch/arm/mach-omap2/prm44xx.c                 |    2 +-
 arch/arm/mach-omap2/smartreflex.h             |    2 +-
 arch/arm/mach-omap2/sr_device.c               |    2 +-
 arch/arm/mach-omap2/vc.c                      |    2 +-
 arch/arm/mach-omap2/vc3xxx_data.c             |    2 +-
 arch/arm/mach-omap2/vc44xx_data.c             |    2 +-
 arch/arm/mach-omap2/voltage.c                 |    3 +--
 arch/arm/mach-omap2/voltagedomains2xxx_data.c |    2 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    3 +--
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    3 +--
 arch/arm/mach-omap2/vp.c                      |    4 ++--
 arch/arm/mach-omap2/vp3xxx_data.c             |    3 +--
 arch/arm/mach-omap2/vp44xx_data.c             |    4 +---
 19 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4c8a5de..b151fca 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -31,6 +31,7 @@
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 #include <plat/serial.h>
+#include <plat/voltage.h>
 
 #include "clock2xxx.h"
 #include "clock3xxx.h"
@@ -38,7 +39,6 @@
 #include "io.h"
 
 #include <plat/omap-pm.h>
-#include "voltage.h"
 #include "powerdomain.h"
 
 #include "clockdomain.h"
diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap2/omap_opp_data.h
index c784c12..4d93209 100644
--- a/arch/arm/mach-omap2/omap_opp_data.h
+++ b/arch/arm/mach-omap2/omap_opp_data.h
@@ -20,8 +20,7 @@
 #define __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H
 
 #include <plat/omap_hwmod.h>
-
-#include "voltage.h"
+#include <plat/voltage.h>
 
 /*
  * *BIG FAT WARNING*:
diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index f515a1a..b9720a0 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/i2c/twl.h>
 
-#include "voltage.h"
+#include <plat/voltage.h>
 
 #include "pm.h"
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 659e400..699d347 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -18,8 +18,8 @@
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 #include <plat/common.h>
+#include <plat/voltage.h>
 
-#include "voltage.h"
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 2c685a5..2ae9236 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -23,8 +23,7 @@
 #include <linux/atomic.h>
 
 #include <plat/cpu.h>
-
-#include "voltage.h"
+#include <plat/voltage.h>
 
 /* Powerdomain basic power states */
 #define PWRDM_POWER_OFF		0x0
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 3b83763..e096c76 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -19,8 +19,7 @@
 #include <plat/common.h>
 #include <plat/cpu.h>
 #include <plat/prcm.h>
-
-#include "vp.h"
+#include <plat/vp.h>
 
 #include "prm2xxx_3xxx.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 495a31a..5979803 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -20,8 +20,8 @@
 #include <plat/common.h>
 #include <plat/cpu.h>
 #include <plat/prcm.h>
+#include <plat/vp.h>
 
-#include "vp.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 5f35b9e..fe9b242 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -22,7 +22,7 @@
 
 #include <linux/platform_device.h>
 
-#include "voltage.h"
+#include <plat/voltage.h>
 
 /*
  * Different Smartreflex IPs version. The v1 is the 65nm version used in
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 2782d3f..bc08751 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -23,9 +23,9 @@
 #include <linux/io.h>
 
 #include <plat/omap_device.h>
+#include <plat/voltage.h>
 
 #include "smartreflex.h"
-#include "voltage.h"
 #include "control.h"
 #include "pm.h"
 
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index aa9f0bc..2c8bc24 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -3,8 +3,8 @@
 #include <linux/init.h>
 
 #include <plat/cpu.h>
+#include <plat/voltage.h>
 
-#include "voltage.h"
 #include "vc.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 95d7701..b691dad 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -19,9 +19,9 @@
 #include <linux/init.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm-regbits-34xx.h"
-#include "voltage.h"
 
 #include "vc.h"
 
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index 0a4fc37..1eeab16 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -19,10 +19,10 @@
 #include <linux/init.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
-#include "voltage.h"
 
 #include "vc.h"
 
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index b20985a..11c4a6c 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -27,6 +27,7 @@
 #include <linux/clk.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
@@ -35,11 +36,9 @@
 #include "prminst44xx.h"
 #include "control.h"
 
-#include "voltage.h"
 #include "powerdomain.h"
 
 #include "vc.h"
-#include "vp.h"
 
 static LIST_HEAD(voltdm_list);
 
diff --git a/arch/arm/mach-omap2/voltagedomains2xxx_data.c b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
index 69ff261..e5ae258 100644
--- a/arch/arm/mach-omap2/voltagedomains2xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include "voltage.h"
+#include <plat/voltage.h>
 
 static struct voltagedomain omap2_voltdm_core = {
 	.name = "core",
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index b0d0ae1..175e856 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -20,12 +20,11 @@
 
 #include <plat/common.h>
 #include <plat/cpu.h>
+#include <plat/voltage.h>
 
 #include "prm-regbits-34xx.h"
 #include "omap_opp_data.h"
-#include "voltage.h"
 #include "vc.h"
-#include "vp.h"
 
 /*
  * VDD data
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index c4584e9..9d1f6d3 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -22,15 +22,14 @@
 #include <linux/init.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "prcm44xx.h"
 #include "prminst44xx.h"
-#include "voltage.h"
 #include "omap_opp_data.h"
 #include "vc.h"
-#include "vp.h"
 
 static const struct omap_vfsm_instance omap4_vdd_mpu_vfsm = {
 	.voltsetup_reg = OMAP4_PRM_VOLTSETUP_MPU_RET_SLEEP_OFFSET,
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 3807620..b01c571 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -2,9 +2,9 @@
 #include <linux/init.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
-#include "voltage.h"
-#include "vp.h"
+#include "vc.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index 260c554..9bac34e 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -20,11 +20,10 @@
 #include <linux/init.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm-regbits-34xx.h"
-#include "voltage.h"
 
-#include "vp.h"
 #include "prm2xxx_3xxx.h"
 
 static const struct omap_vp_ops omap3_vp_ops = {
diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
index b4e7704..6bd1d90 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -20,12 +20,10 @@
 #include <linux/init.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
-#include "voltage.h"
-
-#include "vp.h"
 
 static const struct omap_vp_ops omap4_vp_ops = {
 	.check_txdone = omap4_prm_vp_check_txdone,
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

