From: Suman Anna <s-anna@ti.com>
Subject: [PATCH] ARM: OMAP2+: control: add OMAP5 support for dsp boot programming
Date: Wed, 17 Apr 2013 16:31:03 -0500
Message-ID: <1366234263-29875-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54048 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965578Ab3DQVfz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Apr 2013 17:35:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

Support for OMAP5 is added to the omap_dsp_ctrl_write_boot_addr()
to enable the DSP boot.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/control.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 2adb268..31e0dfe 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -249,6 +249,7 @@ void omap_ctrl_write_dsp_boot_addr(u32 bootaddr)
 	u32 offset = cpu_is_omap243x() ? OMAP243X_CONTROL_IVA2_BOOTADDR :
 		     cpu_is_omap34xx() ? OMAP343X_CONTROL_IVA2_BOOTADDR :
 		     cpu_is_omap44xx() ? OMAP4_CTRL_MODULE_CORE_DSP_BOOTADDR :
+		     soc_is_omap54xx() ? OMAP4_CTRL_MODULE_CORE_DSP_BOOTADDR :
 		     0;
 
 	if (!offset) {
-- 
1.8.2

