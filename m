From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFT/RFC/PATCH 04/10] video: omap: hwa742: make it build again
Date: Thu,  3 Dec 2009 00:35:46 +0200
Message-ID: <1259793352-29864-5-git-send-email-felipe.balbi@nokia.com>
References: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60609 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899AbZLBWgO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:36:14 -0500
In-Reply-To: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

add missing <linux/interrupt.h>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/video/omap/hwa742.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
index 170d171..0016f77 100644
--- a/drivers/video/omap/hwa742.c
+++ b/drivers/video/omap/hwa742.c
@@ -25,6 +25,7 @@
 #include <linux/fb.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/interrupt.h>
 
 #include <plat/dma.h>
 #include <plat/hwa742.h>
-- 
1.6.6.rc0

