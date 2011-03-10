From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH] OMAP4: Intialize IVA Device in addition to DSP device.
Date: Thu, 10 Mar 2011 11:52:28 +0530
Message-ID: <1299738148-28557-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46930 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893Ab1CJGWi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 01:22:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Shweta Gulati <shweta.gulati@ti.com>

OMAP4 has two different Devices IVA and DSP. DSP is bound
with MPU for DVFS and IVA has its own well defined OPPs.
This Patch adds IVA init to 'omap2_init_processor_devices'
and make sure that API 'omap2_set_init_voltage' is called
for apt dev pointer.

It fixes Error logs:

	omap2_set_init_voltage: Invalid parameters!
	omap2_set_init_voltage: Unable to put vdd_iva to its init voltage

Tested on OMAP4430 SDP Board.
Baseline:
http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
Branch :pm-core

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---
 arch/arm/mach-omap2/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 30af335..49486f5 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -89,6 +89,7 @@ static void omap2_init_processor_devices(void)
 	if (cpu_is_omap44xx()) {
 		_init_omap_device("l3_main_1", &l3_dev);
 		_init_omap_device("dsp", &dsp_dev);
+		_init_omap_device("iva", &iva_dev);
 	} else {
 		_init_omap_device("l3_main", &l3_dev);
 	}
-- 
1.7.0.4

