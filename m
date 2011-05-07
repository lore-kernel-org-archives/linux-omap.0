From: Rabin Vincent <rabin@rab.in>
Subject: [PATCH] OMAP4: fix return value of omap4_l3_init
Date: Sat,  7 May 2011 22:28:47 +0530
Message-ID: <1304787527-8314-1-git-send-email-rabin@rab.in>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41249 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab1EGQ6Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 May 2011 12:58:24 -0400
Received: by pzk9 with SMTP id 9so1830685pzk.19
        for <linux-omap@vger.kernel.org>; Sat, 07 May 2011 09:58:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rabin Vincent <rabin@rab.in>

Don't PTR_ERR() a non-error pointer:

 initcall omap4_l3_init+0x0/0xdc returned -544980480 after 0 usecs
 initcall omap4_l3_init+0x0/0xdc returned with error code -544980480

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7b85585..5b8ca68 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -97,7 +97,7 @@ static int __init omap4_l3_init(void)
 
 	WARN(IS_ERR(od), "could not build omap_device for %s\n", oh_name);
 
-	return PTR_ERR(od);
+	return IS_ERR(od) ? PTR_ERR(od) : 0;
 }
 postcore_initcall(omap4_l3_init);
 
-- 
1.7.4.1

