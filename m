From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH] BRIDGE OMAP PM Bug softlockup fix
Date: Thu, 4 Sep 2008 16:30:03 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A534490090F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33505 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733AbYIDVaL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 17:30:11 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m84LU541010428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 4 Sep 2008 16:30:10 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m84LU51Q002187
	for <linux-omap@vger.kernel.org>; Thu, 4 Sep 2008 16:30:05 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Ramesh Gupta <grgupta@ti.com>
Date: Thu, 4 Sep 2008 00:31:04 -0500
Subject: [PATCH] BRIDGE OMAP PM Bug softlockup fix

Fix BUG# soft lockup issue with the Open Source
Power Management.

Signed-off-by: Ramesh Gupta <grgupta@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 0da20a0..22aaa8e 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -281,8 +281,6 @@ static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *hDevContext)
     if ((temp & 0x03) != 0x03 || (temp & 0x03) != 0x02) {
 		/* IVA2 is not in ON state */
 		/* Read and set PM_PWSTCTRL_IVA2  to ON */
-		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
-				     &pwrState);
 		HW_PWR_IVA2PowerStateSet(resources.dwPrmBase,
 					  HW_PWR_DOMAIN_DSP,
 					  HW_PWR_STATE_ON);
@@ -753,9 +751,7 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 				 "for iva2_fck\n");
 			}
 		/* IVA2 is not in OFF state */
-		/* Read and set PM_PWSTCTRL_IVA2  to OFF */
-		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
-				     &pwrState);
+		/* Set PM_PWSTCTRL_IVA2  to OFF */
 		HW_PWR_IVA2PowerStateSet(resources.dwPrmBase,
 					  HW_PWR_DOMAIN_DSP,
 					  HW_PWR_STATE_OFF);
@@ -2054,8 +2050,7 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, u32 cm_base,
 	HW_PWRST_IVA2RegGet(prm_base, &temp);
 	 if ((temp & 0x03) != 0x03 || (temp & 0x03) != 0x02) {
 		/* IVA2 is not in ON state */
-		/* Read and set PM_PWSTCTRL_IVA2  to ON */
-		HW_PWR_IVA2StateGet(prm_base, HW_PWR_DOMAIN_DSP, &pwrState);
+		/* Set PM_PWSTCTRL_IVA2  to ON */
 		HW_PWR_IVA2PowerStateSet(prm_base, HW_PWR_DOMAIN_DSP,
 					  HW_PWR_STATE_ON);
 		/* Set the SW supervised state transition */
-- 
1.5.6.4
