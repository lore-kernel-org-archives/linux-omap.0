From: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Subject: [PATCH] ARM: OMAP2+: gpmc: fix: replace PTR_RET with PTR_ERR_OR_ZERO
Date: Fri, 11 Apr 2014 18:03:28 +0800
Message-ID: <1397210608-28318-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:26069 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756936AbaDKKF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2014 06:05:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Duan Jiong <duanj.fnst@cn.fujitsu.com>

PTR_RET is deprecated. Do not recommend its usage anymore.
Use PTR_ERR_OR_ZERO instead.

Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
---
 arch/arm/mach-omap2/gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ab43755..6a11bda 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1772,7 +1772,7 @@ static int __init omap_gpmc_init(void)
 	pdev = omap_device_build(DEVICE_NAME, -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 
-	return PTR_RET(pdev);
+	return PTR_ERR_OR_ZERO(pdev);
 }
 omap_postcore_initcall(omap_gpmc_init);
 
-- 
1.8.3.1

