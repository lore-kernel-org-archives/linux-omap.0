From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] OMAP3: PM: fix IO daisy chain enable to use PM_WKEN reg
Date: Tue, 08 Jun 2010 15:03:40 +0300
Message-ID: <20100608120340.24902.73479.stgit@baageli.muru.com>
References: <20100608120104.24902.36055.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55689 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab0FHMDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 08:03:36 -0400
In-Reply-To: <20100608120104.24902.36055.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Checking to se if the IO daisy chain is enabled should be checking the
PM_WKEN register, not the PM_WKST register.  Reading PM_WKST tells us
if an event occurred, not whether or not it is enabled.

Apparently, we've been lucky until now in that a pending event has not
been there during enable.  However, on 3630/Zoom3, I noticed because
of the WARN that this timeout was always happening.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2e96771..b88737f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -99,7 +99,7 @@ static void omap3_enable_io_chain(void)
 		/* Do a readback to assure write has been done */
 		prm_read_mod_reg(WKUP_MOD, PM_WKEN);
 
-		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKST) &
+		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
 			 OMAP3430_ST_IO_CHAIN_MASK)) {
 			timeout++;
 			if (timeout > 1000) {
@@ -108,7 +108,7 @@ static void omap3_enable_io_chain(void)
 				return;
 			}
 			prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
-					     WKUP_MOD, PM_WKST);
+					     WKUP_MOD, PM_WKEN);
 		}
 	}
 }

