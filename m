From: ambresh <a0393775@ti.com>
Subject: Re: [PATCH v2 2/2] OMAP3630 SDRC: Change in DVFS Latency Formula
 for OMAP3630
Date: Tue, 23 Mar 2010 08:19:05 +0530
Message-ID: <4BA82C21.4010209@ti.com>
References: <1268888148-10983-1-git-send-email-pramod.gurav@ti.com> <1268888148-10983-2-git-send-email-pramod.gurav@ti.com> <1268888148-10983-3-git-send-email-pramod.gurav@ti.com> <4BA1D3A3.7090708@ti.com> <FCCFB4CDC6E5564B9182F639FC35608703045F2FF1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58853 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074Ab0CWCtU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Mar 2010 22:49:20 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2N2nHKr002988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 22 Mar 2010 21:49:19 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2N2nFxk023040
	for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 08:19:16 +0530 (IST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703045F2FF1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "K, Ambresh" <ambresh@ti.com>, "Gurav , Pramod" <pramod.gurav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sripathy, Vishwanath wrote:

>>>
>> -PFA,
>>
>> - Attached patch provides further optimized 3630 & 3430 path for
>> calculating M2 stablization delay.
>>
>> - The formula used to compute clkoutx2, is actually calculating for
>> clkoutm2x2 according to trm  clkoutx2 = (Fref * 2 * M)/ (N + 1).
>>   (Thanks to Eduardo for pointing this).
>>
> No, CLKOUTX2 is dependent on M2. Pls refer to table 3-45 (DPLL Operating Mode and Latency) in 3630 TRM Version D. 
> 

Yes! Stabilization delay for CLKOUTx2 is dependent on M2.

Confusion prevailed because of the section 3.5.3.3.3.1 where clkoutx2 is 
not dependent on M2 factor. And moreover the formula used to calculate 
clkoutx2 in this case looks like the one used for computing clkout_M2X2 :)

Thanks,
Ambresh
