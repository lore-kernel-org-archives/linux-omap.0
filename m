From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/3] omap3evm: Add mux settings for keypad
Date: Fri,  5 Feb 2010 14:13:33 +0530
Message-ID: <1265359413-15842-1-git-send-email-premi@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch sets SYS_NIRQ for keypad input. It also
sets the same as a wakeup event from OFF mode.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index fde27cf..19363bd 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -424,6 +424,10 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
+				OMAP_PIN_OFF_INPUT_PULLUP |
+				OMAP_PIN_OFF_WAKEUPENABLE),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
-- 
1.6.2.2

