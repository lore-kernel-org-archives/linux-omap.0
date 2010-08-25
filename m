From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-OPP][PATCH] OMAP: Modifying the frequency comparison logic.
Date: Wed, 25 Aug 2010 15:41:16 -0700
Message-ID: <87fwy2b9ir.fsf@deeprootsystems.com>
References: <1281758292-18895-1-git-send-email-thara@ti.com>
	<87occromt4.fsf@deeprootsystems.com>
	<7A436F7769CA33409C6B44B358BFFF0C014062250C@dlee02.ent.ti.com>
	<87eidnogqy.fsf@deeprootsystems.com>
	<7A436F7769CA33409C6B44B358BFFF0C01406226EA@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64754 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab0HYWlT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 18:41:19 -0400
Received: by pwi7 with SMTP id 7so477560pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 15:41:18 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C01406226EA@dlee02.ent.ti.com>
	(Nishanth Menon's message of "Tue, 24 Aug 2010 16:50:59 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Tuesday, August 24, 2010 4:14 PM
>
>
>> 
>> "Menon, Nishanth" <nm@ti.com> writes:
>> 
>> >>
>> >> thara gopinath <thara@ti.com> writes:
>> >>
>> >> > From: Thara Gopinath <thara@ti.com>
>> >> >
>
> [...]
>> >> >
>> >> > The above is not correct as we expect the framework to return back
>> >> > the opp table entry corresponding to 266 Mhz.
>> >> >
>
> [...]
>> >> >
>> >> > 	b. Do the comparison in Mhz in the opp layer rather than in Hz.
>> >> > 	   This would mean we will divide the rate passed into the opp layer
>> >> > 	  API and the rates stored in the opp tables by 1000000 to get the
>> >> > 	  rates in Mhz and do the necessary comparision. In this approach
>> >> any
>> >> > 	  vague frequency like 266.045Mhz will get mapped to 266 Mhz in the
>> >> > 	  opp table. But if the passed rate is 267 Mhz, the opp framework
>> >> > 	  will still rerturn an error or the next highest opp table entry
>> >> >
>> >> > This patch implements solution b. The scenario mentioned above is
>> >> > esp true for OMAP4 dpll_iva where we do end up with such weird
>> >> frequencies
>> >> > due to sys clk being at 38.4 Mhz.
>> >>
>> >> I agree that solution b is better, although it makes the '_exact'
>> >> function a bit less exact. :/
>> >>
>> >> solution b is fine with me, but the kerneldoc for these find functions
>> >> should be updated to describe the new matching technique.
>> >
>> > I agree, I suggest one improvement though - the search accuracy will
>> vary
>> > Based on the silicon rev, one size will probably not fit every silicon
>> and
>> > Domains we have - I suggest having accuracy as a parameter as part of
>> domain
>> > Registration/configurable parameter
>> > e.g.
>> >> > +			unsigned long rate = temp_opp->rate / 1000000;
>> > Will probably configurable to the "exactness" we expect to handle per
>> domain/silicon family.
>> >
>> 
>> The more I think about, I think we should leave the 'exact' find the way
>> it is, especially as we move to device OPPs we will probably want to
>> have more precise matching.
>> 
>> What about adding another function that does a "find closest"?

> Just my 2cents: With accuracy as a param? 

Why would you need accuracy for "find closest"?

> Then we fall back to the question - who would be the users of the
> "_ceil, _floor" functions?  Probably exact might should mean exact,
> and ceil and floor should be using as they were originally intended..

Yeah, I'm thinking so too.

> But, the real users of ceil and floor are guys from cpufreq and frequency
> searchers - they don't really want to know the minor deltas b/w 19.2MHz Vs
> 26MHz Vs 38.4MHz sysclk variations caused to precise clock definitions..
> They like to do ciel(1Ghz) and get opp corresponding to 1Ghz if 19.2Mhz 
> sysclk causes this to be 999,999Mhz it will fail in the current logic..

Yes, that's why I proposed "closest".

> Also, we would like to users of these apis to remain consistent and not
> Know about the variation of freq deltas. E.g.:
> Omapx 12MHz to 38.4Mhz causes fluctuations around 100Mhz
> OMAPy  19.2MHz to 38.4Mhz causes fluctuations around 10Mhz
> The caller should not do:
> If cpu_is_omapx()
> 	Find_closest_ciel(freq,100)
> Else if cpu_is_omapy()
> 	Find_closest_ciel(freq,10)
>
> That'd be nightmare..

Agreed.

Kevin

> Instead as part of cpu domain registration, we mention what is the accuracy
> And the callers do find_ciel(freq) and that will "automagically" translate
> To accuracy needed for that silicon on that domain..


