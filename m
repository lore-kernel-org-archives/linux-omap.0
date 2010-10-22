From: Nishanth Menon <nm@ti.com>
Subject: Re: hwmod and insertable modules
Date: Fri, 22 Oct 2010 05:26:14 -0500
Message-ID: <4CC166C6.7060403@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593023458C204@dbde02.ent.ti.com> <0680EC522D0CC943BC586913CF3768C003FF2DAF8D@dbde02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB593023458C250@dbde02.ent.ti.com> <4CC15CC3.7060406@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593023458C2BE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43696 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab0JVK0P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Oct 2010 06:26:15 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9MAQENA004444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 05:26:15 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id o9MAQEpq001755
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 05:26:14 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o9MAQEdo012905
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 05:26:14 -0500 (CDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593023458C2BE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev had written, on 10/22/2010 05:01 AM, the following:

>>>>> During module_init I used omap_device_build() to create the 
>>>> omap_device.
>>>>> But when trying to implement the module_exit, I couldn't find the
>>>>> corresponding 'destructor'.
>>>> omap_device_build essentially does  a platform_device 
>> register today
>>>> and hence its not something to be done from a insmod'able 'driver'.
>>> [sp] How does this work for - say dspbridge - where the DSP 
>> as device
>>> may not be 'registered' until it is really expected to be used?
>>>
>> arch/arm/mach-omap2/dspbridge.c? ;)
> 
> Which repo? On the dspbridge branch on linux-omap, there is not such
:) it is not there as dspbridge is in staging at the moment - I believe 
there is some sort of rule of not depending on staging drivers or 
something like that.. but the point I was attempting to make is backing 
Rajendra's statement -> split your driver into silicon specific data and 
silicon independent driver -> the silicon dependent data (like hwmod) 
can be collected by a file located in arch/arm/mach-omap2 -> pass the 
data as platform_data(with stuff like baseaddress etc..) to the driver 
and things can happily function.. Would suggest posting out a RFC patch 
if you'd like better ideas from the community I guess.

-- 
Regards,
Nishanth Menon
