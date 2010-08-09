From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/3] omap: n8x0: Mux i2s codec port pins for McBSP block
Date: Mon,  9 Aug 2010 10:59:00 +0300
Message-ID: <1281340740-10823-4-git-send-email-jhnikula@gmail.com>
References: <1281340740-10823-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54985 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab0HIH6C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 03:58:02 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so3345279ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 09 Aug 2010 00:58:01 -0700 (PDT)
In-Reply-To: <1281340740-10823-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>

Bootloader on Nokia N800 and N810 muxes I2C codec port pins for EAC block.
As there is no driver and use for EAC, mux those pins for McBSP instead
since N810 ASoC drivers can use it.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
With this patch it is possible to use audio on Nokia N810 by enabling the
CONFIG_SND_OMAP_SOC_N810=y
---
 arch/arm/mach-omap2/board-n8x0.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 7863633..8fd2269 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -660,6 +660,11 @@ static void __init n8x0_init_irq(void)
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	/* I2S codec port pins for McBSP block */
+	OMAP2420_MUX(EAC_AC_SCLK, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+	OMAP2420_MUX(EAC_AC_FS, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+	OMAP2420_MUX(EAC_AC_DIN, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+	OMAP2420_MUX(EAC_AC_DOUT, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
-- 
1.7.1

