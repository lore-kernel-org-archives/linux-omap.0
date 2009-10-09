From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH]  OMAP3: PM: Do not allow OPP1 for VDD2
Date: Fri, 9 Oct 2009 11:38:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D093D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52493 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819AbZJIGJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 02:09:26 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

>From 144669d941a432875db37ae9431847f6753e566e Mon Sep 17 00:00:00 2001
From: Teerth Reddy <teerth@ti.com>
Date: Wed, 9 Sep 2009 11:01:04 +0530
Subject: OMAP3: PM: Do not allow OPP1 for VDD2

Since OPP1 is not a supported OPP for VDD2, do not allow it to
be changed using the sysfs interface.

Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/mach-omap2/pm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap-pm/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/pm.c
+++ linux-omap-pm/arch/arm/mach-omap2/pm.c
@@ -144,7 +144,7 @@ static ssize_t vdd_opp_store(struct kobj
 		}
 		resource_set_opp_level(VDD1_OPP, value, flags);
 	} else if (attr == &vdd2_opp_attr) {
-		if (value < 1 || value > 3) {
+		if (value < 2 || value > 3) {
 			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
 			return -EINVAL;
 		}
