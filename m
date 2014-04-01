From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/55]: ARM: OMAP2+: PRCM move to drivers
Date: Tue, 1 Apr 2014 11:34:43 +0300
Message-ID: <533A7A23.8020606@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com> <20140331220903.GA11328@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42104 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbaDAIfM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Apr 2014 04:35:12 -0400
In-Reply-To: <20140331220903.GA11328@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 04/01/2014 01:09 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [140331 08:20]:
>> Hi,
>>
>> This set is continuation for the work started earlier to cleanup the CM/PRM
>> and attempt to make it a separate driver. This set depends on these
>> two sets:
>>
>> CM/PRM cleanup set:
>> http://marc.info/?l=linux-omap&m=139395000918201&w=2
>>
>> OMAP2 clock DT set:
>> http://comments.gmane.org/gmane.linux.ports.arm.omap/111257
>>
>> This set is pretty huge but the patches can be applied in stages if need be.
>> Anyway, it would be good to get some feedback whether the driver folder
>> locations etc. are good, and whether the effort taken here will be enough
>> to actually move the driver. Clockdomain / powerdomain code can also be
>> moved easily under the drivers/power/omap folder (or someplace else if
>> requested) once this set is in. Also, clockdomain / powerdomain data
>> should be possible to convert to DT format or some sort of firmware
>> blob once this is done.
>
> Good to see this happening :)
>
>> Patch #55 in this set is pretty massive as it moves all the C files at
>> the same time, this should probably be split up as multiple patches.
>
> Maybe try to break this series into few smaller sets of patches?

Yes, this was the idea once getting the initial feedback for the 
approach itself. I will post smaller sets (split from this one) once the 
CM/PRM cleanup set referenced above gets in.

>
> Then a diffstat with these kind of large patch sets would be nice
> in the cover letter to get some kind of idea what's going on :)
>
> Browsing through the set it seems that all the patches in this
> series moving register defines "to a public location" are bad news.
>
> We don't want to make access to these registers available without
> proper frameworks as that will lead into misuse by various drivers.
> And cleaning up that mess later in is a huge pain.

Currently, only thing that requires access to the register offsets is 
basically all the legacy clock data still in the kernel (when can we get 
rid of this, I have posted patches for it already?) and also the 
clockdomain / powerdomain data. I can work on getting clockdomain + 
powerdomain data to DT format if this would be preferred, then we can 
remove these data files also. Alternatively I can just move all these 
defines to the C files which actually use them.

>
> To avoid that, you can probably do something like this:
>
> 1. Set up the PRCM registers as multiple regmap areas
>
> See for example these commits in linux next how one of the SCM misc
> register areas is now available for drivers as tisyscon defined
> in the .dts files:
>
> 11469e0bb1c5 regulator: add pbias regulator support
> cd042fe5c1f6 ARM: dts: add pbias dt node
>
> So basically we now have drivers/regulators/pbias-regulator.c
> that claims some of the tisyscon registers and implements a
> regulator. Then the MMC driver can just use the standard regulator
> related functions.
>
> It seems that you can set up multiple PRCM register ranges in a
> similar way as regmap ranges and that way partition the PRCM
> register areas to something that's private to individual drivers.

So, basically you are proposing to add a regmap or regmap like API for 
the PRCM, which would provide access to a subset of registers only 
outside the PRCM driver? Some functions provided by PRCM spawn to 
multiple registers (like clocks), and the ranges have holes, and would 
require finetuning a register / bit level access map (some registers may 
contain functions for several drivers.)

> 2. Have the core PRCM driver(s) claim some of the regmap ranges
>
> Some PRCM features can potentially be implemented using existing
> Linux generic frameworks where possible for clocks, regulators, reset
> drivers etc. That way you can keep the register defines for these
> ranges private to the core PRCM driver(s). Ideally with no need
> to add _any_ custom exported functions here.

There is separate work ongoing for reset driver, and for VC/VP, there 
has been some regulator related work. But yes, mostly this approach 
should be fine.

> 3. Have the other drivers claim some regmap ranges
>
> The register ranges that are clearly owned by some driver should
> be claimed by those drivers. Then the defines for those registers
> can stay private to that driver. Some drivers that can probably
> own some PRCM ranges are clock drivers and voltage related drivers.

Yeah, this sounds reasonable.

-Tero
