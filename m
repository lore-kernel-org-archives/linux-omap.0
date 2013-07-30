From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 3/8] ARM: DRA7: Reuse all of PRCM and MPUSS SMP infra
Date: Tue, 30 Jul 2013 16:55:41 +0530
Message-ID: <1375183546-12758-4-git-send-email-rnayak@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42533 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649Ab3G3L0f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 07:26:35 -0400
In-Reply-To: <1375183546-12758-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, Rajendra Nayak <rnayak@ti.com>

From: R Sricharan <r.sricharan@ti.com>

The PRCM and MPUSS parts of DRA7 devices are quite identical
to OMAP5 so as to reuse all the existing infrastructure around it.
Makefile updates to do just that.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d4f6715..17fb8b7 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_AM33XX) += irq.o $(hwmod-common)
 obj-$(CONFIG_SOC_OMAP5)	 += prm44xx.o $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_AM43XX) += $(hwmod-common) $(secure-common)
+obj-$(CONFIG_SOC_DRA7XX) += prm44xx.o $(hwmod-common) $(secure-common)
 
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
@@ -39,6 +40,7 @@ omap-4-5-common				=  omap4-common.o omap-wakeupgen.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common) $(smp-y) sleep44xx.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common) $(smp-y) sleep44xx.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(omap-4-5-common)
+obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-common) $(smp-y)
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
@@ -87,6 +89,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
+obj-$(CONFIG_SOC_DRA7XX)		+= omap-mpuss-lowpower.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
@@ -114,6 +117,7 @@ omap-prcm-4-5-common			=  cminst44xx.o cm44xx.o prm44xx.o \
 					   vc44xx_data.o vp44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-prcm-4-5-common)
+obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-prcm-4-5-common)
 
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o vc.o vp.o
@@ -143,6 +147,7 @@ obj-$(CONFIG_SOC_AM33XX)		+= powerdomains33xx_data.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(powerdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(powerdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= powerdomains54xx_data.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(powerdomain-common)
 
 # PRCM clockdomain control
 clockdomain-common			+= clockdomain.o
@@ -160,6 +165,7 @@ obj-$(CONFIG_SOC_AM33XX)		+= clockdomains33xx_data.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(clockdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(clockdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= clockdomains54xx_data.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(clockdomain-common)
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
@@ -181,6 +187,8 @@ obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
 obj-$(CONFIG_SOC_AM33XX)		+= cclock33xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
 obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(clock-common)
+obj-$(CONFIG_SOC_DRA7XX)		+= dpll3xxx.o dpll44xx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
-- 
1.7.9.5

