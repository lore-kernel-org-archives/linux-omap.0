From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 3/6] omap3: pm: Update Triton2 scripts
Date: Thu, 21 Jan 2010 02:42:29 -0600
Message-ID: <4B581375.6050103@ti.com>
References: <1263922556-13806-1-git-send-email-x0080970@ti.com> <4B5802BE.2070401@ti.com> <028101ca9a74$d6588610$LocalHost@wipultra1385>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52690 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447Ab0AUImd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jan 2010 03:42:33 -0500
In-Reply-To: <028101ca9a74$d6588610$LocalHost@wipultra1385>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Manuel, Lesly Arackal" <x0080970@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Derrick, David" <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Manuel, Lesly Arackal had written, on 01/21/2010 02:34 AM, the following:
> From: "Nishanth Menon" <nm@ti.com>
> To: "Manuel, Lesly Arackal" <x0080970@ti.com>
> Cc: <linux-omap@vger.kernel.org>; "Derrick, David" <dderrick@ti.com>; 
> 
> 
>> Manuel, Lesly Arackal had written, on 01/19/2010 11:35 AM, the following:
>>> From: Lesly A M <x0080970@ti.com>
>>>
>>> omap3: pm: Update Triton2 scripts
>>>
>>> Updated the sleep, wakeup & warm_reset sequence as recommended by David 
>>> Derrick.
>>> Used broadcast command, modified the resource type association and remap 
>>> sleep_state.
>>> Added the new script changes for zoom[2,3] boards.
>>>
>>> VDD1, VDD2 and VPLL1 are remapped to turn off during sleep state.
>>> Changed RES_TYPE2 of VPLL1, VDD1, VDD2, REGEN, NRESPWRON & SYSEN to '1'
>>> and VINTANA1, VINTANA2, VINTDIG, VIO, CLKEN & HFCLKOUT to '2'.
>> How about VMMC,VAUX and other resources?
>>
> These LDOs are controlled by drivers using regulator frame work, not through 
> TRITON power sequence.
Context of my question was - how do we handle devices such as eMMC which 
is required on bootup? I suppose the suspend/resume of those driver 
should ideally handle it..

but overall fair enough from me, if relevant comments are available in 
commit message.

[..]

-- 
Regards,
Nishanth Menon
