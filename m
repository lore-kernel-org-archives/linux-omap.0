From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates for
 3.10
Date: Thu, 4 Apr 2013 22:27:52 +0530
Message-ID: <515DB110.9000503@ti.com>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com> <20130401170539.GK10155@atomide.com> <515BA76D.3000302@ti.com> <alpine.DEB.2.00.1304031146230.2616@utopia.booyaka.com> <515D6020.2030103@ti.com> <20130404165208.GI10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59741 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763193Ab3DDQzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 12:55:53 -0400
In-Reply-To: <20130404165208.GI10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Kristo, Tero" <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, "Anna, Suman" <s-anna@ti.com>

On Thursday 04 April 2013 10:22 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130404 04:15]:
>> + Tero and few more TI folks,
>>
>> On Thursday 04 April 2013 01:12 AM, Paul Walmsley wrote:
>>> Hi Santosh
>>>
>>> On Wed, 3 Apr 2013, Santosh Shilimkar wrote:
>>>
>>>> Thes patchset has already missed last couple of merge windows and its the
>>>> biggest bottleneck in getting OMAP5 booting from mainline. So I request
>>>> you to please have a look it quickly so that Tony can line that up for
>>>> 3.10.
>>>
>>> Looks like there are a few minor issues with the patches based on a quick 
>>> look.  I'll post those to the list shortly; they should be easy to fix.  
>>> But those issues aren't my real concern with this series.
>>>
>>> What's harder to fix are the underlying process issues.  My main concern 
>>> is that these patches add almost 9,000 lines of code and data.  We've 
>>> received clear guidance from the upstream ARM SoC maintainers that any 
>>> significant new additions need to be balanced with moving a similar number 
>>> of lines of code and data out of arch/arm/{plat-,mach-}* into drivers/.  
>>> (Or the new patches should be accompanied with patches that show obvious 
>>> progress towards the goal of moving code and data out of 
>>> arch/arm/{plat-,mach-}*.)  We need to see more help from TI on the 
>>> prerequisites for this cleanup process.
>>>
>> I agree that we are not making faster progress but as part of the
>> $subject series itself, for DT only build, we removed around ~4000
>> lines of data from hwmod. After the merge window, we can trim
>> the AM33XX and then later OMAP4 when it is made DT only support.
>> That should give us another 6000 lines of negative diff.
>> At the same time removal of MUX data for OMAP4 should be
>> around 2000 lines of negative diff.
> 
> Can't we already trim the am33xx hwmod data after your patches for
> v3.10 as am33xx is already DT only? Unfortunately we cannot create
> negative diffstat in other ways for v3.10 merge window as we cannot
> make omap4 DT only just quite yet.
> 
Yes we can and I can take a stab it tomorrow. The only thing is I
might need some support for testing but thats manageable. Will
take a stab at it tomorrow and if everything goes well, post a
patch for smae.

> FYI, I have some trivial patches here to drop board and mux support for
> omap4 once we can make omap4 DT only, so that will be about 3000 lines
> of reduction with estimated 1000 - 2000 lines once I go through the
> unneeded platform init code for omap4 for things like MMC and USB.
>  
Cool.

> The rest of the clean-up issues I believe we all agree, we just need
> to get it done so we can avoid getting flamed for every new SoC for
> the huge data files. To fix the data issue for good, it seems that we can
> get started moving both the clock and hwmod data to simple drivers
> that can get clocks and hwmod data both from DT and /lib/firmware.
> It also seems that we don't need to move all the data at once, which
> makes the task easier.
> 
Agree.


regards,
santosh

