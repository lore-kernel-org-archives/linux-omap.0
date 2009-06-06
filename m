From: "Luke-Jr" <luke@dashjr.org>
Subject: [PATCH] arm: omap: n810: set lm8323 size_y to 12
Date: Sat, 6 Jun 2009 16:51:47 -0500
Message-ID: <200906061651.54915.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wsip-70-184-212-11.om.om.cox.net ([70.184.212.11]:39629 "EHLO
	hachi.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbZFFVvy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Jun 2009 17:51:54 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

>From de992fa168685ddd608fca0f54fcfbce2afc2963 Mon Sep 17 00:00:00 2001
From: Luke Dashjr <luke@dashjr.org>
Date: Sat, 6 Jun 2009 16:35:03 -0500
Subject: [PATCH] arm: omap: n810: set lm8323 size_y to 12

For some reason, this is needed for the shift keys and "fghjvbnm"

Signed-off-by: Luke Dashjr <luke@dashjr.org>
---
 arch/arm/mach-omap2/board-n800.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-
n800.c
index cb32b61..0a50fd3 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -115,7 +115,7 @@ static struct lm8323_platform_data lm8323_pdata = {
 	.repeat		= 0, /* Repeat is handled in userspace for now. */
 	.keymap		= rx44_keymap,
 	.size_x		= 8,
-	.size_y		= 8,
+	.size_y		= 12,
 	.debounce_time	= 12,
 	.active_time	= 500,
 
-- 
1.6.0.6


