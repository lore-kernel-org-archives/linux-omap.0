From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2] OMAP: pm.c correct the initcall for an early init.
Date: Mon, 20 Dec 2010 21:17:21 +0530
Message-ID: <1292860041-31889-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59937 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932243Ab0LTPra (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 10:47:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Thara Gopinath <thara@ti.com>

omap2_common_pm_init is the API where generic system devices like
mpu, l3 etc get initialized. This has to happen really early on
during the boot and not at a later time. This is especially important
with the new opp changes as these devices need to be built before the
opp tables init happen. Today both are device initcalls and it works
just because of the order of compilation. Making this postcore_initcall
is ideal because the omap device layer init happens as a core_initcall
and typically rest of the driver/device inits are arch_initcall or
something lower.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index cf1c4c9..227a211 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -143,5 +143,5 @@ static int __init omap2_common_pm_init(void)
 
 	return 0;
 }
-device_initcall(omap2_common_pm_init);
+postcore_initcall(omap2_common_pm_init);
 
-- 
1.7.0.4

