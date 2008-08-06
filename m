From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 10/11] i2c context save/restore
Date: Wed, 6 Aug 2008 18:48:54 +0530 (IST)
Message-ID: <48185.192.168.10.89.1218028734.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:52532 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985AbYHFNTA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Aug 2008 09:19:00 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m76DItB4020211
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:19:00 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m76DIpnU010200
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:18:53 -0500 (CDT)
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
--- linux-omap-2.6.orig/drivers/i2c/busses/i2c-omap.c	2008-08-06
18:07:31.000000000 +0530
+++ linux-omap-2.6/drivers/i2c/busses/i2c-omap.c	2008-08-06 18:11:28.000000000
+0530
@@ -496,6 +496,8 @@ omap_i2c_xfer(struct i2c_adapter *adap,

 	omap_i2c_unidle(dev);

+	omap_i2c_init(dev);
+
 	if ((r = omap_i2c_wait_for_bb(dev)) < 0)
 		goto out;



