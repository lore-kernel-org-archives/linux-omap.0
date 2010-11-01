From: John Faith <jfaith7@gmail.com>
Subject: [PATCH] smsc911x: Set Ethernet EEPROM size to supported device's size
Date: Mon,  1 Nov 2010 14:30:08 -0700
Message-ID: <1288647008-11846-1-git-send-email-jfaith7@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, John Faith <jfaith7@gmail.com>
List-Id: linux-omap@vger.kernel.org

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

