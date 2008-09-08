From: "Ramesh Gupta Guntha" <x0023949@ti.com>
Subject: RE: [PATCH] BRIDGE OMAP PM Bug softlockup fix
Date: Mon, 8 Sep 2008 10:45:21 +0530
Message-ID: <200809080515.m885FL2Z002681@dbdp31.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55361 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbYIHFPc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Sep 2008 01:15:32 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m885FNOb025748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 8 Sep 2008 00:15:31 -0500
Received: from sasx0023949 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m885FL2Z002681
	for <linux-omap@vger.kernel.org>; Mon, 8 Sep 2008 10:45:22 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi Shivananda,

<snip>

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ramirez Luna, 
>> Omar
>> Sent: Friday, September 05, 2008 3:00 AM
>> To: linux-omap@vger.kernel.org
>> Subject: [PATCH] BRIDGE OMAP PM Bug softlockup fix  @@ -753,9
>> +751,7 @@ static DSP_STATUS WMD_BRD_Stop(struct
>> WMD_DEV_CONTEXT *hDevContext)
>>                                  "for iva2_fck\n");
>>                         }
>>                 /* IVA2 is not in OFF state */
>> -               /* Read and set PM_PWSTCTRL_IVA2  to OFF */
>> -               HW_PWR_IVA2StateGet(resources.dwPrmBase,
>> HW_PWR_DOMAIN_DSP,
>> -                                    &pwrState);
>> +               /* Set PM_PWSTCTRL_IVA2  to OFF */
>>                 HW_PWR_IVA2PowerStateSet(resources.dwPrmBase,
>>                                           HW_PWR_DOMAIN_DSP,
>>                                           HW_PWR_STATE_OFF); @@ 
>> -2054,8 +2050,7 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, u32 
>> cm_base,
>>         HW_PWRST_IVA2RegGet(prm_base, &temp);
>>          if ((temp & 0x03) != 0x03 || (temp & 0x03) != 0x02) {
>>                 /* IVA2 is not in ON state */
>> -               /* Read and set PM_PWSTCTRL_IVA2  to ON */
>> -               HW_PWR_IVA2StateGet(prm_base, HW_PWR_DOMAIN_DSP,
>> &pwrState);
>> +               /* Set PM_PWSTCTRL_IVA2  to ON */
>>                 HW_PWR_IVA2PowerStateSet(prm_base, HW_PWR_DOMAIN_DSP,
>>                                           HW_PWR_STATE_ON);
>>                 /* Set the SW supervised state transition */
 
> Here in one place ,you access prm base with resources.dwPrmBase and 
> next time access with just prm_base .Can we have have a consistent way 
> of accessing it ?

Both are in different functions WMD_BRD_Stop and run_IdleBoot.

Thanks
Ramesh Gupta G

