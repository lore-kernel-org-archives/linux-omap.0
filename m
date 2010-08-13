From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Fri, 13 Aug 2010 11:02:00 +0300
Message-ID: <20100813080200.18750.37791.stgit@baageli.muru.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52345 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab0HMICF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 04:02:05 -0400
In-Reply-To: <20100813080034.18750.15410.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

From: Kevin Hilman <khilman@ti.com>

Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
mistakenly removed the check for PER when disabling the IO chain.

During idle, if the PER powerdomain transitions and CORE does not (as
is the case with the lower C-states when using CPUidle) the IO pad
wakeups are not being disabled in the idle path after they are
enabled.

This patch ensures that the check for disabling IO wakeups also checks
for PER transitions, matching the check done to enable IO wakeups.

Found when debugging PM/CPUidle related problems reported by Ameya
Palande <ameya.palande@nokia.com>.  Problems were triggered
particularily on boards with UART2 consoles (n900, Overo) since UART2
is in the PER powerdomain.

Tested on l-o master (omap3_defonfig + CONFIG_CPU_IDLE=y) as well
as with current PM branch.  Boards tested: n900, Overo, omap3evm.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Ameya Palande <ameya.palande@nokia.com>
Tested-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fb4994a..7b03426 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -480,7 +480,9 @@ void omap_sram_idle(void)
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (omap3_has_io_wakeup() && core_next_state < PWRDM_POWER_ON) {
+	if (omap3_has_io_wakeup() &&
+	    (per_next_state < PWRDM_POWER_ON ||
+	     core_next_state < PWRDM_POWER_ON)) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}

