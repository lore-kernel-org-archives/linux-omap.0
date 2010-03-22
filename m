From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv2 00/17] OMAP3: PM: Smartreflex and voltage revamp.
Date: Mon, 22 Mar 2010 11:54:07 -0500
Message-ID: <4BA7A0AF.20808@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>	<4BA27BCC.60404@ti.com>	<5A47E75E594F054BAF48C5E4FC4B92AB03220FBFA5@dbde02.ent.ti.com>	<4BA78F95.8020700@ti.com> <87y6hkjo73.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33955 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755283Ab0CVQyJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Mar 2010 12:54:09 -0400
In-Reply-To: <87y6hkjo73.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

Kevin Hilman had written, on 03/22/2010 11:50 AM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Gopinath, Thara had written, on 03/22/2010 09:39 AM, the following:
>>>>> Gopinath, Thara had written, on 03/18/2010 04:15 AM, the following:
>>>>> [..]
>>>>>
>>>>>> This patch series is based on Kevin's PM tree origin/pm-wip-opp branch
>>>>>> and is dependent on the following patches not yet applied onto this branch.
>>>>>>
>>>>>> 	http://patchwork.kernel.org/patch/81504/
>>>>>> 	http://patchwork.kernel.org/patch/81606/
>>>>> The 2nd patch does not seem to apply anymore
>>>>>
>>>>> see [1] - no more sysc_flags as it was queued to .34-rcX?
>>> I do not understand this.. Second patch seems to apply for me on wip-opp branch off Kevin's tree
>> did you check the link i posted below? this is from pm-wip-opp branch
>> and it does not seem to have the sysc_flags in it.. 
> 
> I think you're looking at an old pm-wip-opp branch.  The 2nd patch
> applies to current pm-wip-opp (albiet with some fuzz)
> 
> Kevin
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
4 days ago 	pm-wip-opp 	shortlog | log | tree
Ref[1]
Aaah.. indeed.. my apologies.

-- 
Regards,
Nishanth Menon
[1]:
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=blob;f=arch/arm/plat-omap/include/plat/omap_hwmod.h;h=440b4164f2f65e8557713ce9fff2636ed02fe523;hb=pm-wip-opp#l293
