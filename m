From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/2] ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
Date: Fri,  6 Jul 2012 15:19:11 +0200
Message-ID: <1341580752-5501-2-git-send-email-peter.ujfalusi@ti.com>
References: <1341580752-5501-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:54509 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753653Ab2GFNTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 09:19:15 -0400
Received: by obbta14 with SMTP id ta14so20892469obb.18
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 06:19:08 -0700 (PDT)
In-Reply-To: <1341580752-5501-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The sys_nirq2 is used for twl6040, make sure the pin is configured
correctly.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c4e17641..72cd206 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -827,6 +827,9 @@ static void __init omap_4430sdp_display_init(void)
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
+	/* NIRQ2 for twl6040 */
+	OMAP4_MUX(SYS_NIRQ2, OMAP_MUX_MODE0 |
+		  OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 
-- 
1.7.8.6

