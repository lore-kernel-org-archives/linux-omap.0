From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-OPP][PATCH] OMAP: Modifying the frequency comparison logic.
Date: Tue, 24 Aug 2010 14:14:29 -0700
Message-ID: <87eidnogqy.fsf@deeprootsystems.com>
References: <1281758292-18895-1-git-send-email-thara@ti.com>
	<87occromt4.fsf@deeprootsystems.com>
	<7A436F7769CA33409C6B44B358BFFF0C014062250C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57838 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab0HXVOd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 17:14:33 -0400
Received: by iwn5 with SMTP id 5so4864246iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 14:14:32 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C014062250C@dlee02.ent.ti.com>
	(Nishanth Menon's message of "Tue, 24 Aug 2010 14:51:12 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

>> 
>> thara gopinath <thara@ti.com> writes:
>> 
>> > From: Thara Gopinath <thara@ti.com>
>> >
>> > In the current opp layer the frequency matching API's
>> > tries to match the exact frequency passed in Hz. This leads
>> > to problems in cases where dplls are locked to slightly differnet
>> > frequencies due to sys clock speed or optimum M,N values.
>> > Consider the following scenario
>> > 	a. dpll_x is supposed to be locked at 266Mhz but is
>> > 	   actually att 266.045 Mhz due to above mentioned reasons.
>> > 	b. The opp table has the entry as 266000000 hz.
>> > 	c. The user does a clk_get_rate(dpll_x) and passes the
>> > 	  corresponding rate <rate> into the opp API's to get back
>> > 	  a opp table entry.
>> > 	d. In this scenario if  the user has called into
>> > 	   opp_find_freq_exact it will return an error.
>> > 	   If the user has called into opp_find_freq_ceil
>> > 	   it will either return the opp entry corresponding
>> > 	   to the next higher frequency in the opp table
>> > 	   or return an error if 266 Mhz is the last entry
>> > 	   in the table.
>> >
>> > The above is not correct as we expect the framework to return back
>> > the opp table entry corresponding to 266 Mhz.
>> >
>> > Now there are two ways of fixing this issue.
>> > 	a. Put the correct dpll lock frequency in the opp table.
>> > 	   This means opp table will now have entries like 266045000 hz.
>> > 	   But this is not scalable as these dpll lock frequencies
>> > 	   can change slightly based on sys clk speeds. Like for eg
>> > 	   at sys clk speed 38.4 Mhz we will able to get 266.045 Mhz
>> > 	   where as at sys clk speed 26 Mhz we will be able to get
>> > 	   onyl 266.124 Mhz etc. So depending on the platform we
>> > 	   will have to start changing the opp table.
>> >
>> > 	b. Do the comparison in Mhz in the opp layer rather than in Hz.
>> > 	   This would mean we will divide the rate passed into the opp layer
>> > 	  API and the rates stored in the opp tables by 1000000 to get the
>> > 	  rates in Mhz and do the necessary comparision. In this approach
>> any
>> > 	  vague frequency like 266.045Mhz will get mapped to 266 Mhz in the
>> > 	  opp table. But if the passed rate is 267 Mhz, the opp framework
>> > 	  will still rerturn an error or the next highest opp table entry
>> >
>> > This patch implements solution b. The scenario mentioned above is
>> > esp true for OMAP4 dpll_iva where we do end up with such weird
>> frequencies
>> > due to sys clk being at 38.4 Mhz.
>> 
>> I agree that solution b is better, although it makes the '_exact'
>> function a bit less exact. :/
>> 
>> solution b is fine with me, but the kerneldoc for these find functions
>> should be updated to describe the new matching technique.
>
> I agree, I suggest one improvement though - the search accuracy will vary
> Based on the silicon rev, one size will probably not fit every silicon and
> Domains we have - I suggest having accuracy as a parameter as part of domain
> Registration/configurable parameter
> e.g.
>> > +			unsigned long rate = temp_opp->rate / 1000000;
> Will probably configurable to the "exactness" we expect to handle per domain/silicon family.
>

The more I think about, I think we should leave the 'exact' find the way
it is, especially as we move to device OPPs we will probably want to
have more precise matching.

What about adding another function that does a "find closest"?

Kevin
