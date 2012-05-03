From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH 2/3] OMAP: dsp: interface to control module functions
Date: Wed,  2 May 2012 21:11:52 -0500
Message-ID: <1336011113-31502-3-git-send-email-omar.luna@linaro.org>
References: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63256 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092Ab2ECCMI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 22:12:08 -0400
Received: by mail-ob0-f174.google.com with SMTP id tb18so1792752obb.19
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 19:12:08 -0700 (PDT)
In-Reply-To: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-dev@lists.linaro.org, Omar Ramirez Luna <omar.luna@linaro.org>

Provide an interface for a driver to call SCM functions to
set a boot address and boot mode.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/mach-omap2/dsp.c             |    4 ++++
 arch/arm/plat-omap/include/plat/dsp.h |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index 74f18f2..6d37d3c 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -20,6 +20,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include "control.h"
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
 #ifdef CONFIG_BRIDGE_DVFS
@@ -45,6 +46,9 @@ static struct omap_dsp_platform_data omap_dsp_pdata __initdata = {
 	.dsp_cm_read = omap2_cm_read_mod_reg,
 	.dsp_cm_write = omap2_cm_write_mod_reg,
 	.dsp_cm_rmw_bits = omap2_cm_rmw_mod_reg_bits,
+
+	.set_bootaddr = omap_ctrl_write_dsp_boot_addr,
+	.set_bootmode = omap_ctrl_write_dsp_boot_mode,
 };
 
 static int __init omap_dsp_init(void)
diff --git a/arch/arm/plat-omap/include/plat/dsp.h b/arch/arm/plat-omap/include/plat/dsp.h
index 9c604b3..5927709 100644
--- a/arch/arm/plat-omap/include/plat/dsp.h
+++ b/arch/arm/plat-omap/include/plat/dsp.h
@@ -18,6 +18,9 @@ struct omap_dsp_platform_data {
 	u32 (*dsp_cm_read)(s16 , u16);
 	u32 (*dsp_cm_rmw_bits)(u32, u32, s16, s16);
 
+	void (*set_bootaddr)(u32);
+	void (*set_bootmode)(u8);
+
 	phys_addr_t phys_mempool_base;
 	phys_addr_t phys_mempool_size;
 };
-- 
1.7.4.1

