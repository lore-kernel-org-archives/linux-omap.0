From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]TWL4030 battery driver madc str fix
Date: Thu, 18 Sep 2008 14:14:41 +0530 (IST)
Message-ID: <56082.192.168.10.89.1221727481.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46759 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380AbYIRIo5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Sep 2008 04:44:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi Tony,

This patch set up the unused memebrs of the madc structure used in the battery
driver to NULL.

Regards,
Madhu
-------------------------------------------------------
From: Madhusudhan Chikkature<madhu.cr@ti.com>

This patch set up the unused madc request structure members to NULL.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 drivers/power/twl4030_bci_battery.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-omap-2.6/drivers/power/twl4030_bci_battery.c
===================================================================
--- linux-omap-2.6.orig/drivers/power/twl4030_bci_battery.c	2008-09-10
10:16:20.000000000 +0530
+++ linux-omap-2.6/drivers/power/twl4030_bci_battery.c	2008-09-18
11:06:07.000000000 +0530
@@ -604,7 +604,9 @@ static int twl4030backupbatt_voltage(voi
 	struct twl4030_madc_request req;

 	req.channels = (1 << 9);
+	req.do_avg = NULL;
 	req.method = TWL4030_MADC_SW1;
+	req.active = NULL;
 	req.func_cb = NULL;
 	twl4030_madc_conversion(&req);
 	temp = (u16)req.rbuf[9];


