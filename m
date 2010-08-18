From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 09/13] OMAP: Disable smartreflex across DVFS
Date: Wed, 18 Aug 2010 16:50:08 +0530
Message-ID: <1282130412-12027-10-git-send-email-thara@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41238 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802Ab0HRLU0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:20:26 -0400
In-Reply-To: <1282130412-12027-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch disables smartreflex for a particular voltage
domain when the the voltage domain and the devices belonging
to it is being scaled and re-enables it back once the scaling
is done.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 1a46eb0..2fd644a 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -35,6 +35,7 @@
 #include <plat/clock.h>
 #include <plat/common.h>
 #include <plat/voltage.h>
+#include <plat/smartreflex.h>
 
 #include "prm-regbits-34xx.h"
 #include "prm44xx.h"
@@ -1730,6 +1731,9 @@ int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
 		return -EINVAL;
 	}
 
+	/* Disable smartreflex module across voltage and frequency scaling */
+	omap_smartreflex_disable(voltdm);
+
 	if (curr_volt == volt) {
 		is_volt_scaled = 1;
 	} else if (curr_volt < volt) {
@@ -1764,6 +1768,9 @@ int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
 
 	mutex_unlock(&vdd->scaling_mutex);
 
+	/* Enable Smartreflex module */
+	omap_smartreflex_enable(voltdm);
+
 	/* Scale dependent vdds */
 	scale_dep_vdd(vdd);
 
-- 
1.7.1.GIT

