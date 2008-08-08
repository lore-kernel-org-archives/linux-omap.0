From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 GPTIMER: fix GPTIMER12 IRQ
Date: Fri, 8 Aug 2008 02:57:08 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808080256150.21853@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40666 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbYHHI5J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 04:57:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


GPTIMER12 IRQ is at IRQ 95 on OMAP3, unlike OMAP2.  (ref: OMAP34xx
Multimedia High Security (HS) Device Silicon Revision 3.0 Security
Addendum Rev. B, SWPU119B)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/plat-omap/dmtimer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index f22506a..fcc1a02 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -237,7 +237,7 @@ static struct omap_dm_timer omap3_dm_timers[] = {
 	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
 	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
 	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
-	{ .phys_base = 0x48304000, .irq = INT_24XX_GPTIMER12 },
+	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
 };
 
 static const char *omap3_dm_source_names[] __initdata = {
