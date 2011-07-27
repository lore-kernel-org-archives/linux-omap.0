From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2] OMAP: ctrl: Fix CONTROL_DSIPHY register fields
Date: Wed, 27 Jul 2011 16:03:59 +0530
Message-ID: <1311762839-31663-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60489 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab1G0KZN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jul 2011 06:25:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, b-cousson@ti.com, santosh.shilimkar@ti.com, paul@pwsan.com
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

Fix the shift and mask macros for DSIx_PPID fields in CONTROL_DSIPHY. The
OMAP4430 Public TRM vV has these fields mentioned correctly.

Signed-off-by: Archit Taneja <archit@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
v2:
- Improve commit description.
- Define fields in decreasing order of the field's end bit.

 .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
index c88420d..1e2d332 100644
--- a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
+++ b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
@@ -941,10 +941,10 @@
 #define OMAP4_DSI2_LANEENABLE_MASK				(0x7 << 29)
 #define OMAP4_DSI1_LANEENABLE_SHIFT				24
 #define OMAP4_DSI1_LANEENABLE_MASK				(0x1f << 24)
-#define OMAP4_DSI1_PIPD_SHIFT					19
-#define OMAP4_DSI1_PIPD_MASK					(0x1f << 19)
-#define OMAP4_DSI2_PIPD_SHIFT					14
-#define OMAP4_DSI2_PIPD_MASK					(0x1f << 14)
+#define OMAP4_DSI2_PIPD_SHIFT					19
+#define OMAP4_DSI2_PIPD_MASK					(0x1f << 19)
+#define OMAP4_DSI1_PIPD_SHIFT					14
+#define OMAP4_DSI1_PIPD_MASK					(0x1f << 14)
 
 /* CONTROL_MCBSPLP */
 #define OMAP4_ALBCTRLRX_FSX_SHIFT				31
-- 
1.7.1

