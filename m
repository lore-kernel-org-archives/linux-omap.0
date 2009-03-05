From: ext-eero.nurkkala@nokia.com
Subject: [RFC] OMAP: I2C: Use correct bit for CLOCKACTIVITY
Date: Thu,  5 Mar 2009 08:27:35 +0200
Message-ID: <12362344552581-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58455 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbZCEGa4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 01:30:56 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n256UKgl027508
	for <linux-omap@vger.kernel.org>; Thu, 5 Mar 2009 00:30:51 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

It is the bit 8 that is for FCLK. All other blocks in
OMAPs use the bit 8 for denying FCLK idling.

This is an RFC, I'd like some discussion. Somebody
double-check this?

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0258b55..11057eb 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -157,7 +157,7 @@
 #define SYSC_AUTOIDLE_MASK		(1 << 0)
 
 #define SYSC_IDLEMODE_SMART		0x2
-#define SYSC_CLOCKACTIVITY_FCLK		0x2
+#define SYSC_CLOCKACTIVITY_FCLK		0x1
 
 
 struct omap_i2c_dev {
-- 
1.5.2

