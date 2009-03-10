From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/12] ARM: OMAP3: Add more GPIO mux options
Date: Tue, 10 Mar 2009 14:04:50 -0700
Message-ID: <20090310210450.16425.65743.stgit@localhost>
References: <20090310205824.16425.97745.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50647 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbZCJVEx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 17:04:53 -0400
In-Reply-To: <20090310205824.16425.97745.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

This patch adds several new GPIO pins and updates
the pin naming comments.

The patch is based on earlier patches on linux-omap
list by Manikandan Pillai <mani.pillai@ti.com>,
Vaibhav Hiremath <hvaibhav@ti.com> and
David Brownell <dbrownell@users.sourceforge.net>.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c             |   27 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mux.h |   13 +++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index dacb41f..026c4fc 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -453,10 +453,37 @@ MUX_CFG_34XX("AC1_3430_USB3FS_PHY_MM3_TXEN_N", 0x18a,
 
 
 /* 34XX GPIO - bidirectional, unless the name has an "_OUT" suffix.
+ * (Always specify PIN_INPUT, except for names suffixed by "_OUT".)
  * No internal pullup/pulldown without "_UP" or "_DOWN" suffix.
  */
+MUX_CFG_34XX("AF26_34XX_GPIO0", 0x1e0,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("AF22_34XX_GPIO9", 0xa18,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("U8_34XX_GPIO54_OUT", 0x0b4,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("U8_34XX_GPIO54_DOWN", 0x0b4,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("L8_34XX_GPIO63", 0x0ce,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("G25_34XX_GPIO86_OUT", 0x0fc,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AG4_34XX_GPIO134_OUT", 0x160,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AE4_34XX_GPIO136_OUT", 0x164,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AF6_34XX_GPIO140_UP", 0x16c,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE6_34XX_GPIO141", 0x16e,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 };
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index f4362b8..f7e298a 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -788,7 +788,20 @@ enum omap34xx_index {
 	 *  - "_DOWN" suffix (GPIO3_DOWN) with internal pulldown
 	 *  - "_OUT" suffix (GPIO3_OUT) for output-only pins (unlike 24xx)
 	 */
+	AF26_34XX_GPIO0,
+	AF22_34XX_GPIO9,
 	AH8_34XX_GPIO29,
+	U8_34XX_GPIO54_OUT,
+	U8_34XX_GPIO54_DOWN,
+	L8_34XX_GPIO63,
+	G25_34XX_GPIO86_OUT,
+	AG4_34XX_GPIO134_OUT,
+	AE4_34XX_GPIO136_OUT,
+	AF6_34XX_GPIO140_UP,
+	AE6_34XX_GPIO141,
+	AF5_34XX_GPIO142,
+	AE5_34XX_GPIO143,
+	H19_34XX_GPIO164_OUT,
 	J25_34XX_GPIO170,
 };
 

