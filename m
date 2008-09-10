From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 10/12] OMAP2 clockdomain: add virt_opp_clkdm
Date: Wed, 10 Sep 2008 10:48:04 -0600
Message-ID: <20080910164801.17024.2204.stgit@localhost.localdomain>
References: <20080910164631.17024.43733.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58279 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbYIJQtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 12:49:00 -0400
In-Reply-To: <20080910164631.17024.43733.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Every OMAP2/3 clock will need to be associated with a clockdomain.
However, the "virt_prcm_set" clock has no clockdomain, since it is a
virtual clock without any hardware referents.  So, create a new
clockdomain, "virt_clkdm", for this clock.  This clockdomain should be
reusable for OMAP3 virtual clock nodes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.h    |    1 +
 arch/arm/mach-omap2/clockdomains.h |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index e339f6d..63349fa 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -2666,6 +2666,7 @@ static struct clk virt_prcm_set = {
 	.name		= "virt_prcm_set",
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				VIRTUAL_CLOCK | ALWAYS_ENABLED | DELAYED_APP,
+	.clkdm		= { .name = "virt_opp_clkdm" },
 	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
 	.recalc		= &omap2_table_mpu_recalc,	/* sets are keyed on mpu rate */
 	.set_rate	= &omap2_select_table_rate,
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index 5234be1..bafa650 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -34,6 +34,16 @@ static struct clockdomain cm_clkdm = {
 };
 
 /*
+ * virt_opp_clkdm is intended solely for use with virtual OPP clocks,
+ * e.g., virt_prcm_set, until OPP handling is rationalized.
+ */
+static struct clockdomain virt_opp_clkdm = {
+	.name		= "virt_opp_clkdm",
+	.pwrdm		= { .name = "wkup_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
+};
+
+/*
  * 2420-only clockdomains
  */
 
@@ -307,6 +317,7 @@ static struct clockdomain *clockdomains_omap[] = {
 
 	&cm_clkdm,
 	&prm_clkdm,
+	&virt_opp_clkdm,
 
 #ifdef CONFIG_ARCH_OMAP2420
 	&mpu_2420_clkdm,


