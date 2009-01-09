From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 5/8] OMAP3: PM: Enable VDD2 OPP1
Date: Fri,  9 Jan 2009 17:49:05 +0200
Message-ID: <1231516148-10260-6-git-send-email-tero.kristo@nokia.com>
References: <>
 <1231516148-10260-1-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-2-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-3-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-4-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-5-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49415 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbZAIP7g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 10:59:36 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n09FxL3A017085
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 17:59:34 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n09FwtlO031435
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 17:59:02 +0200
In-Reply-To: <1231516148-10260-5-git-send-email-tero.kristo@nokia.com>
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
index 186a0f0..61c6dfb 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -186,7 +186,7 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
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

