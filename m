From: =?UTF-8?Q?Radek_=28Mrkva=29_Pila=C5=99?= <mrkva@mrkva.eu>
Subject: [PATCH 1/2] OMAP3 Touchbook: Fix MMC caps
Date: Thu, 24 Feb 2011 18:59:01 +0100
Message-ID: <44de2f4c8b17d38df1d25b7236223247@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mrkva.eu ([83.167.228.102]:53298 "EHLO mrkva.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754180Ab1BXSEk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 13:04:40 -0500
Received: from mrkva.eu (localhost.localdomain [127.0.0.1])
	by mrkva.eu (Postfix) with ESMTP id 588989BC18C
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 18:59:01 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

MMC controller cannot handle MMC_CAP_4_BIT_DATA nor MMC_CAP_8_BIT_DATA 
- the card won't be detected (tested with two SDHC cards, both Class6). 
Thus disabling.

Signed-off-by: Radek Pilar <mrkva@mrkva.eu>
---
 arch/arm/mach-omap2/board-omap3touchbook.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c 
b/arch/arm/mach-omap2/board-omap3touchbook.c
index 6a60f79..e65a32d 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -109,7 +109,6 @@ static struct omap_nand_platform_data 
omap3touchbook_nand_data = {
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 29,
 	},
 	{}	/* Terminator */
--
1.7.4.1

