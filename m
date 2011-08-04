From: David Wagner <david.wagner@free-electrons.com>
Subject: [PATCH 2/2] Use existing GPMC macros instead of bit manipulation
Date: Thu,  4 Aug 2011 17:06:35 +0200
Message-ID: <1312470395-19672-2-git-send-email-david.wagner@free-electrons.com>
References: <1312470395-19672-1-git-send-email-david.wagner@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44772 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab1HDPEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 11:04:10 -0400
In-Reply-To: <1312470395-19672-1-git-send-email-david.wagner@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Wagner <david.wagner@free-electrons.com>, LKML <inux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

---
 arch/arm/mach-omap2/board-igep0020.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 35be778..f89573a 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -175,12 +175,12 @@ static void __init igep_flash_init(void)
 		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
 
 		/* Check if NAND/oneNAND is configured */
-		if ((ret & 0xC00) == 0x800)
+		if (GPMC_CONFIG1_DEVICETYPE(ret) == GPMC_DEVICETYPE_NAND)
 			/* NAND found */
 			pr_err("IGEP: Unsupported NAND found\n");
 		else {
 			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
-			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
+			if (GPMC_CONFIG7_BASEADDRESS(ret) == (ONENAND_MAP >> 24))
 				/* ONENAND found */
 				onenandcs = cs;
 		}
-- 
1.7.0.4

