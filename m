From: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Subject: [PATCH] ARM: OMAP2+: replace PTR_RET with PTR_ERR_OR_ZERO
Date: Fri, 11 Apr 2014 18:03:44 +0800
Message-ID: <1397210624-28371-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:1866 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932296AbaDKKFx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2014 06:05:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Duan Jiong <duanj.fnst@cn.fujitsu.com>

PTR_RET is deprecated. Do not recommend its usage anymore.
Use PTR_ERR_OR_ZERO instead.

Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
---
 arch/arm/mach-omap2/devices.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index e58609b..ab84889 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -65,7 +65,7 @@ static int __init omap3_l3_init(void)
 
 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 
-	return PTR_RET(pdev);
+	return PTR_ERR_OR_ZERO(pdev);
 }
 omap_postcore_initcall(omap3_l3_init);
 
@@ -99,7 +99,7 @@ static int __init omap4_l3_init(void)
 
 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 
-	return PTR_RET(pdev);
+	return PTR_ERR_OR_ZERO(pdev);
 }
 omap_postcore_initcall(omap4_l3_init);
 
-- 
1.8.3.1

