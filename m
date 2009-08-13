From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 07/10] OMAP: PM: Add definitions for ETK pads and observability registers
Date: Thu, 13 Aug 2009 09:52:36 -0700
Message-ID: <1250182359-18830-8-git-send-email-khilman@deeprootsystems.com>
References: <1250182359-18830-1-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-2-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-3-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-4-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-5-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-6-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1250182359-18830-7-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 arch/arm/plat-omap/include/mach/control.h |   47 +++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 8140dbc..81afe26 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -141,8 +141,51 @@
 #define OMAP343X_CONTROL_TEST_KEY_13	(OMAP2_CONTROL_GENERAL + 0x00fc)
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
-#define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02b0)
-#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
+#define OMAP343X_CONTROL_DEBOBS(i)	(OMAP2_CONTROL_GENERAL + 0x01B0 \
+					+ ((i) >> 1) * 4 + (!(i & 1)) * 2)
+#define OMAP343X_CONTROL_PROG_IO0	(OMAP2_CONTROL_GENERAL + 0x01D4)
+#define OMAP343X_CONTROL_PROG_IO1	(OMAP2_CONTROL_GENERAL + 0x01D8)
+#define OMAP343X_CONTROL_DSS_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E0)
+#define OMAP343X_CONTROL_CORE_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E4)
+#define OMAP343X_CONTROL_PER_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E8)
+#define OMAP343X_CONTROL_USBHOST_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01EC)
+#define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02B0)
+#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02B4)
+#define OMAP343X_CONTROL_SRAMLDO4	(OMAP2_CONTROL_GENERAL + 0x02B8)
+#define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
+#define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
+
+
+/* 34xx PADCONF register offsets */
+#define OMAP343X_PADCONF_ETK(i)		(OMAP2_CONTROL_PADCONFS + 0x5a8 + \
+						(i)*2)
+#define OMAP343X_PADCONF_ETK_CLK	OMAP343X_PADCONF_ETK(0)
+#define OMAP343X_PADCONF_ETK_CTL	OMAP343X_PADCONF_ETK(1)
+#define OMAP343X_PADCONF_ETK_D0		OMAP343X_PADCONF_ETK(2)
+#define OMAP343X_PADCONF_ETK_D1		OMAP343X_PADCONF_ETK(3)
+#define OMAP343X_PADCONF_ETK_D2		OMAP343X_PADCONF_ETK(4)
+#define OMAP343X_PADCONF_ETK_D3		OMAP343X_PADCONF_ETK(5)
+#define OMAP343X_PADCONF_ETK_D4		OMAP343X_PADCONF_ETK(6)
+#define OMAP343X_PADCONF_ETK_D5		OMAP343X_PADCONF_ETK(7)
+#define OMAP343X_PADCONF_ETK_D6		OMAP343X_PADCONF_ETK(8)
+#define OMAP343X_PADCONF_ETK_D7		OMAP343X_PADCONF_ETK(9)
+#define OMAP343X_PADCONF_ETK_D8		OMAP343X_PADCONF_ETK(10)
+#define OMAP343X_PADCONF_ETK_D9		OMAP343X_PADCONF_ETK(11)
+#define OMAP343X_PADCONF_ETK_D10	OMAP343X_PADCONF_ETK(12)
+#define OMAP343X_PADCONF_ETK_D11	OMAP343X_PADCONF_ETK(13)
+#define OMAP343X_PADCONF_ETK_D12	OMAP343X_PADCONF_ETK(14)
+#define OMAP343X_PADCONF_ETK_D13	OMAP343X_PADCONF_ETK(15)
+#define OMAP343X_PADCONF_ETK_D14	OMAP343X_PADCONF_ETK(16)
+#define OMAP343X_PADCONF_ETK_D15	OMAP343X_PADCONF_ETK(17)
+
+/* 34xx GENERAL_WKUP regist offsets */
+#define OMAP343X_CONTROL_WKUP_DEBOBSMUX(i) (OMAP343X_CONTROL_GENERAL_WKUP + \
+						0x008 + (i))
+#define OMAP343X_CONTROL_WKUP_DEBOBS0 (OMAP343X_CONTROL_GENERAL_WKUP + 0x008)
+#define OMAP343X_CONTROL_WKUP_DEBOBS1 (OMAP343X_CONTROL_GENERAL_WKUP + 0x00C)
+#define OMAP343X_CONTROL_WKUP_DEBOBS2 (OMAP343X_CONTROL_GENERAL_WKUP + 0x010)
+#define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WKUP + 0x014)
+#define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WKUP + 0x018)
 
 /* 34xx D2D idle-related pins, handled by PM core */
 #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
-- 
1.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
