From: Mark Brown <broonie@sirena.org.uk>
Subject: [PATCH] OMAP: Don't warn user about expected behaviour in mmc-twl4030
Date: Mon, 30 Mar 2009 20:15:39 +0100
Message-ID: <1238440539-2394-1-git-send-email-broonie@sirena.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:34671 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbZC3TPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2009 15:15:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>, Mark Brown <broonie@sirena.org.uk>

The approach that's being taken by the mmc-twl4030 driver to disabling
regulators is a normal and supported one so there is no need to print
messages on the console warning about this - their system is functioning
normally.

Signed-off-by: Mark Brown <broonie@sirena.org.uk>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 8db1f29..b76a31a 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -136,14 +136,11 @@ static int twl_mmc_late_init(struct device *dev)
 			 * (which is safe for MMC, but not in general).
 			 */
 			if (regulator_is_enabled(hsmmc[i].vcc) > 0) {
-				dev_warn(dev, "APPLY REGULATOR HACK for vmmc\n");
 				regulator_enable(hsmmc[i].vcc);
 				regulator_disable(hsmmc[i].vcc);
 			}
 			if (hsmmc[i].vcc_aux) {
 				if (regulator_is_enabled(reg) > 0) {
-					dev_warn(dev, "APPLY REGULATOR HACK "
-						"for vmmc_aux\n");
 					regulator_enable(reg);
 					regulator_disable(reg);
 				}
-- 
1.6.2.1

