From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RESEND] omap_hdq: fix usecount handling
Date: Sat, 16 Jan 2016 13:48:50 +0100
Message-ID: <1452948530-10639-1-git-send-email-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>, hns@goldelico.com, Fabian Frederick <fabf@skynet.be>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

hdq_usecount was set to zero after a successful read, so
omap_hdq_put could not properly free resources which leads
e.g. to increasing usecounts in lsmod output

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/w1/masters/omap_hdq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 0e2f43b..a2eec97 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -618,7 +618,6 @@ static u8 omap_w1_read_byte(void *_hdq)
 
 	hdq_disable_interrupt(hdq_data, OMAP_HDQ_CTRL_STATUS,
 			      ~OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK);
-	hdq_data->hdq_usecount = 0;
 
 	/* Write followed by a read, release the module */
 	if (hdq_data->init_trans) {
-- 
2.1.4
