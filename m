From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]TWL4030 battery driver madc str fix
Date: Thu, 18 Sep 2008 17:28:30 +0530 (IST)
Message-ID: <33445.192.168.10.89.1221739110.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44045 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbYIRL6m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 07:58:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi Tony,

I am resending the patch after fixing the comment provided by Jagadeesh.

Regards,
Madhu
-------------------------------------------------------------------------
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
17:12:22.000000000 +0530
@@ -604,7 +604,9 @@
 	struct twl4030_madc_request req;

 	req.channels = (1 << 9);
+	req.do_avg = 0;
 	req.method = TWL4030_MADC_SW1;
+	req.active = 0;
 	req.func_cb = NULL;
 	twl4030_madc_conversion(&req);
 	temp = (u16)req.rbuf[9];


