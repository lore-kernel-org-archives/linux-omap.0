From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 39/86] [ARM] OMAP24xx clock: add missing SSI L4 interface clock
Date: Thu, 12 Mar 2009 11:27:49 -0700
Message-ID: <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756652AbZCLSbi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:38 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:36 -0700 (PDT)
In-Reply-To: <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

This patch adds a missing OMAP24xx clock, the SSI L4 interface clock,
as "ssi_l4_ick".

linux-omap source commit is ace129d39b3107d330d4cf6934385d13521f2fec.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock24xx.c |    1 +
 arch/arm/mach-omap2/clock24xx.h |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 91ad207..421728a 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -112,6 +112,7 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_243X | CK_242X),
 	/* L4 domain clocks */
 	CLK(NULL,	"l4_ck",	&l4_ck,		CK_243X | CK_242X),
+	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X | CK_242X),
 	/* virtual meta-group clock */
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X | CK_242X),
 	/* general l4 interface ck, multi-parent functional clk */
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index b244247..32dd857 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -1276,6 +1276,20 @@ static struct clk ssi_ssr_sst_fck = {
 	.set_rate	= &omap2_clksel_set_rate
 };
 
+/*
+ * Presumably this is the same as SSI_ICLK.
+ * TRM contradicts itself on what clockdomain SSI_ICLK is in
+ */
+static struct clk ssi_l4_ick = {
+	.name		= "ssi_l4_ick",
+	.ops		= &clkops_omap2_dflt_wait,
+	.parent		= &l4_ck,
+	.clkdm_name	= "core_l4_clkdm",
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
 
 /*
  * GFX clock domain
-- 
1.6.1.2

