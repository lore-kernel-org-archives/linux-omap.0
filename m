From: <shivananda.hebbarp@wipro.com>
Subject: RE: [PATCH] BRIDGE OMAP PM Bug softlockup fix
Date: Fri, 5 Sep 2008 15:36:24 +0530
Message-ID: <70E3BF80B2DA6E469688AD5C3BBCC6C403F3CEC6@BLR-EC-MBX02.wipro.com>
References: <27F9C60D11D683428E133F85D2BB4A534490090F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wipro-blr-out01.wipro.com ([203.91.198.74]:57139 "EHLO
	wipro-blr-out01.wipro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbYIEK35 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 06:29:57 -0400
Received: from blr-ec-aa01.wipro.com (unknown [10.201.18.41])
	by wipro-blr-out01.wipro.com (Symantec Mail Security) with ESMTP id 7CB204E4006
	for <linux-omap@vger.kernel.org>; Fri,  5 Sep 2008 15:36:25 +0530 (IST)
Content-class: urn:content-classes:message
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A534490090F@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x00omar@ti.com, linux-omap@vger.kernel.org

 
-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ramirez Luna,
Omar
Sent: Friday, September 05, 2008 3:00 AM
To: linux-omap@vger.kernel.org
Subject: [PATCH] BRIDGE OMAP PM Bug softlockup fix
 @@ -753,9 +751,7 @@ static DSP_STATUS WMD_BRD_Stop(struct
WMD_DEV_CONTEXT *hDevContext)
 				 "for iva2_fck\n");
 			}
 		/* IVA2 is not in OFF state */
-		/* Read and set PM_PWSTCTRL_IVA2  to OFF */
-		HW_PWR_IVA2StateGet(resources.dwPrmBase,
HW_PWR_DOMAIN_DSP,
-				     &pwrState);
+		/* Set PM_PWSTCTRL_IVA2  to OFF */
 		HW_PWR_IVA2PowerStateSet(resources.dwPrmBase,
 					  HW_PWR_DOMAIN_DSP,
 					  HW_PWR_STATE_OFF);
@@ -2054,8 +2050,7 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, u32
cm_base,
 	HW_PWRST_IVA2RegGet(prm_base, &temp);
 	 if ((temp & 0x03) != 0x03 || (temp & 0x03) != 0x02) {
 		/* IVA2 is not in ON state */
-		/* Read and set PM_PWSTCTRL_IVA2  to ON */
-		HW_PWR_IVA2StateGet(prm_base, HW_PWR_DOMAIN_DSP,
&pwrState);
+		/* Set PM_PWSTCTRL_IVA2  to ON */
 		HW_PWR_IVA2PowerStateSet(prm_base, HW_PWR_DOMAIN_DSP,
 					  HW_PWR_STATE_ON);
 		/* Set the SW supervised state transition */

Here in one place ,you access prm base with resources.dwPrmBase and next
time access with just prm_base .Can we have have a consistent way of
accessing it ?

--Shiva
