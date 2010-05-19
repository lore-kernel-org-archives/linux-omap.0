From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 20/22] OMAP4 powerdomain: Support LOWPOWERSTATECHANGE for
	powerdomains
Date: Tue, 18 May 2010 20:19:01 -0600
Message-ID: <20100519021900.19716.68006.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39833 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756050Ab0ESCVF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:21:05 -0400
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Some powerdomains in OMAP4 support a direct transition from one sleep
state to another deeper sleep state without having to wakeup the
powerdomain. This patch adds an api in the powerdomain framework to
set the LOWPOWERSTATECHANGE bit in PWRSTCTRL register.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c             |   28 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains44xx.h        |    9 ++++++++
 arch/arm/plat-omap/include/plat/powerdomain.h |    6 +++++
 3 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 4a91d38..f9f0bca 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -980,6 +980,34 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_set_lowpwrstchange - Request a low power state change
+ * @pwrdm: struct powerdomain *
+ *
+ * Allows a powerdomain to transtion to a lower power sleep state
+ * from an existing sleep state without waking up the powerdomain.
+ * Returns -EINVAL if the powerdomain pointer is null or if the
+ * powerdomain does not support LOWPOWERSTATECHANGE, or returns 0
+ * upon success.
+ */
+int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (!(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE))
+		return -EINVAL;
+
+	pr_debug("powerdomain: %s: setting LOWPOWERSTATECHANGE bit\n",
+		 pwrdm->name);
+
+	prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
+			     (1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
+			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
+
+	return 0;
+}
+
+/**
  * pwrdm_wait_transition - wait for powerdomain power transition to finish
  * @pwrdm: struct powerdomain * to wait for
  *
diff --git a/arch/arm/mach-omap2/powerdomains44xx.h b/arch/arm/mach-omap2/powerdomains44xx.h
index ad5a265..c721951 100644
--- a/arch/arm/mach-omap2/powerdomains44xx.h
+++ b/arch/arm/mach-omap2/powerdomains44xx.h
@@ -54,6 +54,7 @@ static struct powerdomain core_44xx_pwrdm = {
 		[3] = PWRDM_POWER_ON,	/* ducati_l2ram */
 		[4] = PWRDM_POWER_ON,	/* ducati_unicache */
 	},
+	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* gfx_44xx_pwrdm: 3D accelerator power domain */
@@ -69,6 +70,7 @@ static struct powerdomain gfx_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRDM_POWER_ON,	/* gfx_mem */
 	},
+	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* abe_44xx_pwrdm: Audio back end power domain */
@@ -87,6 +89,7 @@ static struct powerdomain abe_44xx_pwrdm = {
 		[0] = PWRDM_POWER_ON,	/* aessmem */
 		[1] = PWRDM_POWER_ON,	/* periphmem */
 	},
+	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* dss_44xx_pwrdm: Display subsystem power domain */
@@ -103,6 +106,7 @@ static struct powerdomain dss_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRDM_POWER_ON,	/* dss_mem */
 	},
+	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* tesla_44xx_pwrdm: Tesla processor power domain */
@@ -123,6 +127,7 @@ static struct powerdomain tesla_44xx_pwrdm = {
 		[1] = PWRDM_POWER_ON,	/* tesla_l1 */
 		[2] = PWRDM_POWER_ON,	/* tesla_l2 */
 	},
+	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* wkup_44xx_pwrdm: Wake-up power domain */
@@ -227,6 +232,7 @@ static struct powerdomain ivahd_44xx_pwrdm = {
 		[2] = PWRDM_POWER_ON,	/* tcm1_mem */
 		[3] = PWRDM_POWER_ON,	/* tcm2_mem */
 	},
+	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* cam_44xx_pwrdm: Camera subsystem power domain */
@@ -242,6 +248,7 @@ static struct powerdomain cam_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRDM_POWER_ON,	/* cam_mem */
 	},
+	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* l3init_44xx_pwrdm: L3 initators pheripherals power domain  */
@@ -258,6 +265,7 @@ static struct powerdomain l3init_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRDM_POWER_ON,	/* l3init_bank1 */
 	},
+	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* l4per_44xx_pwrdm: Target peripherals power domain */
@@ -276,6 +284,7 @@ static struct powerdomain l4per_44xx_pwrdm = {
 		[0] = PWRDM_POWER_ON,	/* nonretained_bank */
 		[1] = PWRDM_POWER_ON,	/* retained_bank */
 	},
+	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index e7cc7e6..fb6ec74 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -50,6 +50,12 @@
 					  * in MEM bank 1 position. This is
 					  * true for OMAP3430
 					  */
+#define PWRDM_HAS_LOWPOWERSTATECHANGE	(1 << 2) /*
+						  * support to transition from a
+						  * sleep state to a lower sleep
+						  * state without waking up the
+						  * powerdomain
+						  */
 
 /*
  * Number of memory banks that are power-controllable.	On OMAP4430, the


