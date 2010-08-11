From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-OPP][PATCH 2/2] omap3: opp: make independent of cpufreq
Date: Wed, 11 Aug 2010 06:38:14 -0500
Message-ID: <4C628BA6.6090507@ti.com>
References: <1281493018-29294-1-git-send-email-nm@ti.com> <1281493018-29294-3-git-send-email-nm@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0324110879@dbde02.ent.ti.com> <4C627EDF.2000404@gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB032411094B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35068 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab0HKLiU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Aug 2010 07:38:20 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032411094B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>

On 08/11/2010 06:23 AM, Gopinath, Thara wrote:
>
>
>>> -----Original Message-----
>>> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
>>> Sent: Wednesday, August 11, 2010 4:14 PM
>>> To: Gopinath, Thara
>>> Cc: Menon, Nishanth; linux-omap; Eduardo Valentin; Kevin Hilman; Paul Walmsley; Nayak, Rajendra;
>>> Premi, Sanjeev; Tony Lindgren
>>> Subject: Re: [PM-OPP][PATCH 2/2] omap3: opp: make independent of cpufreq
>>>
>>> On 08/11/2010 04:12 AM, Gopinath, Thara wrote:
>>>>
>>>>
>>>>>> -----Original Message-----
>>>>>> From: Menon, Nishanth
>>>>>> Sent: Wednesday, August 11, 2010 7:47 AM
>>>>>> To: linux-omap
>>>>>> Cc: Menon, Nishanth; Eduardo Valentin; Kevin Hilman; Paul Walmsley; Nayak, Rajendra; Premi,
>>> Sanjeev;
>>>>>> Gopinath, Thara; Tony Lindgren
>>>>>> Subject: [PM-OPP][PATCH 2/2] omap3: opp: make independent of cpufreq
>>>>>>
>>>>>> Make opp3xx data which is registered with the opp layer
>>>>>> dependent purely on CONFIG_PM as opp layer and pm.c users
>>>>>> are CONFIG_PM dependent not cpufreq dependent.
>>>>>> so we rename the data definition to opp3xxx_data.c (inline with what
>>>>>> we have for omap2), also move the build definition to be under
>>>>>> the existing CONFIG_PM build instead of CPUFREQ.
>>>>>>
>>>>>> Cc: Eduardo Valentin<eduardo.valentin@nokia.com>
>>>>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>>>>> Cc: Paul Walmsley<paul@pwsan.com>
>>>>>> Cc: Rajendra Nayak<rnayak@ti.com>
>>>>>> Cc: Sanjeev Premi<premi@ti.com>
>>>>>> Cc: Thara Gopinath<thara@ti.com>
>>>>>> Cc: Tony Lindgren<tony@atomide.com>
>>>>>>
>>>>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>>>>> ---
>>>>>> Note:
>>>>>> This takes care of the discussion on opp file renaming and making
>>>>>> it independent of cpufreq, unless I missed something else
>>>>>>
>>>>>> arch/arm/mach-omap2/Makefile                       |    5 +----
>>>>>> .../mach-omap2/{cpufreq34xx.c =>   opp3xxx_data.c}   |    0
>>>>>> 2 files changed, 1 insertions(+), 4 deletions(-)
>>>>>> rename arch/arm/mach-omap2/{cpufreq34xx.c =>   opp3xxx_data.c} (100%)
>>>>
>>>> Is this part of PM-OPP branch? Also I was thinking of reusing the same file for OMAP4.
>>> this defines the opp data base and would be part of pm-opp branch. the
>>> idea of rename was this:
>>> a) be clear that this is not dependent on cpufreq alone.
>
> I do not understand this. This files is not present in PM-OPP branch. But you have a patch modifying it against PM-OPP branch. Am I looking at a wrong version of PM-OPP branch?
you got me curious as well, my apologies, I had assumed things were how 
they were before :( Looks like Kevin shuffled things around and the data 
by itself is in cpufreq branch:
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=shortlog;h=refs/heads/pm-cpufreq

ergo, Kevin, do we need this cpufreq branch to contain the opp data:
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commitdiff;h=9f6847282f65cdcd26d740e6ae6afadc3ee00233
and related changes could potentially be pulled into the same pm-opp series?

>
>>> b) use the same convention in arch/arm/mach-omap2/ like omap2's opp data
>>> files which could be converted to use the opp layer now instead of
>>> having it's own opp layer. and maybe hopefully omap1 as well..
>>> c) when we do specific product build, it makes sense to have arch
>>> specific files as it makes not much reason to carry the omap4/2
>>> definitions(even if init_data).
>>>
>>>> No reason why we should have a different file for OMAP4. So a better name than opp3xxx_data.c?
>>> why do we need to have it in the same file? Remember, 3630,3430 are
>>> under OMAP3 family, but omap4 is considered a different arch.
>
> Code is more or less the same. Is that not a sufficient reason to reuse a  file ?
I dont really care as long as opp layer is usable by mpurate without 
depending on cpufreq and it is maintainable without going to if else 
nightmare. But personally, I dont see really reusuable code in that file 
(other than doing an opp addition in a loop) it could result eventually 
in a large amount of code redundancy and maintenance nightmare with 
OMAP4 variants coming in.

Regards,
Nishanth Menon
