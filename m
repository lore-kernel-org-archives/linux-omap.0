From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: PM: Added resource refresh to OPP unlock requests
Date: Thu, 14 May 2009 15:09:34 +0300
Message-ID: <1242302974-4060-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:16999 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407AbZENMgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 08:36:10 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4ECZcXW025661
	for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 15:36:03 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n4ECa47F007357
	for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 15:36:04 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This will set the correct OPP after a lock has been released from sysfs.

Applies on PM branch.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index dde0af3..58ed520 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -166,6 +166,7 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
 		attr = &vdd1_opp_attr;
 		if (vdd1_locked && value == 0) {
 			resource_unlock_opp(VDD1_OPP);
+			resource_refresh();
 			vdd1_locked = 0;
 			return n;
 		}
@@ -178,6 +179,7 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
 		attr = &vdd2_opp_attr;
 		if (vdd2_locked && value == 0) {
 			resource_unlock_opp(VDD2_OPP);
+			resource_refresh();
 			vdd2_locked = 0;
 			return n;
 		}
-- 
1.5.4.3

