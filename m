From: John Faith <jfaith7@gmail.com>
Subject: [PATCH] smsc911x: Set Ethernet EEPROM size to supported device's size
Date: Mon,  1 Nov 2010 13:40:39 -0700
Message-ID: <1288644039-11512-1-git-send-email-jfaith7@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:51198 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab0KAUlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Nov 2010 16:41:07 -0400
Received: by pxi15 with SMTP id 15so596819pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Nov 2010 13:41:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: John Faith <jfaith7@gmail.com>

The SMSC911x supports 128 x 8-bit EEPROMs.  Increase the EEPROM size
so more than just the MAC address can be stored.

Signed-off-by: John Faith <jfaith7@gmail.com>
---
 drivers/net/smsc911x.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/smsc911x.h b/drivers/net/smsc911x.h
index 016360c..8a79585 100644
--- a/drivers/net/smsc911x.h
+++ b/drivers/net/smsc911x.h
@@ -22,7 +22,7 @@
 #define __SMSC911X_H__
 
 #define TX_FIFO_LOW_THRESHOLD	((u32)1600)
-#define SMSC911X_EEPROM_SIZE	((u32)7)
+#define SMSC911X_EEPROM_SIZE	((u32)128)
 #define USE_DEBUG		0
 
 /* This is the maximum number of packets to be received every
-- 
1.7.0.4

