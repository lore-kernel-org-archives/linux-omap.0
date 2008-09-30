From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH] OMAP3: Fix 34xx/35xx revision check
Date: Tue, 30 Sep 2008 21:52:15 +0100
Message-ID: <1222807935-27378-1-git-send-email-mans@mansr.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from agrajag.mansr.com ([78.86.181.102]:42021 "EHLO mail.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992AbYI3U7x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2008 16:59:53 -0400
Received: from thrashbarg.mansr.com (thrashbarg.mansr.com [78.86.181.100])
	by mail.mansr.com (Postfix) with ESMTP id 8E2581C009C
	for <linux-omap@vger.kernel.org>; Tue, 30 Sep 2008 21:52:15 +0100 (BST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The 35xx TRM lists incorrect values for the VERSION field of the
CONTROL_IDCODE register.  The correct values are those listed in
the 34xx TRM.

Correct message on boot verified on ES2.1 and ES3.0.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/mach-omap2/id.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index ab7a6e9..9f72ae6 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -162,14 +162,15 @@ void __init omap34xx_check_revision(void)
 	/*
 	 * Detection for 34xx ES2.0 and above can be done with just
 	 * hawkeye and rev. See TRM 1.5.2 Device Identification.
-	 * Note that rev cannot be used directly as ES1.0 uses value 0.
+	 * The 35xx TRM lists incorrect values for the revision number.
+	 * Correct values are documented in the 34xx TRM.
 	 */
 	idcode = read_tap_reg(OMAP_TAP_IDCODE);
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0xff;
 
 	if (hawkeye == 0xb7ae)
-		system_rev = 0x34300034 | ((1 + rev) << 12);
+		system_rev = 0x34300034 | (rev << 12);
 
 out:
 	switch (system_rev) {
-- 
1.6.0.2

