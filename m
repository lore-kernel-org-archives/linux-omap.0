From: jean.pihet@newoldbits.com
Subject: [PATCH 02/13] OMAP2+: PM: isolate PM code
Date: Wed, 18 May 2011 19:32:19 +0200
Message-ID: <1305739950-11695-3-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56223 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910Ab1ERRcp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:32:45 -0400
Received: by mail-gy0-f174.google.com with SMTP id 10so621943gyd.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:32:45 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Isolate the PM code under CONFIG_PM. This includes the following:
- core PM,
- powerdomain,
- clockdomain,
- smartreflex,
- voltagedomain,
- OPP.

This cleans up the PM code in order to allow it to be built as a
module.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/Makefile |   45 +++++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 43c5c22..0fe8a5b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -49,14 +49,9 @@ obj-$(CONFIG_ARCH_OMAP4)		+= mux44xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 # obj-$(CONFIG_ARCH_OMAP3)		+= sdrc3xxx.o
 
-# OPP table initialization
-ifeq ($(CONFIG_PM_OPP),y)
-obj-y					+= opp.o
-obj-$(CONFIG_ARCH_OMAP3)		+= opp3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
-endif
 
 # Power Management
+#  Includes core PM, powerdomain, clockdomain, smartreflex, voltagedomain, OPP
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
@@ -74,29 +69,13 @@ ifeq ($(CONFIG_PM_VERBOSE),y)
 CFLAGS_pm_bus.o				+= -DDEBUG
 endif
 
-endif
-
-# PRCM
-obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
-					   vc3xxx_data.o vp3xxx_data.o
-# XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
-# will be removed once the OMAP4 part of the codebase is converted to
-# use OMAP4-specific PRCM functions.
-obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
-					   cm44xx.o prcm_mpu44xx.o \
-					   prminst44xx.o vc44xx_data.o \
-					   vp44xx_data.o
-
 # OMAP voltage domains
-ifeq ($(CONFIG_PM),y)
 voltagedomain-common			:= voltage.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
 					   voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
 					   voltagedomains44xx_data.o
-endif
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
@@ -140,10 +119,32 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o \
 					   dpll3xxx.o dpll44xx.o
 
+# OPP table initialization
+ifeq ($(CONFIG_PM_OPP),y)
+obj-y					+= opp.o
+obj-$(CONFIG_ARCH_OMAP3)		+= opp3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
+endif
+
 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= opp2430_data.o
 
+endif
+# end of CONFIG_PM
+
+# PRCM
+obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
+					   vc3xxx_data.o vp3xxx_data.o
+# XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
+# will be removed once the OMAP4 part of the codebase is converted to
+# use OMAP4-specific PRCM functions.
+obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
+					   cm44xx.o prcm_mpu44xx.o \
+					   prminst44xx.o vc44xx_data.o \
+					   vp44xx_data.o
+
 # hwmod data
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2430_data.o
-- 
1.7.4.1

