From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 4/4] AM3517: MMC: Make HSMMC driver built-in
Date: Mon, 23 Nov 2009 23:55:22 +0530
Message-ID: <1259000722-32222-4-git-send-email-anuj.aggarwal@ti.com>
References: <1259000722-32222-1-git-send-email-anuj.aggarwal@ti.com>
 <1259000722-32222-2-git-send-email-anuj.aggarwal@ti.com>
 <1259000722-32222-3-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34264 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753759AbZKWSZT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Nov 2009 13:25:19 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nANIPNnB025951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 12:25:25 -0600
In-Reply-To: <1259000722-32222-3-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

Make HSMMC driver as a built-in module for AM3517 platform.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/configs/am3517_evm_defconfig |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/am3517_evm_defconfig b/arch/arm/configs/am3517_evm_defconfig
index ad54e92..601f1f5 100644
--- a/arch/arm/configs/am3517_evm_defconfig
+++ b/arch/arm/configs/am3517_evm_defconfig
@@ -818,7 +818,26 @@ CONFIG_USB_STORAGE=y
 #
 # CONFIG_USB_GPIO_VBUS is not set
 # CONFIG_NOP_USB_XCEIV is not set
-# CONFIG_MMC is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD/SDIO Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
+# CONFIG_MMC_TEST is not set
+
+#
+# MMC/SD/SDIO Host Controller Drivers
+#
+# CONFIG_MMC_SDHCI is not set
+# CONFIG_MMC_OMAP is not set
+CONFIG_MMC_OMAP_HS=y
+# CONFIG_MMC_AT91 is not set
+# CONFIG_MMC_ATMELMCI is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
 # CONFIG_ACCESSIBILITY is not set
-- 
1.6.2.4

