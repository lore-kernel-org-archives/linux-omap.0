From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 2/2] OMAP2EVM: Updates defconfig
Date: Wed, 24 Sep 2008 20:11:39 +0530
Message-ID: <dfeb90390809240741s789f6e11ke6ce6a62f0d8078c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:3700 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbYIXOlk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:41:40 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2736137rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 07:41:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch enables mcspi support in omap2evm defconfig.

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/configs/omap2_evm_defconfig |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/omap2_evm_defconfig
b/arch/arm/configs/omap2_evm_defconfig
index 61f0965..454fa46 100644
--- a/arch/arm/configs/omap2_evm_defconfig
+++ b/arch/arm/configs/omap2_evm_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.27-rc3-omap1
-# Wed Aug 20 21:20:25 2008
+# Linux kernel version: 2.6.27-rc7-omap1
+# Wed Sep 24 18:43:59 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -264,6 +264,7 @@ CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 CONFIG_PREEMPT=y
 CONFIG_HZ=100
 # CONFIG_AEABI is not set
+CONFIG_ARCH_FLATMEM_HAS_HOLES=y
 # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
@@ -773,7 +774,7 @@ CONFIG_SPI_MASTER=y
 # SPI Master Controller Drivers
 #
 # CONFIG_SPI_BITBANG is not set
-# CONFIG_SPI_OMAP24XX is not set
+CONFIG_SPI_OMAP24XX=y

 #
 # SPI Protocol Masters
-- 
1.5.3.4
