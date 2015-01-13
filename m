From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/7] ARM: OMAP2+: Fix dm814 and dm816 for clocks and timer init
Date: Tue, 13 Jan 2015 15:13:55 -0800
Message-ID: <1421190837-4692-6-git-send-email-tony@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29257 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752373AbbAMXSA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 18:18:00 -0500
In-Reply-To: <1421190837-4692-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

Fix dm814 and dm816 clocks and timer init.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/prm_common.c | 4 ++++
 arch/arm/mach-omap2/timer.c      | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 779940c..b658785 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -571,6 +571,10 @@ static const struct of_device_id omap_prcm_dt_match_table[] = {
 	{ .compatible = "ti,am3-scrm" },
 	{ .compatible = "ti,am4-prcm" },
 	{ .compatible = "ti,am4-scrm" },
+	{ .compatible = "ti,dm814-prcm" },
+	{ .compatible = "ti,dm814-scrm" },
+	{ .compatible = "ti,dm816-prcm" },
+	{ .compatible = "ti,dm816-scrm" },
 	{ .compatible = "ti,omap2-prcm" },
 	{ .compatible = "ti,omap2-scrm" },
 	{ .compatible = "ti,omap3-prm" },
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 4f61148..376b099 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -146,6 +146,8 @@ static const struct of_device_id omap_timer_match[] __initconst = {
 	{ .compatible = "ti,omap3430-timer", },
 	{ .compatible = "ti,omap4430-timer", },
 	{ .compatible = "ti,omap5430-timer", },
+	{ .compatible = "ti,dm814-timer", },
+	{ .compatible = "ti,dm816-timer", },
 	{ .compatible = "ti,am335x-timer", },
 	{ .compatible = "ti,am335x-timer-1ms", },
 	{ }
-- 
2.1.4

