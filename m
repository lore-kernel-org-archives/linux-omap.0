From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 6/6] OMAP: DSS2: DSI: fix IRQ debug prints
Date: Wed, 9 Mar 2011 09:21:28 +0200
Message-ID: <1299655288-7121-7-git-send-email-tomi.valkeinen@ti.com>
References: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48213 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755467Ab1CIHVt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 02:21:49 -0500
In-Reply-To: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

print_irq_status functions can be called with empty irq status when full
irq debugging is enabled. This patch makes print_irq_status functions
return immediately when given an empty irq status to lessen the debug
spam slightly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ec5b879..f6733b5 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -412,6 +412,9 @@ static void dsi_perf_show(const char *name)
 
 static void print_irq_status(u32 status)
 {
+	if (status == 0)
+		return;
+
 #ifndef VERBOSE_IRQ
 	if ((status & ~DSI_IRQ_CHANNEL_MASK) == 0)
 		return;
@@ -447,6 +450,9 @@ static void print_irq_status(u32 status)
 
 static void print_irq_status_vc(int channel, u32 status)
 {
+	if (status == 0)
+		return;
+
 #ifndef VERBOSE_IRQ
 	if ((status & ~DSI_VC_IRQ_PACKET_SENT) == 0)
 		return;
@@ -473,6 +479,9 @@ static void print_irq_status_vc(int channel, u32 status)
 
 static void print_irq_status_cio(u32 status)
 {
+	if (status == 0)
+		return;
+
 	printk(KERN_DEBUG "DSI CIO IRQ 0x%x: ", status);
 
 #define PIS(x) \
-- 
1.7.1

