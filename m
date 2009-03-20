From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 03/03] OMAP3 clock: Fix locking in notifier register
Date: Fri, 20 Mar 2009 19:20:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF3A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34694 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753949AbZCTNvJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:51:09 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDp0Yi018081
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:51:07 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDp0tb006897
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 19:21:00 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch avoids spinlocks being held when calling
blocking_notifier_chain_register().

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/clock.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-omap-pm/arch/arm/plat-omap/clock.c
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/clock.c	2009-03-20 17:11:54.000000000 +0530
+++ linux-omap-pm/arch/arm/plat-omap/clock.c	2009-03-20 19:14:35.387298482 +0530
@@ -673,7 +673,11 @@ int clk_notifier_register(struct clk *cl
 		kfree(cn_new); /* didn't need it after all */
 	}
 
+	spin_unlock_irqrestore(&clockfw_lock, flags);
+
 	r = blocking_notifier_chain_register(&cn->notifier_head, nb);
+
+	spin_lock_irqsave(&clockfw_lock, flags);
 	if (!r) {
 		clkp = clk;
 		do {