From: Juergen Kilb <J.Kilb@phytec.de>
Subject: [PATCH 2/2] ARM:OMAP:hwmod: Fix sr1_hwmod and sr2_hwmod warning.
Date: Mon, 7 Nov 2011 22:30:17 +0100
Message-ID: <1320701417-16818-3-git-send-email-J.Kilb@phytec.de>
References: <1320701417-16818-1-git-send-email-J.Kilb@phytec.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.microcatalog.org.uk ([217.6.246.34]:37939 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab1KGVar (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Nov 2011 16:30:47 -0500
In-Reply-To: <1320701417-16818-1-git-send-email-J.Kilb@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Juergen Kilb <J.Kilb@phytec.de>

sr1_hwmod and sr2_hwmod are handled in omap34xx_hwmods,
which is for all omap34xx variants.
But they are also defined in omap3xxx_hwmods.

This leads to:

[    0.000000] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1959 omap_hwmod_register+0x40/0x1ac()
[    0.000000] omap_hwmod: sr1_hwmod: _register returned -22
[    0.000000] Modules linked in:
[    0.000000] [<c001b11c>] (unwind_backtrace+0x0/0xf4) from [<c0051540>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c0051540>] (warn_slowpath_common+0x4c/0x64) from [<c00515ec>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c00515ec>] (warn_slowpath_fmt+0x30/0x40) from [<c0639370>] (omap_hwmod_register+0x40/0x1ac)
[    0.000000] [<c0639370>] (omap_hwmod_register+0x40/0x1ac) from [<c063c138>] (omap3xxx_hwmod_init+0xb0/0x188)
[    0.000000] [<c063c138>] (omap3xxx_hwmod_init+0xb0/0x188) from [<c06365b0>] (omap3_init_early+0x20/0x30)
[    0.000000] [<c06365b0>] (omap3_init_early+0x20/0x30) from [<c063219c>] (setup_arch+0x528/0x9a4)
[    0.000000] [<c063219c>] (setup_arch+0x528/0x9a4) from [<c062e64c>] (start_kernel+0x7c/0x330)
[    0.000000] [<c062e64c>] (start_kernel+0x7c/0x330) from [<80008044>] (0x80008044)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1959 omap_hwmod_register+0x40/0x1ac()
[    0.000000] omap_hwmod: sr2_hwmod: _register returned -22
[    0.000000] Modules linked in:
[    0.000000] [<c001b11c>] (unwind_backtrace+0x0/0xf4) from [<c0051540>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c0051540>] (warn_slowpath_common+0x4c/0x64) from [<c00515ec>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c00515ec>] (warn_slowpath_fmt+0x30/0x40) from [<c0639370>] (omap_hwmod_register+0x40/0x1ac)
[    0.000000] [<c0639370>] (omap_hwmod_register+0x40/0x1ac) from [<c063c138>] (omap3xxx_hwmod_init+0xb0/0x188)
[    0.000000] [<c063c138>] (omap3xxx_hwmod_init+0xb0/0x188) from [<c06365b0>] (omap3_init_early+0x20/0x30)
[    0.000000] [<c06365b0>] (omap3_init_early+0x20/0x30) from [<c063219c>] (setup_arch+0x528/0x9a4)
[    0.000000] [<c063219c>] (setup_arch+0x528/0x9a4) from [<c062e64c>] (start_kernel+0x7c/0x330)
[    0.000000] [<c062e64c>] (start_kernel+0x7c/0x330) from [<80008044>] (0x80008044)
[    0.000000] ---[ end trace 1b75b31a2719ed1d ]---

So remove them from omap3xxx_hwmod definition.

Signed-off-by: Juergen Kilb <J.Kilb@phytec.de>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 30ec4bd..a49e758 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3188,8 +3188,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_i2c1_hwmod,
 	&omap3xxx_i2c2_hwmod,
 	&omap3xxx_i2c3_hwmod,
-	&omap34xx_sr1_hwmod,
-	&omap34xx_sr2_hwmod,
 
 	/* gpio class */
 	&omap3xxx_gpio1_hwmod,
-- 
1.7.0.4

