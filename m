From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH 4/10] HDQ driver: remove unlikely calls
Date: Thu, 25 Sep 2008 12:24:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EB5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42690 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbYIYGyc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 02:54:32 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "johnpol@2ka.mipt.ru" <johnpol@2ka.mipt.ru>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

From: Madhusudhan Chikkature <madhu.cr@ti.com>

Remove the unneeded "unlikely" calls.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 drivers/w1/masters/omap_hdq.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
===================================================================
--- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24 09:33:39.000000000 +0530
+++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 10:10:07.000000000 +0530
@@ -138,7 +138,7 @@ static int hdq_wait_for_flag(struct hdq_
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
 		}
-		if (unlikely(*status & flag))
+		if (*status & flag)
 			ret = -ETIMEDOUT;
 	} else if (flag_set == OMAP_HDQ_FLAG_SET) {
 		/* wait for the flag set */
@@ -147,7 +147,7 @@ static int hdq_wait_for_flag(struct hdq_
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
 		}
-		if (unlikely(!(*status & flag)))
+		if (!(*status & flag))
 			ret = -ETIMEDOUT;
 	} else
 		return -EINVAL;
@@ -182,7 +182,7 @@ hdq_write_byte(struct hdq_data *hdq_data
 	/* wait for the TXCOMPLETE bit */
 	ret = wait_event_interruptible_timeout(hdq_wait_queue,
 		hdq_data->hdq_irqstatus, OMAP_HDQ_TIMEOUT);
-	if (unlikely(ret < 0)) {
+	if (ret < 0) {
 		dev_dbg(hdq_data->dev, "wait interrupted");
 		return -EINTR;
 	}
@@ -333,7 +333,7 @@ omap_hdq_break(struct hdq_data *hdq_data
 	/* wait for the TIMEOUT bit */
 	ret = wait_event_interruptible_timeout(hdq_wait_queue,
 		hdq_data->hdq_irqstatus, OMAP_HDQ_TIMEOUT);
-	if (unlikely(ret < 0)) {
+	if (ret < 0) {
 		dev_dbg(hdq_data->dev, "wait interrupted");
 		up(&hdq_data->hdq_semlock);
 		return -EINTR;