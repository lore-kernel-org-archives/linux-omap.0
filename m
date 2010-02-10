From: Abhijit Pagare <abhijitpagare@ti.com>
Subject: [PATCH] ARM: OMAP4 clock domain: Add check for avoiding dependency related update.
Date: Wed, 10 Feb 2010 13:42:03 +0530
Message-ID: <1265789523-6413-1-git-send-email-abhijitpagare@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43639 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab0BJIMS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 03:12:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Abhijit Pagare <abhijitpagare@ti.com>, Paul Walmsley <paul@pwsan.com>

A check is added for avoiding the sleep/wakeup dependency updates
for OMAP4 as the structures for the dependencies are currently absent.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
Re-submitting

Compiled and Boot Tested on OMAP4430 simulator, ES1 Chip & OMAP3430 SDP.
And also Compiled for OMAP2430 and OMAP2420

This patch has a dependency on the earlier set of OMAP4 clock-domain patches.

 arch/arm/mach-omap2/clockdomain.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 8c9e78c..6ec25ee 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -507,8 +507,9 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
 	pr_debug("clockdomain: enabling automatic idle transitions for %s\n",
 		 clkdm->name);
 
-	if (atomic_read(&clkdm->usecount) > 0)
-		_clkdm_add_autodeps(clkdm);
+	if (!cpu_is_omap44xx())
+		if (atomic_read(&clkdm->usecount) > 0)
+			_clkdm_add_autodeps(clkdm);
 
 	_omap2_clkdm_set_hwsup(clkdm, 1);
 
@@ -540,8 +541,9 @@ void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
 
 	_omap2_clkdm_set_hwsup(clkdm, 0);
 
-	if (atomic_read(&clkdm->usecount) > 0)
-		_clkdm_del_autodeps(clkdm);
+	if (!cpu_is_omap44xx())
+		if (atomic_read(&clkdm->usecount) > 0)
+			_clkdm_del_autodeps(clkdm);
 }
 
 
-- 
1.5.4.7

