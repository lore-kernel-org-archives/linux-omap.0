From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Maintain VDD1 at OPP3 while DSP is active
Date: Fri, 17 Jul 2009 03:33:50 +0300 (EEST)
Message-ID: <20090717.033350.115910354.Hiroshi.DOYU@nokia.com>
References: <1247787352-22732-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37039 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933850AbZGQAeB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2009 20:34:01 -0400
In-Reply-To: <1247787352-22732-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ameya.palande@nokia.com
Cc: linux-omap@vger.kernel.org, omar.ramirez@ti.com, x0095840@ti.com, nm@ti.com

From: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Maintain VDD1 at OPP3 while DSP is active
Date: Fri, 17 Jul 2009 01:35:52 +0200

> With Smartreflex ON, OPP2 is not sufficient for reliable DSP operation and
> we can see following problems:
> 
> 1. DSP mailbox timeout
> 2. DSP MMU Faults
> 3. DSP SYSERRORS
> 
> To avoid these issues, this patch maintains OPP3 for DSP active operation by
> introducing a new new module parameter "min_active_opp". This can be used
> for tuning OPP active value depending on the hardware configuration.

Alternatively avoding wrong combinations of SR + OPP? can be another
possibility if it can achieve lower power consumption like:

Not tested.

>From e1bc72772e63b2037547872037e96dd535be52c2 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Fri, 17 Jul 2009 03:24:26 +0300
Subject: [PATCH 1/1] DSPBRIDGE: workaround for SR and inappropriate OPP


Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/dspbridge.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index 43283c9..f31f84d 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -14,13 +14,37 @@
 #include <linux/platform_device.h>
 
 #include <mach/omap-pm.h>
+#include <mach/resource.h>
 
 #include <dspbridge/host_os.h>
 
+#include "smartreflex.h"
+
 static struct platform_device *dspbridge_pdev;
 
+
+/* workaround for SR with unapropriate OPP */
+static void __omap_pm_dsp_set_min_opp(u8 opp_id)
+{
+	u32 current_vdd1opp_no;
+
+	switch (opp_id) {
+	case 2:
+		sr_stop_vddautocomap(SR1);
+		break;
+	default:
+		current_vdd1opp_no = resource_get_level("vdd1_opp");
+		if (IS_ERR_VALUE(current_vdd1opp_no))
+			return;
+		sr_start_vddautocomap(SR1, current_vdd1opp_no);
+		break;
+	}
+
+	omap_pm_dsp_set_min_opp(opp_id);
+}
+
 static struct dspbridge_platform_data dspbridge_pdata __initdata = {
-	.dsp_set_min_opp = omap_pm_dsp_set_min_opp,
+	.dsp_set_min_opp = __omap_pm_dsp_set_min_opp,
 	.dsp_get_opp	 = omap_pm_dsp_get_opp,
 	.cpu_set_freq	 = omap_pm_cpu_set_freq,
 	.cpu_get_freq	 = omap_pm_cpu_get_freq,
-- 
1.6.0.4


