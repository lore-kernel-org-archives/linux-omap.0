From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates for
 3.10
Date: Wed, 29 May 2013 12:41:47 -0400
Message-ID: <51A62FCB.601@ti.com>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com> <20130401170539.GK10155@atomide.com> <515BA76D.3000302@ti.com> <alpine.DEB.2.00.1304031146230.2616@utopia.booyaka.com> <515D6020.2030103@ti.com> <20130404165208.GI10155@atomide.com> <515DB110.9000503@ti.com> <515F00B8.3000501@ti.com> <5195E380.4040103@ti.com> <20130517172231.GW5600@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38902 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757683Ab3E2QmL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 May 2013 12:42:11 -0400
In-Reply-To: <20130517172231.GW5600@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Kristo, Tero" <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, "Anna, Suman" <s-anna@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On Friday 17 May 2013 01:22 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130517 01:02]:
>> Paul, Tony,
>>
>> On Friday 05 April 2013 10:20 PM, Santosh Shilimkar wrote:
>>> On Thursday 04 April 2013 10:27 PM, Santosh Shilimkar wrote:
>>>> On Thursday 04 April 2013 10:22 PM, Tony Lindgren wrote:
>>>>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130404 04:15]:
>>> [..]
>>>
>>>>> Can't we already trim the am33xx hwmod data after your patches for
>>>>> v3.10 as am33xx is already DT only? Unfortunately we cannot create
>>>>> negative diffstat in other ways for v3.10 merge window as we cannot
>>>>> make omap4 DT only just quite yet.
>>>>>
>>>> Yes we can and I can take a stab it tomorrow. The only thing is I
>>>> might need some support for testing but thats manageable. Will
>>>> take a stab at it tomorrow and if everything goes well, post a
>>>> patch for smae.
>>>>
>>> Patch for the AM33XX to trim is end of the email. Thanks to
>>> Sricharan and Pekon for patch and testing. Looping both
>>> Vaibhav's if they have any objection on the patch.
>>>
>>> Regards,
>>> Santosh
>>>
>>> From b95dd33fe59b8e77727eb3b1717d763bbf9a2893 Mon Sep 17 00:00:00 2001
>>> From: Sricharan R <r.sricharan@ti.com>
>>> Date: Fri, 5 Apr 2013 20:39:12 +0530
>>> Subject: [PATCH] ARM: AM33XX: hwmod data: Clean up the data file
>>>
>> For whatever reason, we again missed the merge window for the subject
>> series, I would like to know your plan on the subject series for
>> at least 3.11. Asking *well in advance* to avoid late merge related
>> discussions.
> 
> Yes, I think we should have now a omap5 hwmod data sized hole coming
> up with conversion of omap4 to be DT only. I'll post those patches
> today for the board file and legacy mux removal for omap4:
> 
> 12 files changed, 52 insertions(+), 3260 deletions(-)
> 
Cool.

> Those coupled with your am33xx hwmod cleanup patch and your omap4
> hwmod cleanup patch should allow us having the omap5 hwmod data
> without making the diffstats look too bad.
>  
>> Thanks to Vaibhav, AM33XX patch is tested and validated with some
>> updates considering upcoming PM support for AM33XX. So that
>> patch will be included in the series.
>>
>> Rajendra will follow up the patchset if there is some re-basing is
>> needed since I will away for few weeks because of travel. 
> 
> OK, well the omap4 hwmod clean-up patch depends on first dropping
> the above mentioned omap4 legacy files.
>  
Have posted the series which includes AM33XX and OMAP4 data
reduction patch as well.

regards,
Santosh

