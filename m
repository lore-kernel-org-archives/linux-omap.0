From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/23] omap3evm: Add mux settings for keypad
Date: Wed, 17 Feb 2010 17:31:53 -0800
Message-ID: <20100218013153.32075.57522.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63082 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0BRBbE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:31:04 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Sanjeev Premi <premi@ti.com>

From: Sanjeev Premi <premi@ti.com>

This patch sets SYS_NIRQ for keypad input. It also
sets the same as a wakeup event from OFF mode.

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 45227f3..3b473cf 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -647,6 +647,10 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
+				OMAP_PIN_OFF_INPUT_PULLUP |
+				OMAP_PIN_OFF_WAKEUPENABLE),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else

