From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 10/15] ARM: OMAP2+: control: Add some AM33XX Control module registers
Date: Fri, 2 Nov 2012 18:02:41 +0530
Message-ID: <1351859566-24818-11-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39663 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760790Ab2KBMeW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 08:34:22 -0400
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

These registers will be required in a subsequent
patch which adds basic suspend-resume support for
AM33XX.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/control.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a89e825..bb99302 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -357,6 +357,35 @@
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_WIDTH		0x2
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
 
+#define AM33XX_DDR_IO_CTRL		0x0E04
+#define AM33XX_VTP0_CTRL_REG		0x0E0C
+
+/* AM33XX VTP0_CTRL_REG bits */
+#define AM33XX_VTP_CTRL_START_EN	BIT(0)
+#define AM33XX_VTP_CTRL_LOCK_EN		BIT(4)
+#define AM33XX_VTP_CTRL_READY		BIT(5)
+#define AM33XX_VTP_CTRL_ENABLE		BIT(6)
+
+
+/* AM33XX M3_TXEV_EOI registers */
+#define AM33XX_CONTROL_M3_TXEV_EOI	0x1324
+
+/* AM33XX IPC message registers */
+#define AM33XX_CONTROL_IPC_MSG_REG0	0x1328
+#define AM33XX_CONTROL_IPC_MSG_REG1	0x132C
+#define AM33XX_CONTROL_IPC_MSG_REG2	0x1330
+#define AM33XX_CONTROL_IPC_MSG_REG3	0x1334
+#define AM33XX_CONTROL_IPC_MSG_REG4	0x1338
+#define AM33XX_CONTROL_IPC_MSG_REG5	0x133C
+#define AM33XX_CONTROL_IPC_MSG_REG6	0x1340
+#define AM33XX_CONTROL_IPC_MSG_REG7	0x1344
+
+#define AM33XX_DDR_CMD0_IOCTRL		0x1404
+#define AM33XX_DDR_CMD1_IOCTRL		0x1408
+#define AM33XX_DDR_CMD2_IOCTRL		0x140C
+#define AM33XX_DDR_DATA0_IOCTRL		0x1440
+#define AM33XX_DDR_DATA1_IOCTRL		0x1444
+
 /* CONTROL OMAP STATUS register to identify OMAP3 features */
 #define OMAP3_CONTROL_OMAP_STATUS	0x044c
 
-- 
1.7.0.4

