From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: [PATCH] omap: fix iva and mailbox hwmods for OMAP 3
Date: Mon,  5 Dec 2011 20:20:46 +0200
Message-ID: <1323109246-1458-1-git-send-email-felipe.contreras@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:26856 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140Ab1LESU4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Dec 2011 13:20:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, Abhilash K V <abhilash.kv@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

From: Felipe Contreras <felipe.contreras@gmail.com>

Seems the commit 7e89098 was overly aggressive in adding iva and mailbox
hwmods so now they are registered twice.

------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1959 omap_hwmod_register+0x104/0x12c()
omap_hwmod: iva: _register returned -22
Modules linked in:
[<c0012aa4>] (unwind_backtrace+0x0/0xec) from [<c002f970>] (warn_slowpath_common+0x4c/0x64)
[<c002f970>] (warn_slowpath_common+0x4c/0x64) from [<c002fa08>] (warn_slowpath_fmt+0x2c/0x3c)
[<c002fa08>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02fdb4c>] (omap_hwmod_register+0x104/0x12c)
[<c02fdb4c>] (omap_hwmod_register+0x104/0x12c) from [<c02fbb44>] (omap3_init_early+0x1c/0x28)
[<c02fbb44>] (omap3_init_early+0x1c/0x28) from [<c02f9580>] (setup_arch+0x6b8/0x7a4)
[<c02f9580>] (setup_arch+0x6b8/0x7a4) from [<c02f754c>] (start_kernel+0x6c/0x264)
[<c02f754c>] (start_kernel+0x6c/0x264) from [<80008040>] (0x80008040)
---[ end trace 1b75b31a2719ed1c ]---
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1959 omap_hwmod_register+0x104/0x12c()
omap_hwmod: mailbox: _register returned -22
Modules linked in:
[<c0012aa4>] (unwind_backtrace+0x0/0xec) from [<c002f970>] (warn_slowpath_common+0x4c/0x64)
[<c002f970>] (warn_slowpath_common+0x4c/0x64) from [<c002fa08>] (warn_slowpath_fmt+0x2c/0x3c)
[<c002fa08>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02fdb4c>] (omap_hwmod_register+0x104/0x12c)
[<c02fdb4c>] (omap_hwmod_register+0x104/0x12c) from [<c02fbb44>] (omap3_init_early+0x1c/0x28)
[<c02fbb44>] (omap3_init_early+0x1c/0x28) from [<c02f9580>] (setup_arch+0x6b8/0x7a4)
[<c02f9580>] (setup_arch+0x6b8/0x7a4) from [<c02f754c>] (start_kernel+0x6c/0x264)
[<c02f754c>] (start_kernel+0x6c/0x264) from [<80008040>] (0x80008040)
---[ end trace 1b75b31a2719ed1d ]---

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 7f8915a..eef43e2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3247,18 +3247,14 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 
 /* 3430ES1-only hwmods */
 static __initdata struct omap_hwmod *omap3430es1_hwmods[] = {
-	&omap3xxx_iva_hwmod,
 	&omap3430es1_dss_core_hwmod,
-	&omap3xxx_mailbox_hwmod,
 	NULL
 };
 
 /* 3430ES2+-only hwmods */
 static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] = {
-	&omap3xxx_iva_hwmod,
 	&omap3xxx_dss_core_hwmod,
 	&omap3xxx_usbhsotg_hwmod,
-	&omap3xxx_mailbox_hwmod,
 	NULL
 };
 
-- 
1.7.8.rc3.17.gf56ef1

