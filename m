From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-OPP][PATCH 2/2] omap3: opp: make independent of cpufreq
Date: Thu, 12 Aug 2010 10:27:18 -0500
Message-ID: <4C6412D6.2080204@ti.com>
References: <1281493018-29294-1-git-send-email-nm@ti.com>	<1281493018-29294-3-git-send-email-nm@ti.com>	<5A47E75E594F054BAF48C5E4FC4B92AB0324110879@dbde02.ent.ti.com>	<4C627EDF.2000404@gmail.com>	<5A47E75E594F054BAF48C5E4FC4B92AB032411094B@dbde02.ent.ti.com>	<4C628BA6.6090507@ti.com>	<5A47E75E594F054BAF48C5E4FC4B92AB0324110E11@dbde02.ent.ti.com> <87iq3fucgb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33681 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664Ab0HLP1X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Aug 2010 11:27:23 -0400
In-Reply-To: <87iq3fucgb.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gopinath, Thara" <thara@ti.com>, Nishanth Menon <menon.nishanth@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>

Kevin Hilman had written, on 08/12/2010 09:34 AM, the following:
> "Gopinath, Thara" <thara@ti.com> writes:
> 
> [...]
> 
>>>>>>>> No reason why we should have a different file for OMAP4. So a better name than opp3xxx_data.c?
>>>>>>> why do we need to have it in the same file? Remember, 3630,3430 are
>>>>>>> under OMAP3 family, but omap4 is considered a different arch.
>>>>> Code is more or less the same. Is that not a sufficient reason to reuse a  file ?
>>>> I dont really care as long as opp layer is usable by mpurate without
>>>> depending on cpufreq and it is maintainable without going to if else
>>>> nightmare. But personally, I dont see really reusuable code in that file
>>>> (other than doing an opp addition in a loop) it could result eventually
>>>> in a large amount of code redundancy and maintenance nightmare with
>>>> OMAP4 variants coming in.
>> Why do you say maintenance nightmare? It is going to be one opp table
>> per SoC. Anyways, Kevin what is your take on this?
>>
> 
> I think we should keep separate files for each SoC listing the OPP data,
> and in those files should be *only* data.
> 
> The init functions across these files will be basically the same, so
> maybe the common code should be pulled out into a separate file (pm.c?),
> and the data files have a very simple init function (device_initcall) that just registers
> their data.
> 
yep, this sounds like a good idea, let me try something on this line and 
post a new rev..

-- 
Regards,
Nishanth Menon
