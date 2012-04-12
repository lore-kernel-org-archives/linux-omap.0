From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from both clk and hwmod
Date: Thu, 12 Apr 2012 19:11:38 +0530
Message-ID: <1334238098-29859-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50629 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab2DLNl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 09:41:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On OMAP4+, the clkdm association is moved to hwmod while on older OMAPs'
its associated with a clk.
Hence look for a clkdm in both clk and hwmod and warn only when
its missing in both. Also fix the pr_warning() to print the correct
hwmod name.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2c27fdb..83d56df 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -566,9 +566,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
-	if (!oh->_clk->clkdm)
+	if (!oh->_clk->clkdm && !oh->clkdm_name)
 		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
-			   oh->main_clk, oh->_clk->name);
+			   oh->name, oh->_clk->name);
 
 	return ret;
 }
-- 
1.7.1

