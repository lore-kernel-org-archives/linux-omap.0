From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH] OMA2EVM: update defconfig
Date: Wed, 6 Aug 2008 16:54:58 +0530
Message-ID: <dfeb90390808060424g51dbe39dvc0d8fce731c8d307@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:3257 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbYHFLY7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 07:24:59 -0400
Received: by ti-out-0910.google.com with SMTP id b6so953542tic.23
        for <linux-omap@vger.kernel.org>; Wed, 06 Aug 2008 04:24:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Update omap2evm defconfig

- Enable hsmmc support.

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/configs/omap2_evm_defconfig |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/omap2_evm_defconfig
b/arch/arm/configs/omap2_evm_defconfig
index 09383f9..9d5b30f 100644
--- a/arch/arm/configs/omap2_evm_defconfig
+++ b/arch/arm/configs/omap2_evm_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc7-omap1
-# Tue Jun 24 17:29:35 2008
+# Linux kernel version: 2.6.26-omap1
+# Wed Aug  6 17:05:50 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -803,7 +803,23 @@ CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
 # CONFIG_HIDRAW is not set
 # CONFIG_USB_SUPPORT is not set
-# CONFIG_MMC is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+CONFIG_MMC_UNSAFE_RESUME=y
+
+#
+# MMC/SD Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
+# CONFIG_MMC_TEST is not set
+
+#
+# MMC/SD Host Controller Drivers
+#
+CONFIG_MMC_OMAP_HS=y
+# CONFIG_MMC_SPI is not set
 # CONFIG_NEW_LEDS is not set
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
-- 
1.5.3.4
