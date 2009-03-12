From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 34/86] [ARM] omap: convert omap RNG clocks to match by devid and conid
Date: Thu, 12 Mar 2009 11:27:44 -0700
Message-ID: <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756593AbZCLSbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:17 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:16 -0700 (PDT)
In-Reply-To: <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock24xx.c   |    2 +-
 arch/arm/mach-omap2/clock34xx.c   |    2 +-
 drivers/char/hw_random/omap-rng.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index f835880..1e9ac83 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -200,7 +200,7 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_243X),
 	CLK(NULL,	"des_ick",	&des_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"sha_ick",	&sha_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"rng_ick",	&rng_ick,	CK_243X | CK_242X),
+	CLK("omap_rng",	"ick",		&rng_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"aes_ick",	&aes_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X | CK_242X),
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 1a4bc33..07e3308 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -196,7 +196,7 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_3430ES1),
 	CLK(NULL,	"security_l4_ick2", &security_l4_ick2, CK_343X),
 	CLK(NULL,	"aes1_ick",	&aes1_ick,	CK_343X),
-	CLK(NULL,	"rng_ick",	&rng_ick,	CK_343X),
+	CLK("omap_rng",	"ick",		&rng_ick,	CK_343X),
 	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
 	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
 	CLK(NULL,	"dss1_alwon_fck", &dss1_alwon_fck, CK_343X),
diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index ba68a46..538313f 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -102,7 +102,7 @@ static int __init omap_rng_probe(struct platform_device *pdev)
 		return -EBUSY;
 
 	if (cpu_is_omap24xx()) {
-		rng_ick = clk_get(&pdev->dev, "rng_ick");
+		rng_ick = clk_get(&pdev->dev, "ick");
 		if (IS_ERR(rng_ick)) {
 			dev_err(&pdev->dev, "Could not get rng_ick\n");
 			ret = PTR_ERR(rng_ick);
-- 
1.6.1.2

