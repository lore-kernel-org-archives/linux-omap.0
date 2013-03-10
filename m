From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ARM: OMAP3: hwmod data: disable MIDLEMODE control for musb
Date: Sun, 10 Mar 2013 02:46:31 +0200
Message-ID: <1362876391-6801-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:56323 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3CJAqz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Mar 2013 19:46:55 -0500
Received: by mail-ee0-f42.google.com with SMTP id b47so1679610eek.29
        for <linux-omap@vger.kernel.org>; Sat, 09 Mar 2013 16:46:54 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Grazvydas Ignotas <notasas@gmail.com>

For some unknown reason, allowing hwmod to control MIDLEMODE causes
core_pwrdm to not hit idle states for musb in DM3730 at least.
I've verified that setting any MIDLEMODE value other than "force
standby" before enabling the device causes subsequent suspend
attempts to fail with core_pwrdm not entering idle states, even
if the driver is unloaded and "force standby" is restored before
suspend attempt.

Keeping the register set at force standby (reset value) makes it work
and device still functions properly. musb has driver-controlled
OTG_FORCESTDBY register that controls MSTANDBY signal, so perhaps
MIDLEMODE is not even needed? Note that TI PSP kernels also have
similar workarounds.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ac7e03e..0388bba 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1666,11 +1666,15 @@ static struct omap_hwmod_class_sysconfig omap3xxx_usbhsotg_sysc = {
 	.rev_offs	= 0x0400,
 	.sysc_offs	= 0x0404,
 	.syss_offs	= 0x0408,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
-			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			  SYSC_HAS_AUTOIDLE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			  MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	/*
+	 * musb has MMIDLEMODE, but if we ever enable the device not in force
+	 * idle mode, core_pwrdm does not enter idle states at least on 36xx.
+	 * Note that musb also has OTG_FORCESTDBY register that the driver
+	 * uses to control MSTANDBY signal manually.
+	 */
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_ENAWAKEUP |
+			  SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-- 
1.7.9.5

