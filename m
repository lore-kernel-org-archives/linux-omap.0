From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]Zoom2: Setup HSMMC2 8-bit capability
Date: Thu, 22 Oct 2009 23:14:50 +0530 (IST)
Message-ID: <33443.192.168.10.89.1256233490.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53299 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbZJVRor (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 13:44:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org

>From 2369a08e238186bf66b677ead62b23786e5b9ac7 Mon Sep 17 00:00:00 2001
From: Madhu <madhu.cr@ti.com>
Date: Wed, 21 Oct 2009 16:55:27 -0400
Subject: [PATCH] Zoom2: Setup HSMMC2 8-bit capability.

Zoom2 can support 8-bit operations on HSMMC2.Setup the board file
capability accordingly.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 arch/arm/mach-omap2/board-zoom2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 56f9d84..ad022ac 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -163,7 +163,7 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 	},
 	{
 		.mmc		= 2,
-		.wires		= 4,
+		.wires		= 8,
 		.gpio_wp	= -EINVAL,
 	},
 	{}      /* Terminator */
-- 
1.6.0.4



