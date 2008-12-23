From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 19/22] OMAP2/3 clock: omap2_clk_enable(): fix usecount
	decrement bug
Date: Mon, 22 Dec 2008 23:38:44 -0700
Message-ID: <20081223063843.8542.58520.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52920 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbYLWGjz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:55 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
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
index 6a4bb39..fc2219d 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -508,12 +508,10 @@ int omap2_clk_enable(struct clk *clk)
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


