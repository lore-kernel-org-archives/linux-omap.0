From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] ARM: OMAP2+: don't try to register the main clock twice.
Date: Fri, 28 Mar 2014 12:50:35 +0100
Message-ID: <1396007435-20100-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59987 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbaC1Lux (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 07:50:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, NeilBrown <neilb@suse.de>, Wolfram Sang <wsa@sang-engineering.com>

From: NeilBrown <neilb@suse.de>

If omap_device_alloc is given 2 or more "struct omap_hwmod" it will try
to register the 'main_clk' of each of them with the same alias - "fck" -
against the same device.  This fails. So to avoid a warning, don't even
try.

Signed-off-by: NeilBrown <neilb@suse.de>
[wsa: ported to top-of-tree]
Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---

Digged this out from the net and think this makes sense. I am going to use it
with an AM335x based board. Based on v3.14-rc8.

 arch/arm/mach-omap2/omap_device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 01ef59def44b..ce132d0084d2 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -84,6 +84,7 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
  * and main clock
  * @od: struct omap_device *od
  * @oh: struct omap_hwmod *oh
+ * @sub: if > 0, this is a subordinate device, so don't try to register fck
  *
  * For the main clock and every optional clock present per hwmod per
  * omap_device, this function adds an entry in the clkdev table of the
@@ -99,11 +100,12 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
  * No return value.
  */
 static void _add_hwmod_clocks_clkdev(struct omap_device *od,
-				     struct omap_hwmod *oh)
+				     struct omap_hwmod *oh, int sub)
 {
 	int i;
 
-	_add_clkdev(od, "fck", oh->main_clk);
+	if (!sub)
+		_add_clkdev(od, "fck", oh->main_clk);
 
 	for (i = 0; i < oh->opt_clks_cnt; i++)
 		_add_clkdev(od, oh->opt_clks[i].role, oh->opt_clks[i].clk);
@@ -468,7 +470,7 @@ have_everything:
 
 	for (i = 0; i < oh_cnt; i++) {
 		hwmods[i]->od = od;
-		_add_hwmod_clocks_clkdev(od, hwmods[i]);
+		_add_hwmod_clocks_clkdev(od, hwmods[i], i);
 	}
 
 	return od;
-- 
1.9.0

