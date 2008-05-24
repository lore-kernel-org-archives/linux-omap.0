From: trickie@gmail.com
Subject: [PATCH] Fix compile on n800 if CONFIG_MACH_NOKIA_N810 is not set
Date: Sat, 24 May 2008 20:43:50 +0200
Message-ID: <1211654630-15547-1-git-send-email-trickie@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:7426 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbYEXSny (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 May 2008 14:43:54 -0400
Received: by ug-out-1314.google.com with SMTP id h2so118860ugf.16
        for <linux-omap@vger.kernel.org>; Sat, 24 May 2008 11:43:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nick Loeve <trickie@gmail.com>


Signed-off-by: Nick Loeve <trickie@gmail.com>
---
 arch/arm/mach-omap2/board-n800-camera.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-camera.c b/arch/arm/mach-omap2/board-n800-camera.c
index b525125..63bca1f 100644
--- a/arch/arm/mach-omap2/board-n800-camera.c
+++ b/arch/arm/mach-omap2/board-n800-camera.c
@@ -221,9 +221,10 @@ static int tcm825x_power_set(int power)
 
 static const struct tcm825x_reg *tcm825x_default_regs(void)
 {
-	if (machine_is_nokia_n810())
+#ifdef CONFIG_MACH_NOKIA_N810	
+        if (machine_is_nokia_n810())
 		return tcm825x_regs_n810;
-
+#endif
 	return tcm825x_regs_n800;
 }
 
-- 
1.5.5.1

