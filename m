From: jean.pihet@newoldbits.com
Subject: [PATCH] OMAP2+: hwmod: remove unused voltagedomain pointer from kerneldoc
Date: Sat, 10 Dec 2011 10:26:55 +0100
Message-ID: <1323509215-30179-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36129 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab1LJJ1L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Dec 2011 04:27:11 -0500
Received: by wgbdr13 with SMTP id dr13so7308678wgb.1
        for <linux-omap@vger.kernel.org>; Sat, 10 Dec 2011 01:27:09 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Commit fa17f20f (OMAP2+: hwmod: remove unused voltagedomain pointer)
did remove the voltdm field from the struct omap_hwmod.
Remove it from the kerneldoc as well.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 5359663..bdc6ee4 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -480,7 +480,6 @@ struct omap_hwmod_class {
  * @main_clk: main clock: OMAP clock name
  * @_clk: pointer to the main struct clk (filled in at runtime)
  * @opt_clks: other device clocks that drivers can request (0..*)
- * @voltdm: pointer to voltage domain (filled in at runtime)
  * @masters: ptr to array of OCP ifs that this hwmod can initiate on
  * @slaves: ptr to array of OCP ifs that this hwmod can respond on
  * @dev_attr: arbitrary device attributes that can be passed to the driver
-- 
1.7.5.4

