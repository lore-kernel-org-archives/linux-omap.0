From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 2/4] RX51: SDRAM: Cleanup the init code
Date: Mon, 26 Oct 2009 18:15:24 +0200
Message-ID: <1256573726-29800-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256573726-29800-1-git-send-email-tero.kristo@nokia.com>
 <1256573726-29800-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33050 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbZJZQa7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 12:30:59 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9QGUsZp019101
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 18:31:02 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9QGUKlb018261
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 18:30:22 +0200
In-Reply-To: <1256573726-29800-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Removed a few unused functions + macro definitions + variables from the code.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-sdram.c |   51 --------------------------------
 1 files changed, 0 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-sdram.c b/arch/arm/mach-omap2/board-rx51-sdram.c
index 78cd5ed..b5d1c55 100644
--- a/arch/arm/mach-omap2/board-rx51-sdram.c
+++ b/arch/arm/mach-omap2/board-rx51-sdram.c
@@ -67,57 +67,6 @@ static const struct sdram_info rx51_info = {
 	.row_lines = 13,
 };
 
-#define CM_BASE		    0x48004000
-
-#define CM_CLKSEL_CORE      0x0a40
-#define CM_CLKSEL1_PLL      0x0d40
-
-#define PRM_CLKSEL          0x48306d40
-#define PRM_CLKSRC_CTRL     0x48307270
-
-static u32 cm_base = CM_BASE;
-
-static inline u32 cm_read_reg(int idx)
-{
-	return *(u32 *)OMAP2_L4_IO_ADDRESS(cm_base + idx);
-}
-
-static const unsigned long sys_clk_rate_table[] = {
-	12000, 13000, 19200, 26000, 38400, 16800
-};
-
-static unsigned long get_sys_clk_rate(void)
-{
-	unsigned long rate;
-
-	rate = sys_clk_rate_table[*(u32 *)OMAP2_L4_IO_ADDRESS(PRM_CLKSEL) & 0x07];
-	if (((*(u32 *)OMAP2_L4_IO_ADDRESS(PRM_CLKSRC_CTRL) >> 6) & 0x03) == 0x02)
-		rate /= 2;
-	return rate;
-}
-
-static unsigned long get_core_rate(void)
-{
-	unsigned long rate;
-	u32 l;
-
-	l = cm_read_reg(CM_CLKSEL1_PLL);
-	rate = get_sys_clk_rate();
-	rate *= ((l >> 16) & 0x7ff);
-	rate /= ((l >> 8) & 0x7f) + 1;
-	rate /= (l >> 27) & 0x1f;
-
-	return rate;
-}
-
-static unsigned long get_l3_rate(void)
-{
-	u32 l;
-
-	l = cm_read_reg(CM_CLKSEL_CORE);
-	return get_core_rate() / (l & 0x03);
-}
-
 static unsigned long sdrc_get_fclk_period(long rate)
 {
 	/* In picoseconds */
-- 
1.5.4.3

