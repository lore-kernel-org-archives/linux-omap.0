From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 1/1] Export notifier register functions for kernel module
 building
Date: Thu, 12 Feb 2009 14:50:56 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C1020@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39747 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbZBLJVd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 04:21:33 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1C9LQV6006758
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 03:21:32 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1C9LP6u002715
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 14:51:25 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From dde519d855e64a312331f86d9442c7b6d9ff0291 Mon Sep 17 00:00:00 2001
From: Ramesh Gupta G <grgupta@ti.com>
Date: Thu, 12 Feb 2009 00:39:47 +0530
Subject: [PATCH 1/1] Export notifier register functions for kernel module building.

This Patch exports symbols clk_notifier_register/unregister
function for other kernel modules usage.

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/plat-omap/clock.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index e0940a1..c8d9e96 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -680,6 +680,7 @@ int clk_notifier_register(struct clk *clk, struct notifier_block *nb)
 
 	return r;
 }
+EXPORT_SYMBOL(clk_notifier_register);
 
 /**
  * clk_notifier_unregister - remove a clock change notifier
@@ -735,6 +736,7 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
 
 	return r;
 }
+EXPORT_SYMBOL(clk_notifier_unregister);
 
 
 
-- 
1.5.3.2
