From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 22/23] OMAP3: PM: Enable VDD2 OPP1
Date: Thu, 11 Dec 2008 17:52:41 +0200
Message-ID: <1229010762-3150-23-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-8-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-11-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-12-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-13-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-14-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-15-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-16-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-17-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-18-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-19-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-20-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-21-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-22-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53972 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756217AbYLKP7V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:21 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBBFxClU006140
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 09:59:19 -0600
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mBBFwci3011022
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 17:59:09 +0200
In-Reply-To: <1229010762-3150-22-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

VDD2 OPP1 works at least with minimal kernel setup, there are some corner
cases where it fails though, like when you use USB. Board setup should make
sure and enable only working OPPs.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 155bd8d..1c6c93a 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -185,7 +185,7 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
 		}
 		resource_set_opp_level(VDD1_OPP, value, flags);
 	} else if (attr == &vdd2_opp_attr) {
-		if (value < 2 || value > 3) {
+		if (value < 1 || value > 3) {
 			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
 			return -EINVAL;
 		}
-- 
1.5.4.3

