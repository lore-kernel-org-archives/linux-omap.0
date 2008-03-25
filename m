From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Missing mmc debounce clock (??)
Date: Tue, 25 Mar 2008 13:43:02 +0200
Message-ID: <20080325114302.GA4652@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33734 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbYCYN7e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2008 09:59:34 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2PDxGVl011992
	for <linux-omap@vger.kernel.org>; Tue, 25 Mar 2008 15:59:32 +0200
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

omap hsmmc driver is always complaining about the debounce clock. The
clock it's trying to get is not listed in clock34xx.c, the following
patch gets rid of debounce clock warning by adding the clock to the
clock list.

ps: it's RFC since I'm not really sure if it's the right clock although
docs says it's the functional 32k clock. Comments??


>From 2ef178c513ade5c029be582aa55b87daba3e333d Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Tue, 25 Mar 2008 13:38:50 +0200
Subject: [RFC PATCH] ARCH: OMAP3: Missing mmc debounce clock

This clock was missing from clock34xx.c so mmc was
unable to get it on omap_hsmmc.c giving us an uneeded
warning.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index b0741ba..056f8f6 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -44,6 +44,15 @@ static struct clk omap_32k_fck = {
 	.recalc		= &propagate_rate,
 };
 
+/* MMC debounce clock derivates from 32k functional clock */
+static struct clk mmchsdb_fck = {
+	.name		= "mmchsdb_fck",
+	.id		= 1,
+	.parent		= &omap_32k_fck,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk secure_32k_fck = {
 	.name		= "secure_32k_fck",
 	.rate		= 32768,
@@ -2863,6 +2872,7 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&ts_fck,
 	&usbtll_fck,
 	&core_96m_fck,
+	&mmchsdb_fck,
 	&mmchs3_fck,
 	&mmchs2_fck,
 	&mspro_fck,
-- 
1.5.5.rc0.16.g02b00



-- 
	- Balbi
