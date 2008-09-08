From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/12] OMAP3 PRCM: add DPLL1-5 powerdomains, clockdomains
Date: Mon, 08 Sep 2008 10:57:46 -0600
Message-ID: <20080908165745.2540.54668.stgit@localhost.localdomain>
References: <20080908164444.2540.98619.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49064 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbYIIIU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 04:20:59 -0400
In-Reply-To: <20080908164444.2540.98619.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Each DPLL exists in its own powerdomain (cf 34xx TRM figure 4-18) and
clockdomain; so, create powerdomain and clockdomain structures for them.
These are used in a following patch for DPLL-related clocks.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomains.h     |   35 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains.h     |    5 +++++
 arch/arm/mach-omap2/powerdomains34xx.h |   31 ++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index 2156668..5234be1 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -249,6 +249,36 @@ static struct clockdomain emu_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+static struct clockdomain dpll1_clkdm = {
+	.name		= "dpll1_clkdm",
+	.pwrdm		= { .name = "dpll1_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct clockdomain dpll2_clkdm = {
+	.name		= "dpll2_clkdm",
+	.pwrdm		= { .name = "dpll2_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct clockdomain dpll3_clkdm = {
+	.name		= "dpll3_clkdm",
+	.pwrdm		= { .name = "dpll3_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct clockdomain dpll4_clkdm = {
+	.name		= "dpll4_clkdm",
+	.pwrdm		= { .name = "dpll4_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct clockdomain dpll5_clkdm = {
+	.name		= "dpll5_clkdm",
+	.pwrdm		= { .name = "dpll5_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+};
+
 #endif   /* CONFIG_ARCH_OMAP34XX */
 
 /*
@@ -310,6 +340,11 @@ static struct clockdomain *clockdomains_omap[] = {
 	&usbhost_clkdm,
 	&per_clkdm,
 	&emu_clkdm,
+	&dpll1_clkdm,
+	&dpll2_clkdm,
+	&dpll3_clkdm,
+	&dpll4_clkdm,
+	&dpll5_clkdm,
 #endif
 
 	NULL,
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index fba3440..51623e2 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -179,6 +179,11 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 	&emu_pwrdm,
 	&sgx_pwrdm,
 	&usbhost_pwrdm,
+	&dpll1_pwrdm,
+	&dpll2_pwrdm,
+	&dpll3_pwrdm,
+	&dpll4_pwrdm,
+	&dpll5_pwrdm,
 #endif
 
 	NULL
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index adbfa91..446a1ed 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -341,6 +341,37 @@ static struct powerdomain usbhost_pwrdm = {
 	},
 };
 
+static struct powerdomain dpll1_pwrdm = {
+	.name		= "dpll1_pwrdm",
+	.prcm_offs	= MPU_MOD,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct powerdomain dpll2_pwrdm = {
+	.name		= "dpll2_pwrdm",
+	.prcm_offs	= OMAP3430_IVA2_MOD,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct powerdomain dpll3_pwrdm = {
+	.name		= "dpll3_pwrdm",
+	.prcm_offs	= PLL_MOD,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct powerdomain dpll4_pwrdm = {
+	.name		= "dpll4_pwrdm",
+	.prcm_offs	= PLL_MOD,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct powerdomain dpll5_pwrdm = {
+	.name		= "dpll5_pwrdm",
+	.prcm_offs	= PLL_MOD,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+};
+
+
 #endif    /* CONFIG_ARCH_OMAP34XX */
 
 


