From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 09/14] OMAP: Disable smartreflex across DVFS
Date: Fri, 29 Oct 2010 21:08:23 +0530
Message-ID: <1288366708-32302-10-git-send-email-thara@ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34615 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932682Ab0J2Pil (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Oct 2010 11:38:41 -0400
In-Reply-To: <1288366708-32302-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch disables smartreflex for a particular voltage
domain when the the voltage domain and the devices belonging
to it is being scaled and re-enables it back once the scaling
is done.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 67748b0..6f85f75 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -32,6 +32,7 @@
 #include <plat/common.h>
 #include <plat/voltage.h>
 #include <plat/omap_device.h>
+#include <plat/smartreflex.h>
 
 #include "prm-regbits-34xx.h"
 #include "prm44xx.h"
@@ -1828,6 +1829,9 @@ int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
 		return -EINVAL;
 	}
 
+	/* Disable smartreflex module across voltage and frequency scaling */
+	omap_sr_disable(voltdm);
+
 	if (curr_volt == volt) {
 		is_volt_scaled = 1;
 	} else if (curr_volt < volt) {
@@ -1865,6 +1869,9 @@ int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
 
 	mutex_unlock(&vdd->scaling_mutex);
 
+	/* Enable Smartreflex module */
+	omap_sr_enable(voltdm);
+
 	/* Scale dependent vdds */
 	scale_dep_vdd(vdd);
 
-- 
1.7.0.4

