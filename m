From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH 10/10] HDQ driver: Make hdq_reg_out as void
Date: Thu, 25 Sep 2008 12:31:38 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EC4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49092 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbYIYHCW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 03:02:22 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "johnpol@2ka.mipt.ru" <johnpol@2ka.mipt.ru>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

From: Madhusudhan Chikkature <madhu.cr@ti.com>

Make hdq_reg_out as void and remove suspend, resume from the driver structure.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 drivers/w1/masters/omap_hdq.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
===================================================================
--- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24 15:37:18.000000000 +0530
+++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-25 10:19:22.000000000 +0530
@@ -55,11 +55,13 @@ static int w1_id;
 struct hdq_data {
 	struct device		*dev;
 	void __iomem		*hdq_base;
+	/* lock status update */
 	struct  mutex		hdq_mutex;
 	int			hdq_usecount;
 	struct	clk		*hdq_ick;
 	struct	clk		*hdq_fck;
 	u8			hdq_irqstatus;
+	/* device lock */
 	spinlock_t		hdq_spinlock;
 	/*
 	 * Used to control the call to omap_hdq_get and omap_hdq_put.
@@ -79,8 +81,6 @@ static int omap_hdq_remove(struct platfo
 static struct platform_driver omap_hdq_driver = {
 	.probe =	omap_hdq_probe,
 	.remove =	omap_hdq_remove,
-	.suspend =	NULL,
-	.resume =	NULL,
 	.driver =	{
 		.name =	"omap_hdq",
 	},
@@ -106,11 +106,9 @@ static inline u8 hdq_reg_in(struct hdq_d
 	return __raw_readb(hdq_data->hdq_base + offset);
 }
 
-static inline u8 hdq_reg_out(struct hdq_data *hdq_data, u32 offset, u8 val)
+static inline void hdq_reg_out(struct hdq_data *hdq_data, u32 offset, u8 val)
 {
 	__raw_writeb(val, hdq_data->hdq_base + offset);
-
-	return val;
 }
 
 static inline u8 hdq_reg_merge(struct hdq_data *hdq_data, u32 offset,
@@ -715,17 +713,17 @@ omap_hdq_init(void)
 {
 	return platform_driver_register(&omap_hdq_driver);
 }
+module_init(omap_hdq_init);
 
 static void __exit
 omap_hdq_exit(void)
 {
 	platform_driver_unregister(&omap_hdq_driver);
 }
-
-module_init(omap_hdq_init);
 module_exit(omap_hdq_exit);
 
 module_param(w1_id, int, S_IRUSR);
+MODULE_PARM_DESC(w1_id, "1-wire id for the slave detection");
 
 MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("HDQ driver Library");