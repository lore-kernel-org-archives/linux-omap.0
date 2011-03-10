From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] OMAP3: wdtimer: fix wdtimer blocking CORE idle
Date: Thu, 10 Mar 2011 02:50:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100247190.15132@utopia.booyaka.com>
References: <1299749569-22673-1-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52065 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab1CJJuG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 04:50:06 -0500
In-Reply-To: <1299749569-22673-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, ilkka.koskinen@nokia.com, jhnikula@gmail.com, b-cousson@ti.com


Thanks Kalle for tracking this down,

could you try this patch along with the patch from this message:

  http://www.spinics.net/lists/linux-omap/msg48115.html

and see if it also fixes the problem?

This patch should also prevent the hwmod code from putting the WDT2 into 
smart-idle mode.


- Paul


---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 457df3e..4366b85 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1294,6 +1294,7 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
 	.slaves		= omap3xxx_wd_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* UART common */
-- 
1.7.2.3

