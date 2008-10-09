From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] ARM: OMAP: fix uninitialized warning
Date: Thu,  9 Oct 2008 14:49:38 +0300
Message-ID: <1223552978-5353-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56632 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972AbYJILuL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 07:50:11 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m99BnR4q023206
	for <linux-omap@vger.kernel.org>; Thu, 9 Oct 2008 06:50:09 -0500
Received: from oreo.research.nokia.com (esdhcp04066.research.nokia.com [172.21.40.66])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m99BnclU030303
	for <linux-omap@vger.kernel.org>; Thu, 9 Oct 2008 14:49:38 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

warning: 'pixel' may be used uninitialized in this function

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/video/omap/lcd_mipid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
index 5dcca82..8b11f73 100644
--- a/drivers/video/omap/lcd_mipid.c
+++ b/drivers/video/omap/lcd_mipid.c
@@ -267,7 +267,7 @@ static unsigned long mipid_get_caps(struct lcd_panel *panel)
 
 static u16 read_first_pixel(struct mipid_device *md)
 {
-	u16 pixel;
+	u16 uninitialized_var(pixel);
 	u8 red, green, blue;
 
 	mutex_lock(&md->mutex);
-- 
1.6.0.2.229.g1293c

