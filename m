From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/12] OMAP1: Fix N770 MMC support
Date: Mon, 22 Jun 2009 14:39:43 +0300
Message-ID: <20090622113943.28477.3691.stgit@localhost>
References: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61957 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbZFVLjm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:39:42 -0400
In-Reply-To: <20090622113422.28477.27052.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Andrew de Quincey <adq@lidskialf.net>

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Some of the N770's MMC configuration options seem to have been
dropped. This patch adds them back in again.

Note that only the .ocr_mask change was /critical/, but I've added the
.max_freq setting back as well, as the original sources had it. Can
anyone confirm if this is unnecessary?

Secondly, there is support in the original code for a 4wire/higher
speed mode. As I don't have the requisite N770 hardware (I think it
was a rev2 N770?) to test this, I can't really add it back.

Signed-off-by: Andrew de Quincey <adq@lidskialf.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-nokia770.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index e70fc7c..d9ebba0 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -205,9 +205,11 @@ static int nokia770_mmc_get_cover_state(struct device *dev, int slot)
 static struct omap_mmc_platform_data nokia770_mmc2_data = {
 	.nr_slots                       = 1,
 	.dma_mask			= 0xffffffff,
+	.max_freq                       = 12000000,
 	.slots[0]       = {
 		.set_power		= nokia770_mmc_set_power,
 		.get_cover_state	= nokia770_mmc_get_cover_state,
+		.ocr_mask               = MMC_VDD_32_33|MMC_VDD_33_34,
 		.name                   = "mmcblk",
 	},
 };

