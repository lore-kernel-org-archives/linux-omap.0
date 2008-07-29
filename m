From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 4/4] OMAP: MENELAUS: Code clean-up for menelaus
Date: Tue, 29 Jul 2008 12:44:35 -0400
Message-ID: <488F48F3.2090302@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17373 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYG2Qop (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 12:44:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

This patch removes a few errors and warnings reported by checkpatch.pl.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 include/linux/i2c/menelaus.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/i2c/menelaus.h b/include/linux/i2c/menelaus.h
index 1660418..9587398 100644
--- a/include/linux/i2c/menelaus.h
+++ b/include/linux/i2c/menelaus.h
@@ -1,5 +1,5 @@
 /*
- * linux/include/asm-arm/arch-omap/menelaus.h
+ * include/linux/i2c/menelaus.h
  *
  * Functions to access Menelaus power management chip
  */
@@ -122,10 +122,11 @@
 struct device;
 
 struct menelaus_platform_data {
-	int (* late_init)(struct device *dev);
+	int (*late_init)(struct device *dev);
 };
 
-extern int menelaus_register_mmc_callback(void (*callback)(void *data, u8 card_mask),
+extern int menelaus_register_mmc_callback(void (*callback)(void *data,
+					  u8 card_mask),
 					  void *data);
 extern void menelaus_unregister_mmc_callback(void);
 extern int menelaus_set_mmc_opendrain(int slot, int enable);
-- 1.5.5.1

