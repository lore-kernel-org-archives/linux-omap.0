From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 10/11] ARM: OMAP2+: AM43x: PRCM kbuild
Date: Tue, 1 Oct 2013 12:38:26 +0530
Message-ID: <c368465e5bd580d811bac5c072e54272082118fd.1380608720.git.afzal@ti.com>
References: <cover.1380608719.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46984 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab3JAHIx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Oct 2013 03:08:53 -0400
In-Reply-To: <cover.1380608719.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>

Build AM43x power domain, clock domain and hwmod data.

Many of AM43x IP's and interconnects are similar as that in AM335x,
hence AM335x hwmod data is being reused with necessary changes.

Earlier the plan was to reuse AM335x specific PRCM code, but as AM43x
PRCM register layout is much similar to OMAP4/5, AM335x PRCM is
divorced and instead married with OMAP4/5 PRCM for AM43x.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/Makefile | 7 ++++++-
 arch/arm/mach-omap2/cm33xx.h | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0746494..cb7b527 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -112,13 +112,13 @@ obj-$(CONFIG_ARCH_OMAP2)		+= prm2xxx_3xxx.o prm2xxx.o cm2xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prm2xxx_3xxx.o prm3xxx.o cm3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= prm33xx.o cm33xx.o
-obj-$(CONFIG_SOC_AM43XX)		+= prm33xx.o cm33xx.o
 omap-prcm-4-5-common			=  cminst44xx.o cm44xx.o prm44xx.o \
 					   prcm_mpu44xx.o prminst44xx.o \
 					   vc44xx_data.o vp44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-prcm-4-5-common)
+obj-$(CONFIG_SOC_AM43XX)		+= $(omap-prcm-4-5-common)
 
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o vc.o vp.o
@@ -146,6 +146,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(powerdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= powerdomains33xx_data.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(powerdomain-common)
+obj-$(CONFIG_SOC_AM43XX)		+= powerdomains43xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(powerdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= powerdomains54xx_data.o
 obj-$(CONFIG_SOC_DRA7XX)		+= $(powerdomain-common)
@@ -165,6 +166,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clockdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= clockdomains33xx_data.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(clockdomain-common)
+obj-$(CONFIG_SOC_AM43XX)		+= clockdomains43xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(clockdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= clockdomains54xx_data.o
 obj-$(CONFIG_SOC_DRA7XX)		+= $(clockdomain-common)
@@ -212,6 +214,9 @@ obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_43xx_interconnect_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_43xx_ipblock_data.o
+obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_43xx_data.o
+obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_33xx_43xx_interconnect_data.o
+obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_33xx_43xx_ipblock_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap_hwmod_54xx_data.o
 obj-$(CONFIG_SOC_DRA7XX)		+= omap_hwmod_7xx_data.o
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 757320b..cfb8891 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -383,7 +383,7 @@ void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs);
 void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs);
 void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs);
 
-#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
+#ifdef CONFIG_SOC_AM33XX
 extern int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs,
 					u16 clkctrl_offs);
 extern void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
-- 
1.8.3.4

