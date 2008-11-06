From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 flash: fix use of system_rev in board-3430sdp-flash.c
Date: Thu, 06 Nov 2008 05:26:35 -0700
Message-ID: <20081106122633.32272.65124.stgit@localhost.localdomain>
References: <20081106122630.32272.71026.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58450 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbYKFM2d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 07:28:33 -0500
In-Reply-To: <20081106122630.32272.71026.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Timo-Pekka Launonen <ext-timo-pekka.launonen@nokia.com>, Lauri Leukkunen <lauri.leukkunen@nokia.com>

Fix one remaining user of system_rev.  This patch is needed for
3430SDP ES2 to boot after 4a4ada55c1bdaa2b9fd1293611b55ceba14b13e7.

Bisected by Timo-Pekka Launonen's <ext-timo-pekka.launonen@nokia.com>
list robot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Timo-Pekka Launonen <ext-timo-pekka.launonen@nokia.com>
Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp-flash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp-flash.c b/arch/arm/mach-omap2/board-3430sdp-flash.c
index 6b0419c..51dd839 100644
--- a/arch/arm/mach-omap2/board-3430sdp-flash.c
+++ b/arch/arm/mach-omap2/board-3430sdp-flash.c
@@ -210,7 +210,7 @@ void __init sdp3430_flash_init(void)
 	gpmc_base_add   = OMAP34XX_GPMC_VIRT;
 
 	/* Configure start address and size of NOR device */
-	if (system_rev > OMAP3430_REV_ES1_0) {
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
 		sdp_nor_resource.start	= FLASH_BASE_SDPV2;
 		sdp_nor_resource.end	= FLASH_BASE_SDPV2
 						+ FLASH_SIZE_SDPV2 - 1;


