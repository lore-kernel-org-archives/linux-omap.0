From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] ARM: OMAP2+: voltage: fixup oscillator handling when CONFIG_PM=n
Date: Wed, 14 Nov 2012 17:13:04 -0800
Message-ID: <1352941984-11828-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33134 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992481Ab2KOBNH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 20:13:07 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so707294pad.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Nov 2012 17:13:06 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

From: Kevin Hilman <khilman@ti.com>

commit 908b75e8 (ARM: OMAP: add support for oscillator setup) added a new
API for oscillator setup, but is broken when CONFIG_PM=n.

The new functions have dummy definitions when CONFIG_PM=n, but also have
full implementations available, which conflict.

To fix, wrap the PM implmentations in #ifdef CONFIG_PM.

Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
This applies to Tony's omap-for-v3.8/pm branch, which includes my
for_3.8-pm-voltage tag where this bug was introduced.

 arch/arm/mach-omap2/pm.c | 2 ++
 arch/arm/mach-omap2/pm.h | 2 +-
 arch/arm/mach-omap2/vc.c | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 109a02e..ef668c756 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -39,6 +39,7 @@ static struct omap_device_pm_latency *pm_lats;
  */
 int (*omap_pm_suspend)(void);
 
+#ifdef CONFIG_PM
 /**
  * struct omap2_oscillator - Describe the board main oscillator latencies
  * @startup_time: oscillator startup latency
@@ -68,6 +69,7 @@ void omap_pm_get_oscillator(u32 *tstart, u32 *tshut)
 	*tstart = oscillator.startup_time;
 	*tshut = oscillator.shutdown_time;
 }
+#endif
 
 static int __init _init_omap_device(char *name)
 {
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 4db7b23..02c291c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -135,7 +135,7 @@ extern void omap_pm_get_oscillator(u32 *tstart, u32 *tshut);
 extern void omap_pm_setup_sr_i2c_pcb_length(u32 mm);
 #else
 static inline void omap_pm_setup_oscillator(u32 tstart, u32 tshut) { }
-static inline void omap_pm_get_oscillator(u32 *tstart, u32 *tshut) { }
+static inline void omap_pm_get_oscillator(u32 *tstart, u32 *tshut) { *tstart = *tshut = 0; }
 static inline void omap_pm_setup_sr_i2c_pcb_length(u32 mm) { }
 #endif
 
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 687aa86..a89ec8a 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -666,6 +666,7 @@ static u8 omap_vc_calc_vsel(struct voltagedomain *voltdm, u32 uvolt)
 	return voltdm->pmic->uv_to_vsel(uvolt);
 }
 
+#ifdef CONFIG_PM
 /**
  * omap_pm_setup_sr_i2c_pcb_length - set length of SR I2C traces on PCB
  * @mm: length of the PCB trace in millimetres
@@ -678,6 +679,7 @@ void __init omap_pm_setup_sr_i2c_pcb_length(u32 mm)
 {
 	sr_i2c_pcb_length = mm;
 }
+#endif
 
 void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 {
-- 
1.8.0

