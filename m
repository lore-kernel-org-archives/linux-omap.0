From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 04/19] ARM: OMAP4: Add SAR ROM base address
Date: Fri, 20 Apr 2012 12:33:37 +0300
Message-ID: <1334914432-26456-5-git-send-email-t-kristo@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48138 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483Ab2DTJeb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:34:31 -0400
In-Reply-To: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
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

