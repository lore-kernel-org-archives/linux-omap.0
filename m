From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 3/9] ARM: OMAP: remove the sti console workaround
Date: Wed, 29 Aug 2012 02:18:51 +0300
Message-ID: <1346195937-6383-4-git-send-email-grinberg@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:35716 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab2H1XTR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 19:19:17 -0400
In-Reply-To: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

The sti console workaround uses the OMAP custom tags.
Those tags are not used in upstream kernel and therefore the workaround
never fires on upstream kernels.
Remove the sti console workaround tags part.
This leaves the workaround functional part intact so can be reused if
needed.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/pm24xx.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 2edeffc..9e54dc9 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -352,16 +352,6 @@ int __init omap2_pm_init(void)
 
 	prcm_setup_regs();
 
-	/* Hack to prevent MPU retention when STI console is enabled. */
-	{
-		const struct omap_sti_console_config *sti;
-
-		sti = omap_get_config(OMAP_TAG_STI_CONSOLE,
-				      struct omap_sti_console_config);
-		if (sti != NULL && sti->enable)
-			sti_console_enabled = 1;
-	}
-
 	/*
 	 * We copy the assembler sleep/wakeup routines to SRAM.
 	 * These routines need to be in SRAM as that's the only
-- 
1.7.8.6

