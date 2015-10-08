From: Ben Tucker <benjamint@bsquare.com>
Subject: [PATCH] ARM: OMAP2+: Fixed inverted OMAP_OFFOUT_EN
Date: Thu,  8 Oct 2015 17:19:49 +0100
Message-ID: <1444321189-9921-1-git-send-email-benjamint@bsquare.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Tucker <benjamint@bsquare.com>
List-Id: linux-omap@vger.kernel.org

The OFFOUTENABLE bit of the omap PADCONF registers is active low.
The mux code assumed that it was active high and this patch fixes this
problem.

Tested on an AM37x device.

Signed-off-by: Ben Tucker <benjamint@bsquare.com>
---
 arch/arm/mach-omap2/mux.c |  2 +-
 arch/arm/mach-omap2/mux.h | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 176eef6..427a7f88 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -523,7 +523,7 @@ static inline void omap_mux_decode(struct seq_file *s, u16 val)
 
 	OMAP_MUX_TEST_FLAG(val, OMAP_PIN_OFF_WAKEUPENABLE);
 	if (val & OMAP_OFF_EN) {
-		if (!(val & OMAP_OFFOUT_EN)) {
+		if (val & OMAP_OFFOUT_EN) {
 			if (!(val & OMAP_OFF_PULL_UP)) {
 				OMAP_MUX_TEST_FLAG(val,
 					OMAP_PIN_OFF_INPUT_PULLDOWN);
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index d121fb6..9a5fd76 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -29,7 +29,7 @@
 /* omap3/4/5 specific mux bit defines */
 #define OMAP_INPUT_EN			(1 << 8)
 #define OMAP_OFF_EN			(1 << 9)
-#define OMAP_OFFOUT_EN			(1 << 10)
+#define OMAP_OFFOUT_EN			(1 << 10) /* 1 for input, 0 for output */
 #define OMAP_OFFOUT_VAL			(1 << 11)
 #define OMAP_OFF_PULL_EN		(1 << 12)
 #define OMAP_OFF_PULL_UP		(1 << 13)
@@ -45,12 +45,13 @@
 
 /* Off mode states */
 #define OMAP_PIN_OFF_NONE		0
-#define OMAP_PIN_OFF_OUTPUT_HIGH	(OMAP_OFF_EN | OMAP_OFFOUT_EN \
-						| OMAP_OFFOUT_VAL)
-#define OMAP_PIN_OFF_OUTPUT_LOW		(OMAP_OFF_EN | OMAP_OFFOUT_EN)
-#define OMAP_PIN_OFF_INPUT_PULLUP	(OMAP_OFF_EN | OMAP_OFF_PULL_EN \
+#define OMAP_PIN_OFF_OUTPUT_HIGH	(OMAP_OFF_EN | OMAP_OFFOUT_VAL)
+#define OMAP_PIN_OFF_OUTPUT_LOW		(OMAP_OFF_EN)
+#define OMAP_PIN_OFF_INPUT_PULLUP	(OMAP_OFF_EN | OMAP_OFFOUT_EN \
+						| OMAP_OFF_PULL_EN \
 						| OMAP_OFF_PULL_UP)
-#define OMAP_PIN_OFF_INPUT_PULLDOWN	(OMAP_OFF_EN | OMAP_OFF_PULL_EN)
+#define OMAP_PIN_OFF_INPUT_PULLDOWN	(OMAP_OFF_EN | OMAP_OFFOUT_EN \
+						| OMAP_OFF_PULL_EN)
 #define OMAP_PIN_OFF_WAKEUPENABLE	OMAP_WAKEUP_EN
 
 #define OMAP_MODE_GPIO(partition, x)	(((x) & OMAP_MUX_MODE7) == \
-- 
1.9.1
