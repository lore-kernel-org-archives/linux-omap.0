From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/9] ARM: OMAP4+: Use common scratchpad SAR RAM offsets for all architectures
Date: Wed, 20 Feb 2013 20:48:39 +0530
Message-ID: <1361373527-21695-2-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46954 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933491Ab3BTPRh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 10:17:37 -0500
In-Reply-To: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Tero Kristo <t-kristo@ti.com>

Simplifies code and also allows the re-use as is on OMAP5 devices.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap4-sar-layout.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index e170fe8..6822d0a 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -20,13 +20,13 @@
 #define SAR_BANK4_OFFSET		0x3000
 
 /* Scratch pad memory offsets from SAR_BANK1 */
-#define SCU_OFFSET0				0xd00
-#define SCU_OFFSET1				0xd04
-#define OMAP_TYPE_OFFSET			0xd10
-#define L2X0_SAVE_OFFSET0			0xd14
-#define L2X0_SAVE_OFFSET1			0xd18
-#define L2X0_AUXCTRL_OFFSET			0xd1c
-#define L2X0_PREFETCH_CTRL_OFFSET		0xd20
+#define SCU_OFFSET0				0xfe4
+#define SCU_OFFSET1				0xfe8
+#define OMAP_TYPE_OFFSET			0xfec
+#define L2X0_SAVE_OFFSET0			0xff0
+#define L2X0_SAVE_OFFSET1			0xff4
+#define L2X0_AUXCTRL_OFFSET			0xff8
+#define L2X0_PREFETCH_CTRL_OFFSET		0xffc
 
 /* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
 #define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
-- 
1.7.9.5

