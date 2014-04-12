From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/55]: ARM: OMAP2+: PRCM move to drivers
Date: Sat, 12 Apr 2014 13:21:32 +0300
Message-ID: <534913AC.8060402@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com> <20140331220903.GA11328@atomide.com> <533A7A23.8020606@ti.com> <20140401171325.GA28041@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43264 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027AbaDLKV6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Apr 2014 06:21:58 -0400
In-Reply-To: <20140401171325.GA28041@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 04/01/2014 08:13 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [140401 01:38]:
>> On 04/01/2014 01:09 AM, Tony Lindgren wrote:
>>>
>>> We don't want to make access to these registers available without
>>> proper frameworks as that will lead into misuse by various drivers.
>>> And cleaning up that mess later in is a huge pain.
>>
>> Currently, only thing that requires access to the register offsets
>> is basically all the legacy clock data still in the kernel (when can
>> we get rid of this, I have posted patches for it already?) and also
>> the clockdomain / powerdomain data. I can work on getting
>> clockdomain + powerdomain data to DT format if this would be
>> preferred, then we can remove these data files also. Alternatively I
>> can just move all these defines to the C files which actually use
>> them.
>
> With display support getting merged hopefully we can retry
> dropping omap3 legacy booting as long as we get the missing
> boards working.
>
> I don't know how urgent of an issue the clock and power domains
> are for the data compared to clocks and muxes. But if it allows us
> to easily add support for new SoC variants, then yes it makes sense.
>
> But in any case the defines should be private to the code claiming
> the PRCM register area.
>
>> So, basically you are proposing to add a regmap or regmap like API
>> for the PRCM, which would provide access to a subset of registers
>> only outside the PRCM driver? Some functions provided by PRCM spawn
>> to multiple registers (like clocks), and the ranges have holes, and
>> would require finetuning a register / bit level access map (some
>> registers may contain functions for several drivers.)
>
> Yeah something like that as that allows implementing the Linux
> generic frameworks where the code really should be. And does not
> require exporting tons of custom functions.
>
>>> 2. Have the core PRCM driver(s) claim some of the regmap ranges
>>>
>>> Some PRCM features can potentially be implemented using existing
>>> Linux generic frameworks where possible for clocks, regulators, reset
>>> drivers etc. That way you can keep the register defines for these
>>> ranges private to the core PRCM driver(s). Ideally with no need
>>> to add _any_ custom exported functions here.
>>
>> There is separate work ongoing for reset driver, and for VC/VP,
>> there has been some regulator related work. But yes, mostly this
>> approach should be fine.
>
> OK cool.
>
>>> 3. Have the other drivers claim some regmap ranges
>>>
>>> The register ranges that are clearly owned by some driver should
>>> be claimed by those drivers. Then the defines for those registers
>>> can stay private to that driver. Some drivers that can probably
>>> own some PRCM ranges are clock drivers and voltage related drivers.
>>
>> Yeah, this sounds reasonable.

Hi all,

Just letting you know, that I created a kind of v2 for this set, however 
I am not going to post it publicly before the pre-reqs for this set are 
covered, basically the OMAP2 clock DT set. CM/PRM cleanup set is 
outdated with this series though (I'll post a note on it separately) and 
its contents are merged to this latest re-work.

The latest wip branch is available publicly if someone is interested:

https://github.com/t-kristo/linux-pm/tree/3.14-rc4-cm-prm-driver-wip

I also added Tony's vc fixes set to this branch and removed the direct 
prm register accesses added there.

-Tero

