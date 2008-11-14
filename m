From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 clock: disable DPLL autoidle while waiting for DPLL
 to lock
Date: Fri, 14 Nov 2008 10:46:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811141043400.27331@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59231 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbYKNRqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 12:46:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter de Schrijver <peter.de-schrijver@nokia.com>, khilman@deeprootsystems.com


During _omap3_noncore_dpll_lock(), if a DPLL has no active downstream
clocks and DPLL autoidle is enabled, the DPLL may never lock, since it
will enter autoidle immediately.  To resolve this, disable DPLL
autoidle while locking the DPLL, and unconditionally wait for the DPLL
to lock.  This fixes some bugs where the kernel would hang when returning
from retention or return the wrong rate for the DPLL.

This patch is a collaboration with Peter de Schrijver 
<peter.de-schrijver@nokia.com> and Kevin Hilman 
<khilman@deeprootsystems.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Peter de Schrijver <peter.de-schrijver@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock34xx.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 3a4e160..b8b4494 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -163,19 +163,14 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
 
 	ai = omap3_dpll_autoidle_read(clk);
 
+	omap3_dpll_deny_idle(clk);
+
 	_omap3_dpll_write_clken(clk, DPLL_LOCKED);
 
-	if (ai) {
-		/*
-		 * If no downstream clocks are enabled, CM_IDLEST bit
-		 * may never become active, so don't wait for DPLL to lock.
-		 */
-		r = 0;
+	r = _omap3_wait_dpll_status(clk, 1);
+
+	if (ai)
 		omap3_dpll_allow_idle(clk);
-	} else {
-		r = _omap3_wait_dpll_status(clk, 1);
-		omap3_dpll_deny_idle(clk);
-	};
 
 	return r;
 }
