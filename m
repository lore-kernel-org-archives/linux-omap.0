From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/12] OMAP3: RX51: Use OneNAND sync read / write
Date: Mon, 22 Jun 2009 14:50:31 +0300
Message-ID: <20090622115030.28477.74053.stgit@localhost>
References: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55258 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbZFVLu3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:50:29 -0400
In-Reply-To: <20090622113422.28477.27052.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

Use OneNAND sync read / write

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index da93b86..9a0bf67 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -362,6 +362,7 @@ static struct omap_onenand_platform_data board_onenand_data = {
 	.gpio_irq	= 65,
 	.parts		= onenand_partitions,
 	.nr_parts	= ARRAY_SIZE(onenand_partitions),
+	.flags		= ONENAND_SYNC_READWRITE,
 };
 
 static void __init board_onenand_init(void)

