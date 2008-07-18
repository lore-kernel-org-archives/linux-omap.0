From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 10/11] i2c context save/restore
Date: Fri, 18 Jul 2008 18:49:48 +0530
Message-ID: <001c01c8e8d8$f3e39f20$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:40203 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755793AbYGRNT4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 09:19:56 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m6IDJnhB015222
	for <linux-omap@vger.kernel.org>; Fri, 18 Jul 2008 08:19:55 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m6IDJjb0007197
	for <linux-omap@vger.kernel.org>; Fri, 18 Jul 2008 18:49:48 +0530 (IST)
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
 

