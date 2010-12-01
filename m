From: Thara Gopinath <thara@ti.com>
Subject: [PATCH] OMAP: pm.c correct the initcall for an early init.
Date: Wed,  1 Dec 2010 16:31:23 +0530
Message-ID: <1291201283-21185-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57135 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753874Ab0LALBd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 06:01:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Thara Gopinath <thara@ti.com>

omap2_common_pm_init is the API where generic system devices like
mpu, l3 etc get initialized. This has to happen really early on
during the boot and not at a later time. This is especially important
with the new opp changes as these devices need to be built before the
opp tables init happen. Today both are device initcalls and it works
just because of the order of compilation

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 59ca03b..6ec2ee1 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -143,5 +143,5 @@ static int __init omap2_common_pm_init(void)
 
 	return 0;
 }
-device_initcall(omap2_common_pm_init);
+postcore_initcall(omap2_common_pm_init);
 
-- 
1.7.0.4

