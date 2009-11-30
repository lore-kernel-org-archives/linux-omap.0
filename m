From: chudson@kionix.com
Subject: [RFC PATCH v3 3/3] mach-omap2:kxte9 accelerometer mux support for OMAP ZoomII
Date: Mon, 30 Nov 2009 09:42:56 -0500
Message-ID: <1259592176-18634-3-git-send-email-chudson@kionix.com>
References: <1259592176-18634-1-git-send-email-chudson@kionix.com>
 <1259592176-18634-2-git-send-email-chudson@kionix.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1259592176-18634-2-git-send-email-chudson@kionix.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, dmitry.torokhov@gmail.com, jic23@cam.ac.uk, Chris Hudson <chudson@kionix.com>
List-Id: linux-omap@vger.kernel.org

From: Chris Hudson <chudson@kionix.com>

This patch alters mux.c and mux.h to allow gpio configuration in support of the 
kxte9 accelerometer on the OMAP ZoomII platform.

Signed-off-by: Chris Hudson <chudson@kionix.com>
---
 arch/arm/mach-omap2/mux.c             |    2 ++
 arch/arm/plat-omap/include/plat/mux.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index c18a94e..015fa69 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -486,6 +486,8 @@ MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("Y21_34XX_GPIO156", 0x18c,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index ba77de6..3f13897 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -808,6 +808,7 @@ enum omap34xx_index {
 	AE6_34XX_GPIO141,
 	AF5_34XX_GPIO142,
 	AE5_34XX_GPIO143,
+	Y21_34XX_GPIO156,
 	H19_34XX_GPIO164_OUT,
 	J25_34XX_GPIO170,
 
-- 
1.5.4.3

