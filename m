From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 02/19] ARM: OMAP4: Add SAR ROM base address
Date: Mon, 14 May 2012 13:18:33 +0300
Message-ID: <1336990730-26892-3-git-send-email-t-kristo@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44848 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755769Ab2ENKTK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 06:19:10 -0400
In-Reply-To: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Added in preparation for device off mode. SAR ROM contains the mapping
from SAR RAM to IO registers, and this will eventually be parsed during
init time to do the reverse before device off.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index c0d478e..1a45700 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -46,6 +46,7 @@
 #define OMAP44XX_MCPDM_BASE		0x40132000
 #define OMAP44XX_MCPDM_L3_BASE		0x49032000
 #define OMAP44XX_SAR_RAM_BASE		0x4a326000
+#define OMAP44XX_SAR_ROM_BASE		0x4a05e000
 
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
 #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
-- 
1.7.4.1

