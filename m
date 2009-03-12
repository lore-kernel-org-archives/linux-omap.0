From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] PM: Fix compile warnings with !CONFIG_OMAP_PM_SRF
Date: Fri, 13 Mar 2009 02:28:27 +0530
Message-ID: <1236891507-5687-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33782 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757492AbZCLU6i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Mar 2009 16:58:38 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2CKwUwD023519
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 15:58:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Fixes the compile warnings:

  CC      arch/arm/mach-omap2/pm.o
arch/arm/mach-omap2/pm.c:47: warning: 'vdd1_locked' defined but not used
arch/arm/mach-omap2/pm.c:48: warning: 'vdd2_locked' defined but not used

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/pm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 61c6dfb..0fe6f1a 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -44,8 +44,10 @@ unsigned short clocks_off_while_idle;
 unsigned short enable_off_mode;
 unsigned short voltage_off_while_idle;
 atomic_t sleep_block = ATOMIC_INIT(0);
+#ifdef CONFIG_OMAP_PM_SRF
 static int vdd1_locked;
 static int vdd2_locked;
+#endif
 
 static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
 static ssize_t idle_store(struct kobject *k, struct kobj_attribute *,
-- 
1.5.6

