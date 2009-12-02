From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFT/RFC/PATCH 03/10] video: omap: sossi: make it build again
Date: Thu,  3 Dec 2009 00:35:45 +0200
Message-ID: <1259793352-29864-4-git-send-email-felipe.balbi@nokia.com>
References: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60606 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894AbZLBWgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:36:12 -0500
In-Reply-To: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

add missing <linux/interrupt.h>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/video/omap/sossi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap/sossi.c b/drivers/video/omap/sossi.c
index 354cbbb..8fb7c70 100644
--- a/drivers/video/omap/sossi.c
+++ b/drivers/video/omap/sossi.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
 
 #include <plat/dma.h>
 
-- 
1.6.6.rc0

