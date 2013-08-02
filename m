From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 11/13] ARM: OMAP2+: AM43x: PRCM kbuild
Date: Fri, 2 Aug 2013 19:08:14 +0530
Message-ID: <51118b72f815bdd6e563e64192ec6788e9e45505.1375443858.git.afzal@ti.com>
References: <cover.1375443858.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60847 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661Ab3HBNio (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 09:38:44 -0400
In-Reply-To: <cover.1375443858.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <benoit.cousson@linaro.org>, benoit.cousson@gmail.com

Build AM43x power domain, clock domain and hwmod data.

Many of AM43x IP's and interconnects are similar as that in AM335x,
hence AM335x hwmod data is being reused with necessary changes.

Earlier the plan was to reuse AM335x specific PRCM code, but as AM43x
PRCM is much similar to OMAP4/5, AM335x PRCM is divorced and instead
married with OMAP4/5 PRCM for AM43x.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/Makefile |    5 ++++-
 arch/arm/mach-omap2/cm33xx.h |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d4f6715..bfc1eb7 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -108,12 +108,12 @@ obj-$(CONFIG_ARCH_OMAP2)		+= prm2xxx_3xxx.o prm2xxx.o cm2xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prm2xxx_3xxx.o prm3xxx.o cm3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= prm33xx.o cm33xx.o
-obj-$(CONFIG_SOC_AM43XX)		+= prm33xx.o cm33xx.o
 omap-prcm-4-5-common			=  cminst44xx.o cm44xx.o prm44xx.o \
 					   prcm_mpu44xx.o prminst44xx.o \
 					   vc44xx_data.o vp44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-prcm-4-5-common)
+obj-$(CONFIG_SOC_AM43XX)		+= $(omap-prcm-4-5-common)
 
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o vc.o vp.o
@@ -141,6 +141,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(powerdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= powerdomains33xx_data.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(powerdomain-common)
+obj-$(CONFIG_SOC_AM43XX)		+= powerdomains43xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(powerdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= powerdomains54xx_data.o
 
@@ -158,6 +159,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clockdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= clockdomains33xx_data.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(clockdomain-common)
+obj-$(CONFIG_SOC_AM43XX)		+= clockdomains43xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(clockdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= clockdomains54xx_data.o
 
@@ -201,6 +203,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_interconnect_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_data.o
+obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap_hwmod_54xx_data.o
 
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 201e507..757b9a1 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -383,7 +383,7 @@ extern void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs);
 extern void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs);
 extern void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs);
 
-#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
+#ifdef CONFIG_SOC_AM33XX
 extern int am33xx_cm_wait_module_idle(u16 inst, u16 cdoffs,
 					u16 clkctrl_offs);
 extern void am33xx_cm_module_enable(u8 mode, u16 inst, u16 cdoffs,
-- 
1.7.9.5

