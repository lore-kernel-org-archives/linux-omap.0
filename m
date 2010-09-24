From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/11] omap: n8x0: Mux i2s codec port pins for McBSP block
Date: Thu, 23 Sep 2010 18:50:53 -0700
Message-ID: <20100924015053.10325.31208.stgit@baageli.muru.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49715 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab0IXBux (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 21:50:53 -0400
In-Reply-To: <20100924014938.10325.35279.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

From: Jarkko Nikula <jhnikula@gmail.com>

Bootloader on Nokia N800 and N810 muxes I2C codec port pins for EAC block.
As there is no driver and use for EAC, mux those pins for McBSP instead
since N810 ASoC drivers can use it.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

