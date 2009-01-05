From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 20/23] OMAP2/3 clock: omap2_clk_enable(): fix usecount
	decrement bug
Date: Sun, 04 Jan 2009 19:35:00 -0700
Message-ID: <20090105023459.12661.1871.stgit@localhost.localdomain>
References: <20090105022953.12661.57701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42912 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbZAEDW6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2009 22:22:58 -0500
In-Reply-To: <20090105022953.12661.57701.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

If _omap2_clk_enable() fails, the clock's usecount must be decremented by
one no matter whether the clock has a parent or not.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 55f43d0..a9a2bbf 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -502,12 +502,10 @@ int omap2_clk_enable(struct clk *clk)
 	ret = _omap2_clk_enable(clk);
 
 	if (ret != 0) {
+		clk->usecount--;
 		omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
-
-		if (clk->parent) {
+		if (clk->parent)
 			omap2_clk_disable(clk->parent);
-			clk->usecount--;
-		}
 	}
 
 	return ret;


