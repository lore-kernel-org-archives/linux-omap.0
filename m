From: Angelo Arrifano <miknix@gmail.com>
Subject: [PATCH 3/3] [ARM] omap850: Use ck_ref clock for omap850.
Date: Sat, 05 Sep 2009 01:03:22 +0100
Message-ID: <4AA1AACA.2090600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:54818 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933927AbZIDX6j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 19:58:39 -0400
Received: by fxm17 with SMTP id 17so1001444fxm.37
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2009 16:58:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, "Zebediah C. McClure" <zmc@lurian.net>

This clock is required for booting.

Signed-off-by: Angelo Arrifano <miknix@gmail.com>
---
 arch/arm/mach-omap1/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 436eed2..d2d5ece 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -75,7 +75,7 @@ struct omap_clk {

 static struct omap_clk omap_clks[] = {
 	/* non-ULPD clocks */
-	CLK(NULL,	"ck_ref",	&ck_ref,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"ck_ref",	&ck_ref,	CK_16XX | CK_1510 | CK_7XX | CK_310),
 	CLK(NULL,	"ck_dpll1",	&ck_dpll1,	CK_16XX | CK_1510 | CK_310),
 	/* CK_GEN1 clocks */
 	CLK(NULL,	"ck_dpll1out",	&ck_dpll1out.clk, CK_16XX),
-- 
1.6.3.3

