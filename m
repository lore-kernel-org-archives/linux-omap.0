From: Silesh C V <silesh@ti.com>
Subject: [PATCH v2 1/2] OMAP: 4430SDP: Register the card detect GPIO properly
Date: Wed, 29 Jun 2011 07:44:56 +0530
Message-ID: <1309313698-19438-1-git-send-email-silesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54596 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab1F2CJX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 22:09:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, balajitk@ti.com, grinberg@compulab.co.il, svenkatr@ti.com, Silesh C V <silesh@ti.com>

Without this the HSMMC driver takes GPIO 0 to be the card detect gpio
and requests/configures it. This will give rise to issues when another
driver needs to use GPIO 0. On 4430SDP, the card detection is through
TWL 6030.

Signed-off-by: Silesh C V <silesh@ti.com>
---
Changes for v2 :
	- Made it a series to make sure this one goes before the mux fix.

 arch/arm/mach-omap2/board-4430sdp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 63de2d3..7a1460f 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -327,6 +327,7 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
-- 
1.7.1

