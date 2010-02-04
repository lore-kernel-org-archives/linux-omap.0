From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/3] omap3evm: Add mux settings for keypad
Date: Thu,  4 Feb 2010 14:22:10 +0530
Message-ID: <1265273530-23040-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56334 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757135Ab0BDIwP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 03:52:15 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o148qBtL008451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 4 Feb 2010 02:52:14 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch sets SYS_NIRQ for keypad input. It also
sets the same as a wakeup event from OFF mode.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 346c448..8be10cf 100644
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

