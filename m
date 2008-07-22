From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH] Free HDQ clocks in error path
Date: Tue, 22 Jul 2008 17:33:58 +0530 (IST)
Message-ID: <44661.192.168.10.89.1216728238.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:58280 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbYGVMEE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jul 2008 08:04:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi,

This patch provides the fix to free the HDQ clocks in the error path.

Regards,
Madhu
-----------------------------------------------------------------

From: Madhusudhan Chikkature<madhu.cr@ti.com>

ARM: OMAP3: Free HDQ clocks when a read is tried with no battery connected

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 drivers/w1/masters/omap_hdq.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-omap-ti.git-07102008/drivers/w1/masters/omap_hdq.c
===================================================================
--- linux-omap-ti.git-07102008.orig/drivers/w1/masters/omap_hdq.c	2008-07-02
20:10:38.000000000 +0530
+++ linux-omap-ti.git-07102008/drivers/w1/masters/omap_hdq.c	2008-07-16
12:17:42.000000000 +0530
@@ -515,8 +515,11 @@ static u8 omap_w1_read_byte(void *data)
 	int ret;

 	ret = hdq_read_byte(&val);
-	if (ret)
+	if (ret) {
+		init_trans = 0;
+		omap_hdq_put();
 		return -1;
+	}

 	/* Write followed by a read, release the module */
 	if (init_trans) {


