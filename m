From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] OMAP3 GPTIMER: fix GPTIMER12 IRQ
Date: Sat, 04 Apr 2009 14:54:08 -0600
Message-ID: <20090404205407.12269.91269.stgit@localhost.localdomain>
References: <20090404205333.12269.76287.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38003 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbZDDUzH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 16:55:07 -0400
In-Reply-To: <20090404205333.12269.76287.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

GPTIMER12 IRQ is at IRQ 95 on OMAP3, unlike OMAP2.  (ref: OMAP34xx
Multimedia High Security (HS) Device Silicon Revision 3.0 Security
Addendum Rev. B, SWPU119B)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index bfd4757..c99d611 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -238,7 +238,7 @@ static struct omap_dm_timer omap3_dm_timers[] = {
 	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
 	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
 	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
-	{ .phys_base = 0x48304000, .irq = INT_24XX_GPTIMER12 },
+	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
 };
 
 static const char *omap3_dm_source_names[] __initdata = {


