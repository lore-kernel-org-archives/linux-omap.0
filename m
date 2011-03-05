From: Nishanth Menon <nm@ti.com>
Subject: [PM-CORE RFC] OMAP2+: make CONFIG_PM selectable
Date: Sat,  5 Mar 2011 19:39:18 +0530
Message-ID: <1299334158-26844-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:47167 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219Ab1CEOJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 09:09:30 -0500
Received: by mail-yx0-f181.google.com with SMTP id 8so1309677yxm.26
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 06:09:28 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Paul <paul@pwsan.com>, Tony <tony@atomide.com>, Kevin <khilman@ti.com>

Allow build with CONFIG_PM disabled. Esp when bringing up new
Silicon, this is a useful and often important requirement.

Instead we allow for CONFIG_PM to be selectable as desired.
Currently voltage files messup the build

Note: this is just a proposal - I have'nt actually done a clean build,
testing etc.. and was hoping to get some opinions why we have a hard
dependency on PM for OMAP2

Cc: Paul <paul@pwsan.com>
Cc: Tony <tony@atomide.com>
Cc: Kevin <khilman@ti.com>

---
patch approx based on pm-core

 arch/arm/mach-omap2/Kconfig  |    2 --
 arch/arm/mach-omap2/Makefile |   12 ++++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b9d8a7b..1c99a01 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -7,8 +7,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 	default y
 	select AEABI
 	select REGULATOR
-	select PM
-	select PM_RUNTIME
 	select VFP
 	select NEON if ARCH_OMAP3 || ARCH_OMAP4
 	select SERIAL_OMAP
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1d4d2ff..6d7f155 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -79,8 +79,7 @@ endif
 
 # PRCM
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
-					   vc3xxx_data.o vp3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cminst44xx.o cm44xx.o \
 					   prcm_mpu44xx.o prminst44xx.o
 # XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
@@ -88,8 +87,12 @@ obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cminst44xx.o cm44xx.o \
 # use OMAP4-specific PRCM functions.
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
 					   cm44xx.o prcm_mpu44xx.o \
-					   prminst44xx.o vc44xx_data.o \
-					   vp44xx_data.o
+					   prminst44xx.o
+
+ifeq ($(CONFIG_PM),y)
+# OMAP Voltage h/w module specific
+obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= vc44xx_data.o vp44xx_data.o
 
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o
@@ -98,6 +101,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
 					   voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
 					   voltagedomains44xx_data.o
+endif
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
-- 
1.7.1

