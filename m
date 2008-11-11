From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 12/59] omap: namespace cleanup to arch/arm/mach-omap1/io.c
Date: Wed, 12 Nov 2008 00:56:31 +0200
Message-ID: <1226444238-14614-13-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40083 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYKKXBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:01:25 -0500
In-Reply-To: <1226444238-14614-12-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/io.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index b3bd8ca..4670435 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -133,8 +133,8 @@ void __init omap1_init_common_hw()
 	/* REVISIT: Refer to OMAP5910 Errata, Advisory SYS_1: "Timeout Abort
 	 * on a Posted Write in the TIPB Bridge".
 	 */
-	omap_writew(0x0, MPU_PUBLIC_TIPB_CNTL);
-	omap_writew(0x0, MPU_PRIVATE_TIPB_CNTL);
+	__raw_writew(0x0, MPU_PUBLIC_TIPB_CNTL);
+	__raw_writew(0x0, MPU_PRIVATE_TIPB_CNTL);
 
 	/* Must init clocks early to assure that timer interrupt works
 	 */
-- 
1.6.0.2.307.gc427

