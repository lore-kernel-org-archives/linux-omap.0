From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/7] OMAP3 GPTIMER: fix GPTIMER12 IRQ
Date: Tue, 14 Apr 2009 12:23:32 -0600
Message-ID: <20090414182331.22344.29136.stgit@localhost.localdomain>
References: <20090414182039.22344.49790.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45728 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076AbZDNS1P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 14:27:15 -0400
In-Reply-To: <20090414182039.22344.49790.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

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


