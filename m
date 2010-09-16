From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-OPP][PATCH] OMAP: Modifying the frequency comparison logic.
Date: Thu, 16 Sep 2010 16:35:04 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0329442525@dbde02.ent.ti.com>
References: <1281758292-18895-1-git-send-email-thara@ti.com>
	<87occromt4.fsf@deeprootsystems.com>
	<7A436F7769CA33409C6B44B358BFFF0C014062250C@dlee02.ent.ti.com>
	<87eidnogqy.fsf@deeprootsystems.com>
	<7A436F7769CA33409C6B44B358BFFF0C01406226EA@dlee02.ent.ti.com>
 <87fwy2b9ir.fsf@deeprootsystems.com>
 <7A436F7769CA33409C6B44B358BFFF0C0140B00512@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37232 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab0IPLFL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 07:05:11 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C0140B00512@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Thursday, August 26, 2010 6:00 AM
>>To: Kevin Hilman
>>Cc: Gopinath, Thara; linux-omap@vger.kernel.org
>>Subject: RE: [PM-OPP][PATCH] OMAP: Modifying the frequency comparison logic.
>>
>>> -----Original Message-----
>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>> Sent: Wednesday, August 25, 2010 5:41 PM
>>> To: Menon, Nishanth
>>> Cc: Gopinath, Thara; linux-omap@vger.kernel.org
>>> Subject: Re: [PM-OPP][PATCH] OMAP: Modifying the frequency comparison
>>> logic.
>>>
>>> "Menon, Nishanth" <nm@ti.com> writes:
>>>
>>> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>> >> Sent: Tuesday, August 24, 2010 4:14 PM
>>> >
>>> >
>>> >>
>>> >> "Menon, Nishanth" <nm@ti.com> writes:
>>> >>
>>> >> >>
>>> >> >> thara gopinath <thara@ti.com> writes:
>>> >> >>
>>> >> >> > From: Thara Gopinath <thara@ti.com>
>>> >> >> >
>>> >
>>> > [...]
>>> >> >> >
>>> >> >> > The above is not correct as we expect the framework to return back
>>> >> >> > the opp table entry corresponding to 266 Mhz.
>>> >> >> >
>>> >
>>> > [...]
>>> >> >> >
>>> >> >> > 	b. Do the comparison in Mhz in the opp layer rather than in Hz.
>>> >> >> > 	   This would mean we will divide the rate passed into the opp
>>> layer
>>> >> >> > 	  API and the rates stored in the opp tables by 1000000 to get
>>> the
>>> >> >> > 	  rates in Mhz and do the necessary comparision. In this
>>> approach
>>> >> >> any
>>> >> >> > 	  vague frequency like 266.045Mhz will get mapped to 266 Mhz
>>> in the
>>> >> >> > 	  opp table. But if the passed rate is 267 Mhz, the opp
>>> framework
>>> >> >> > 	  will still rerturn an error or the next highest opp table
>>> entry
>>> >> >> >
>>> >> >> > This patch implements solution b. The scenario mentioned above is
>>> >> >> > esp true for OMAP4 dpll_iva where we do end up with such weird
>>> >> >> frequencies
>>> >> >> > due to sys clk being at 38.4 Mhz.
>>> >> >>
>>> >> >> I agree that solution b is better, although it makes the '_exact'
>>> >> >> function a bit less exact. :/
>>> >> >>
>>> >> >> solution b is fine with me, but the kerneldoc for these find
>>> functions
>>> >> >> should be updated to describe the new matching technique.
>>> >> >
>>> >> > I agree, I suggest one improvement though - the search accuracy will
>>> >> vary
>>> >> > Based on the silicon rev, one size will probably not fit every
>>> silicon
>>> >> and
>>> >> > Domains we have - I suggest having accuracy as a parameter as part of
>>> >> domain
>>> >> > Registration/configurable parameter
>>> >> > e.g.
>>> >> >> > +			unsigned long rate = temp_opp->rate / 1000000;
>>> >> > Will probably configurable to the "exactness" we expect to handle per
>>> >> domain/silicon family.
>>> >> >
>>> >>
>>> >> The more I think about, I think we should leave the 'exact' find the
>>> way
>>> >> it is, especially as we move to device OPPs we will probably want to
>>> >> have more precise matching.
>>> >>
>>> >> What about adding another function that does a "find closest"?
>>>
>>> > Just my 2cents: With accuracy as a param?
>>>
>>> Why would you need accuracy for "find closest"?
>>>
>>How close should "closest" be? There has to be a parameter for this -
>>something like as close as 10Mhz,  but beyond the match fails.
>>Currently this patch introduces a hardcoded accuracy which could be
>>Carried forward.
>>
>>But, On different silicon the deltas due to sysclk can vary - there is no
>>silver  bullet algo we can write which will be accurate for all silicon and
>>domain  combination..
>>
>>
>>Further, is'nt ceil and floor functions we have a more specific
>>Implementation of "closest"? in the sense, it says closest to which
>>Direction - up or down..
>>
>>[...]
>>Rest of the discussion seems aligned.

Hello Kevin,

I am not sure about the conclusion of this discussion.
For me we should avoid putting possible weird frequencies
like 266789501.. Hence the round off to /10^6. If on some platforms
due to sys clk we have frequency 267 instead of 266, I would prefer to
edit the opp table through the opp framework APIs. This is my opinion.
I may not have fully understood the concerns discussed in this forum.

Regards
Thara

