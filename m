From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2/3 McBSP: add temporary clockdomain fix for McBSP
	virtual clocks
Date: Thu, 08 Jan 2009 08:28:59 -0700
Message-ID: <20090108152856.20939.71314.stgit@localhost.localdomain>
References: <20090108152853.20939.39831.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37743 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbZAHPaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 10:30:12 -0500
In-Reply-To: <20090108152853.20939.39831.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

The McBSP driver uses virtual clocks to handle enabling and disabling
its hardware clocks.  These virtual clocks have no associated
clockdomain. After commit 60b8b431e47d8c5b8c02a2e4fa9af388aae20790,
this prevents the McBSP clocks from registering correctly.
Resolve this for the short term by using virt_opp_clkdm for these clocks.
These McBSP virtual clocks should be removed, but such a fix would require
significant changes to the McBSP drivers that would require testing on
OMAP1, 2, and 3 platforms.

Tested on 2430SDP and 3430SDP GP ES2.1.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 arch/arm/mach-omap2/mcbsp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index cae3ebe..b40b29a 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -77,6 +77,7 @@ static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
 		.clk = {
 			.name 		= "mcbsp_clk",
 			.id		= 1,
+			.clkdm		= { .name = "virt_opp_clkdm" },
 			.enable		= omap_mcbsp_clk_enable,
 			.disable	= omap_mcbsp_clk_disable,
 		},
@@ -85,6 +86,7 @@ static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
 		.clk = {
 			.name 		= "mcbsp_clk",
 			.id		= 2,
+			.clkdm		= { .name = "virt_opp_clkdm" },
 			.enable		= omap_mcbsp_clk_enable,
 			.disable	= omap_mcbsp_clk_disable,
 		},
@@ -93,6 +95,7 @@ static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
 		.clk = {
 			.name		= "mcbsp_clk",
 			.id		= 3,
+			.clkdm		= { .name = "virt_opp_clkdm" },
 			.enable		= omap_mcbsp_clk_enable,
 			.disable	= omap_mcbsp_clk_disable,
 		},
@@ -101,6 +104,7 @@ static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
 		.clk = {
 			.name		= "mcbsp_clk",
 			.id		= 4,
+			.clkdm		= { .name = "virt_opp_clkdm" },
 			.enable		= omap_mcbsp_clk_enable,
 			.disable	= omap_mcbsp_clk_disable,
 		},
@@ -109,6 +113,7 @@ static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
 		.clk = {
 			.name		= "mcbsp_clk",
 			.id		= 5,
+			.clkdm		= { .name = "virt_opp_clkdm" },
 			.enable		= omap_mcbsp_clk_enable,
 			.disable	= omap_mcbsp_clk_disable,
 		},


