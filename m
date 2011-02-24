From: =?UTF-8?Q?Radek_=28Mrkva=29_Pila=C5=99?= <mrkva@mrkva.eu>
Subject: [PATCH 2/2] OMAP3 Touchbook: fix board initialization
Date: Thu, 24 Feb 2011 19:02:49 +0100
Message-ID: <6dac4c4aac867da9cf2971ce555f54ac@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mrkva.eu ([83.167.228.102]:33333 "EHLO mrkva.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab1BXSJk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 13:09:40 -0500
Received: from mrkva.eu (localhost.localdomain [127.0.0.1])
	by mrkva.eu (Postfix) with ESMTP id C4BAE9BC1CC
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 19:02:49 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

init_early hook runs too early for omap3_mux_init(), so the board 
won't boot. Moved to init_machine, then it works just fine.

Signed-off-by: Radek Pilar <mrkva@mrkva.eu>
---
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c 
b/arch/arm/mach-omap2/board-omap3touchbook.c
index e65a32d..3b560d7 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -416,7 +416,6 @@ static struct omap_board_mux board_mux[] 
__initdata = {

 static void __init omap3_touchbook_init_early(void)
 {
-	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_board_config = omap3_touchbook_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_touchbook_config);
 	omap2_init_common_infrastructure();
@@ -513,6 +512,7 @@ static struct omap_musb_board_data musb_board_data 
= {

 static void __init omap3_touchbook_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	pm_power_off = omap3_touchbook_poweroff;

 	omap3_touchbook_i2c_init();
--
1.7.4.1

