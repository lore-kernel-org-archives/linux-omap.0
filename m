From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/2] omap3: fix minor typos
Date: Tue, 15 Feb 2011 16:27:31 +0530
Message-ID: <1297767452-22554-2-git-send-email-premi@ti.com>
References: <1297767452-22554-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51776 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab1BOK5p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 05:57:45 -0500
In-Reply-To: <1297767452-22554-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

This patch fixes typos that were remaining after
the file and functions were renamed.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-flash.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index fd38c05..ce61200 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -1,5 +1,5 @@
 /*
- * board-sdp-flash.c
+ * board-flash.c
  * Modified from mach-omap2/board-3430sdp-flash.c
  *
  * Copyright (C) 2009 Nokia Corporation
@@ -189,7 +189,7 @@ unmap:
 }
 
 /**
- * sdp3430_flash_init - Identify devices connected to GPMC and register.
+ * board_flash_init - Identify devices connected to GPMC and register.
  *
  * @return - void.
  */
-- 
1.7.2.2

