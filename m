From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 10/11] i2c context save/restore
Date: Tue, 1 Jul 2008 19:46:36 +0530
Message-ID: <004701c8db85$12442bd0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:37965 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759694AbYGAOQo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Jul 2008 10:16:44 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m61EGane003307
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 09:16:42 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m61EGXpl011584
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 19:46:35 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch does i2c init/re-init for every transfer

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-omap-2.6/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-omap-2.6.orig/drivers/i2c/busses/i2c-omap.c	2008-06-09 10:21:40.000000000 +0530
+++ linux-omap-2.6/drivers/i2c/busses/i2c-omap.c	2008-06-09 10:57:32.871082795 +0530
@@ -490,6 +490,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, 
 
 	omap_i2c_unidle(dev);
 
+	omap_i2c_init(dev);
+
 	if ((r = omap_i2c_wait_for_bb(dev)) < 0)
 		goto out;
 

