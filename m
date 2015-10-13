From: Heiko Schocher <hs@denx.de>
Subject: [PATCH] arm, omap2, sram: On HS/EMU devices, only 64K internal SRAM is available.
Date: Tue, 13 Oct 2015 07:54:15 +0200
Message-ID: <1444715655-30077-1-git-send-email-hs@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, Ayoub Zaki <Ayoub.Zaki@bosch-si.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Georg.Soffel@bosch-si.com, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Of this, secure content (including PPA) uses initial
portion of the SRAM. This chunk is not (and shouldn't
be) accessible from the public code.

The minimum size of this chunk (0x350) is used in this
patch. Available size is rounded off to 63K.

Both values would require a change if size of secure
content grows beyond 0x350.

Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Ayoub Zaki <Ayoub.Zaki@bosch-si.com>
---

 arch/arm/mach-omap2/sram.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index cd488b8..2e7c00f 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -47,6 +47,28 @@
 
 #define GP_DEVICE		0x300
 
+/**
+ * Size of chunk used by secure content in the HS/EMU devices.
+ *
+ * This size is not fixed. It depends upon the implementation of PPA.
+ * May need to be modified if the size grows.
+ */
+#define AM33XX_HS_HEADER_SIZE   0x0350
+
+/**
+ * Start of public SRAM on HS/EMU devices.
+ */
+#define AM33XX_SRAM_PA		0x40300000
+#define AM33XX_SRAM_PUB_PA	(AM33XX_SRAM_PA + AM33XX_HS_HEADER_SIZE)
+
+/**
+ * Size of public SRAM available on HS/EMU devices.
+ *
+ * This size also depends upon AM33XX_HS_HEADER_SIZE.
+ * Current value is derived from nearest round-off.
+ */
+#define AM33XX_SRAM_PUB_SIZE		0xfc00	/* 63K */
+
 #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
 
 static unsigned long omap_sram_start;
@@ -99,6 +121,9 @@ static void __init omap_detect_sram(void)
 			} else {
 				omap_sram_size = 0x8000; /* 32K */
 			}
+		} else if (soc_is_am33xx()) {
+			omap_sram_start = AM33XX_SRAM_PUB_PA;
+			omap_sram_size  = AM33XX_SRAM_PUB_SIZE;
 		} else {
 			omap_sram_start = OMAP2_SRAM_PUB_PA;
 			omap_sram_size = 0x800; /* 2K */
-- 
2.1.0
