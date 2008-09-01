From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 04/12] I2C re-init for every cmd
Date: Mon, 1 Sep 2008 19:08:26 +0530 (IST)
Message-ID: <59975.192.168.10.89.1220276306.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39004 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbYIANid (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2008 09:38:33 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81DcR1C019868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:38:32 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m81DcPUv018909
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:38:26 -0500 (CDT)
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
--- linux-omap-2.6.orig/drivers/i2c/busses/i2c-omap.c	2008-09-01
18:11:28.000000000 +0530
+++ linux-omap-2.6/drivers/i2c/busses/i2c-omap.c	2008-09-01 18:11:52.000000000
+0530
@@ -496,6 +496,8 @@ omap_i2c_xfer(struct i2c_adapter *adap,

 	omap_i2c_unidle(dev);

+	omap_i2c_init(dev);
+
 	if ((r = omap_i2c_wait_for_bb(dev)) < 0)
 		goto out;



