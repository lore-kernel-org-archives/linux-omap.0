From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/5] omap: dsp: add boot control functions
Date: Sun,  7 Nov 2010 23:43:28 +0200
Message-ID: <1289166209-32251-5-git-send-email-felipe.contreras@gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44122 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab0KGVpG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 16:45:06 -0500
Received: by mail-fx0-f46.google.com with SMTP id 16so3600214fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 13:45:05 -0800 (PST)
In-Reply-To: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

From: Paul Walmsley <paul@pwsan.com>

Would be needed to avoid using SCM directly.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/dsp.c             |    4 ++++
 arch/arm/plat-omap/include/plat/dsp.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index 6feeeae..6a21ac6 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/platform_device.h>
+#include "control.h"
 #include "prm.h"
 #include "cm.h"
 #ifdef CONFIG_BRIDGE_DVFS
@@ -31,6 +32,9 @@ static struct omap_dsp_platform_data omap_dsp_pdata __initdata = {
 	.cpu_set_freq = omap_pm_cpu_set_freq,
 	.cpu_get_freq = omap_pm_cpu_get_freq,
 #endif
+	.set_dsp_bootaddr = omap_ctrl_set_dsp_bootaddr,
+	.set_dsp_bootmode = omap_ctrl_set_dsp_bootmode,
+
 	.dsp_prm_read = prm_read_mod_reg,
 	.dsp_prm_write = prm_write_mod_reg,
 	.dsp_prm_rmw_bits = prm_rmw_mod_reg_bits,
diff --git a/arch/arm/plat-omap/include/plat/dsp.h b/arch/arm/plat-omap/include/plat/dsp.h
index 079691d..b2cf15b 100644
--- a/arch/arm/plat-omap/include/plat/dsp.h
+++ b/arch/arm/plat-omap/include/plat/dsp.h
@@ -10,7 +10,11 @@ struct omap_dsp_platform_data {
 	unsigned long (*cpu_get_freq) (void);
 	unsigned long mpu_speed[6];
 
+	void (*set_dsp_bootaddr)(u32 pa);
+	void (*set_dsp_bootmode)(u8 mode);
+
 	/* functions to write and read PRCM registers */
+	/* XXX None of this should be here */
 	void (*dsp_prm_write)(u32, s16 , u16);
 	u32 (*dsp_prm_read)(s16 , u16);
 	u32 (*dsp_prm_rmw_bits)(u32, u32, s16, s16);
-- 
1.7.3.2.3.gf8529

