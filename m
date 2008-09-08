From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/12] OMAP2 clockdomain: add virt_opp_clkdm
Date: Mon, 08 Sep 2008 10:57:48 -0600
Message-ID: <20080908165748.2540.10459.stgit@localhost.localdomain>
References: <20080908164444.2540.98619.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49081 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbYIIIVF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 04:21:05 -0400
In-Reply-To: <20080908164444.2540.98619.stgit@localhost.localdomain>
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
 arch/arm/mach-omap2/clockdomains.h |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

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
index 5234be1..847e532 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -34,6 +34,15 @@ static struct clockdomain cm_clkdm = {
 };
 
 /*
+ * virt_opp_clkdm is intended solely for use with virtual OPP clocks,
+ * e.g., virt_prcm_set, until OPP handling is rationalized.
+ */
+static struct clockdomain virt_opp_clkdm = {
+	.name		= "virt_opp_clkdm",
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
+};
+
+/*
  * 2420-only clockdomains
  */
 
@@ -307,6 +316,7 @@ static struct clockdomain *clockdomains_omap[] = {
 
 	&cm_clkdm,
 	&prm_clkdm,
+	&virt_opp_clkdm,
 
 #ifdef CONFIG_ARCH_OMAP2420
 	&mpu_2420_clkdm,


