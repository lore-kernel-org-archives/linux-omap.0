From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-OPP][PATCH 2/2] omap3: opp: make independent of cpufreq
Date: Wed, 11 Aug 2010 16:53:36 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032411094B@dbde02.ent.ti.com>
References: <1281493018-29294-1-git-send-email-nm@ti.com>
 <1281493018-29294-3-git-send-email-nm@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324110879@dbde02.ent.ti.com>
 <4C627EDF.2000404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54568 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab0HKLXz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 07:23:55 -0400
In-Reply-To: <4C627EDF.2000404@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>



>>-----Original Message-----
>>From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
>>Sent: Wednesday, August 11, 2010 4:14 PM
>>To: Gopinath, Thara
>>Cc: Menon, Nishanth; linux-omap; Eduardo Valentin; Kevin Hilman; Paul Walmsley; Nayak, Rajendra;
>>Premi, Sanjeev; Tony Lindgren
>>Subject: Re: [PM-OPP][PATCH 2/2] omap3: opp: make independent of cpufreq
>>
>>On 08/11/2010 04:12 AM, Gopinath, Thara wrote:
>>>
>>>
>>>>> -----Original Message-----
>>>>> From: Menon, Nishanth
>>>>> Sent: Wednesday, August 11, 2010 7:47 AM
>>>>> To: linux-omap
>>>>> Cc: Menon, Nishanth; Eduardo Valentin; Kevin Hilman; Paul Walmsley; Nayak, Rajendra; Premi,
>>Sanjeev;
>>>>> Gopinath, Thara; Tony Lindgren
>>>>> Subject: [PM-OPP][PATCH 2/2] omap3: opp: make independent of cpufreq
>>>>>
>>>>> Make opp3xx data which is registered with the opp layer
>>>>> dependent purely on CONFIG_PM as opp layer and pm.c users
>>>>> are CONFIG_PM dependent not cpufreq dependent.
>>>>> so we rename the data definition to opp3xxx_data.c (inline with what
>>>>> we have for omap2), also move the build definition to be under
>>>>> the existing CONFIG_PM build instead of CPUFREQ.
>>>>>
>>>>> Cc: Eduardo Valentin<eduardo.valentin@nokia.com>
>>>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>>>> Cc: Paul Walmsley<paul@pwsan.com>
>>>>> Cc: Rajendra Nayak<rnayak@ti.com>
>>>>> Cc: Sanjeev Premi<premi@ti.com>
>>>>> Cc: Thara Gopinath<thara@ti.com>
>>>>> Cc: Tony Lindgren<tony@atomide.com>
>>>>>
>>>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>>>> ---
>>>>> Note:
>>>>> This takes care of the discussion on opp file renaming and making
>>>>> it independent of cpufreq, unless I missed something else
>>>>>
>>>>> arch/arm/mach-omap2/Makefile                       |    5 +----
>>>>> .../mach-omap2/{cpufreq34xx.c =>  opp3xxx_data.c}   |    0
>>>>> 2 files changed, 1 insertions(+), 4 deletions(-)
>>>>> rename arch/arm/mach-omap2/{cpufreq34xx.c =>  opp3xxx_data.c} (100%)
>>>
>>> Is this part of PM-OPP branch? Also I was thinking of reusing the same file for OMAP4.
>>this defines the opp data base and would be part of pm-opp branch. the
>>idea of rename was this:
>>a) be clear that this is not dependent on cpufreq alone.

I do not understand this. This files is not present in PM-OPP branch. But you have a patch modifying it against PM-OPP branch. Am I looking at a wrong version of PM-OPP branch?

>>b) use the same convention in arch/arm/mach-omap2/ like omap2's opp data
>>files which could be converted to use the opp layer now instead of
>>having it's own opp layer. and maybe hopefully omap1 as well..
>>c) when we do specific product build, it makes sense to have arch
>>specific files as it makes not much reason to carry the omap4/2
>>definitions(even if init_data).
>>
>>> No reason why we should have a different file for OMAP4. So a better name than opp3xxx_data.c?
>>why do we need to have it in the same file? Remember, 3630,3430 are
>>under OMAP3 family, but omap4 is considered a different arch.

Code is more or less the same. Is that not a sufficient reason to reuse a  file ?
>>
>>Regards,
>>Nishanth Menon
>>[...]
