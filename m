From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/6] ARM: OMAP2+: hwmod: use init-time function pointer
 for _init_clkdm
Date: Mon, 30 Apr 2012 08:35:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204300834530.10308@utopia.booyaka.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com> <1335557140-10854-7-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40854 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300Ab2D3Ofx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 10:35:53 -0400
In-Reply-To: <1335557140-10854-7-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Fri, 27 Apr 2012, Kevin Hilman wrote:

> Rather than use runtime cpu_is* checking inside _init_clkdm, initialize
> SoC specific function pointer at init time.
> 
> Note that initializing the function pointer oh->init_clkdm pointer
> must be done before _init_clocks() is called because it is used there.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Converted this patch to use the soc_ops function pointers and tweaked the 
commit message - please let me know if you have any comments.


- Paul

From: Kevin Hilman <khilman@ti.com>
Date: Fri, 27 Apr 2012 13:05:40 -0700
Subject: [PATCH 6/6] ARM: OMAP2+: hwmod: use init-time function pointer for
 _init_clkdm

Rather than use runtime cpu_is* checking inside _init_clkdm, initialize
SoC specific function pointer at init time.

Signed-off-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: convert to use soc_ops function pointers; remove second para
 from commit message since soc_ops function pointers are now set during hwmod
 layer init]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 93cb96d..acc616c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -185,6 +185,7 @@ struct omap_hwmod_soc_ops {
 				  struct omap_hwmod_rst_info *ohri);
 	int (*is_hardreset_asserted)(struct omap_hwmod *oh,
 				     struct omap_hwmod_rst_info *ohri);
+	int (*init_clkdm)(struct omap_hwmod *oh);
 };
 
 /* soc_ops: adapts the omap_hwmod code to the currently-booted SoC */
@@ -1315,9 +1316,6 @@ static struct omap_hwmod *_lookup(const char *name)
  */
 static int _init_clkdm(struct omap_hwmod *oh)
 {
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		return 0;
-
 	if (!oh->clkdm_name) {
 		pr_warning("omap_hwmod: %s: no clkdm_name\n", oh->name);
 		return -EINVAL;
@@ -1358,7 +1356,8 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 	ret |= _init_main_clk(oh);
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
-	ret |= _init_clkdm(oh);
+	if (soc_ops.init_clkdm)
+		ret |= soc_ops.init_clkdm(oh);
 
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
@@ -3569,6 +3568,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.assert_hardreset = _omap4_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
+		soc_ops.init_clkdm = _init_clkdm;
 	} else {
 		WARN(1, "omap_hwmod: unknown SoC type\n");
 	}
-- 
1.7.10

