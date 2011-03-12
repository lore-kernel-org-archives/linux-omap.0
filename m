From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH V2] OMAP4: Intialize IVA Device in addition to DSP device.
Date: Sat, 12 Mar 2011 16:09:21 +0530
Message-ID: <1299926361-28482-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37397 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352Ab1CLKjb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Mar 2011 05:39:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Shweta Gulati <shweta.gulati@ti.com>

OMAP4 has two different Devices IVA and DSP. DSP is bound
with IVA for DVFS. The registration of IVA dev in API
'omap2_init_processor_devices' was missing. Init dev for
'iva_dev' is added.

This also fixes the following error seen during boot as
omap2_set_init_voltage can now find the iva device

	omap2_set_init_voltage: Invalid parameters!
	omap2_set_init_voltage: Unable to put vdd_iva to its init voltage

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---

Tested on OMAP4430 SDP Board.
Baseline:
http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
Branch :pm-core

V2:
Rephrased the Commit log.

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

