From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 12/20] DSPBRIDGE: checkpatch foo-should-be for pointers
Date: Mon, 30 Nov 2009 15:54:53 -0600
Message-ID: <1259618101-8972-13-git-send-email-omar.ramirez@ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-3-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-4-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-5-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-6-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-7-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-8-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-9-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-10-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-11-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-12-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56616 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbZK3VtC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Nov 2009 16:49:02 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAULn7a0027029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 15:49:07 -0600
In-Reply-To: <1259618101-8972-12-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>

ERROR: "foo *__user * bar" should be "foo *__user *bar"

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index b213b82..397361c 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -54,7 +54,7 @@ union Trapped_Args {
 	} ARGS_MGR_UNREGISTEROBJECT;
 
 	struct {
-		struct DSP_NOTIFICATION  __user*__user *aNotifications;
+		struct DSP_NOTIFICATION  __user *__user *aNotifications;
 		u32 uCount;
 		u32 __user *puIndex;
 		u32 uTimeout;
@@ -111,7 +111,7 @@ union Trapped_Args {
 	struct {
 		DSP_HPROCESSOR hProcessor;
 		s32 iArgc;
-		char __user*__user *aArgv;
+		char __user *__user *aArgv;
 		char *__user *aEnvp;
 	} ARGS_PROC_LOAD;
 
-- 
1.6.2.4

