From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: [PATCH] fix issue where hwmods are being called twice during init
Date: Thu, 08 Dec 2011 22:36:13 +0100
Message-ID: <jbrake$vnf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020707010802030402050803"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:54669 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285Ab1LHVkK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Dec 2011 16:40:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RYlhI-0005cI-NP
	for linux-omap@vger.kernel.org; Thu, 08 Dec 2011 22:40:08 +0100
Received: from dslb-178-008-122-127.pools.arcor-ip.net ([178.8.122.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 22:40:08 +0100
Received: from andre.puschmann by dslb-178-008-122-127.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 22:40:08 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020707010802030402050803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi list,

when compiling the current git HEAD for a Gumstix Overo based board I
discovered an issue during init causing the error message which is
attached. I believe this is because they are called twice during init
(the omap34xx_hwmods struct already contains them).

The attached patch fixes this issue.

BR
Andre

Signed-off-by: Andre Puschmann <andre.puschmann@tu-ilmenau.de>

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 7f8915a..eef43e2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3247,18 +3247,14 @@ static __initdata struct omap_hwmod
*omap3xxx_hwmods[] = {

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



Kernel output:

------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1959
omap_hwmod_r)
[    0.000000] omap_hwmod: iva: _register returned -22
[    0.000000] Modules linked in:
[    0.000000] [<c001b478>] (unwind_backtrace+0x0/0xf0) from
[<c0053a70>] (wa)
[    0.000000] [<c0053a70>] (warn_slowpath_common+0x4c/0x64) from
[<c0053b1c>)
[    0.000000] [<c0053b1c>] (warn_slowpath_fmt+0x30/0x40) from
[<c0681690>] ()
[    0.000000] [<c0681690>] (omap_hwmod_register+0x11c/0x158) from
[<c067e9e8)
[    0.000000] [<c067e9e8>] (omap3_init_early+0x1c/0x28) from
[<c067ad50>] (s)
[    0.000000] [<c067ad50>] (setup_arch+0x814/0x934) from [<c0677560>]
(start)
[    0.000000] [<c0677560>] (start_kernel+0x80/0x304) from [<80008044>]
(0x80)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1959
omap_hwmod_r)
[    0.000000] omap_hwmod: mailbox: _register returned -22
[    0.000000] Modules linked in:
[    0.000000] [<c001b478>] (unwind_backtrace+0x0/0xf0) from
[<c0053a70>] (wa)
[    0.000000] [<c0053a70>] (warn_slowpath_common+0x4c/0x64) from
[<c0053b1c>)
[    0.000000] [<c0053b1c>] (warn_slowpath_fmt+0x30/0x40) from
[<c0681690>] ()
[    0.000000] [<c0681690>] (omap_hwmod_register+0x11c/0x158) from
[<c067e9e8)
[    0.000000] [<c067e9e8>] (omap3_init_early+0x1c/0x28) from
[<c067ad50>] (s)
[    0.000000] [<c067ad50>] (setup_arch+0x814/0x934) from [<c0677560>]
(start)
[    0.000000] [<c0677560>] (start_kernel+0x80/0x304) from [<80008044>]
(0x80)
[    0.000000] ---[ end trace 1b75b31a2719ed1d ]---

--------------020707010802030402050803
Content-Type: text/x-patch;
 name="remove_double_call_hwmods.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="remove_double_call_hwmods.patch"

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
 

--------------020707010802030402050803--

