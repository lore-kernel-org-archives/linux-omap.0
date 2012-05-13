From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] ARM: OMAP4: hwspinlocks_init() should be static
Date: Sun, 13 May 2012 16:15:19 +0300
Message-ID: <1336914919-20032-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59125 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab2EMNP6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 May 2012 09:15:58 -0400
Received: by weyu7 with SMTP id u7so1253209wey.19
        for <linux-omap@vger.kernel.org>; Sun, 13 May 2012 06:15:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>

Sparse found out that hwspinlocks_init() wasn't marked static,
and it should've been.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-omap2/hwspinlock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
index 454dfce..8763c85 100644
--- a/arch/arm/mach-omap2/hwspinlock.c
+++ b/arch/arm/mach-omap2/hwspinlock.c
@@ -28,7 +28,7 @@ static struct hwspinlock_pdata omap_hwspinlock_pdata __initdata = {
 	.base_id = 0,
 };
 
-int __init hwspinlocks_init(void)
+static int __init hwspinlocks_init(void)
 {
 	int retval = 0;
 	struct omap_hwmod *oh;
-- 
1.7.5.4

