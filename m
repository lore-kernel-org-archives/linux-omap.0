From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Dropping omap3430 ES1.0 support in mainline
Date: Mon, 4 Oct 2010 11:37:42 +0200
Message-ID: <4CA9A066.4050107@ti.com>
References: <d0443bbf588bf1e8a7efbd0014816753@mail.gmail.com> <alpine.DEB.2.00.1010011558290.22941@utopia.booyaka.com> <3700cfbb0159d56cecbda0e06a2957e3@mail.gmail.com> <alpine.DEB.2.00.1010011615560.22941@utopia.booyaka.com> <cf484f0b347742791af6d563efefaeb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59993 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333Ab0JDJhr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Oct 2010 05:37:47 -0400
In-Reply-To: <cf484f0b347742791af6d563efefaeb4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 10/2/2010 12:28 AM, Anand Gadiyar wrote:
> Paul Walmsley wrote:
>> On Sat, 2 Oct 2010, Anand Gadiyar wrote:
>>
>>> Okay, so we're aligned that you guys don't have an ES1 board to test,
>>> and TI doesn't have any either. :)
>>>
>>> I'd still like to know if anyone in the wild still cares about the
> board.
>>>
>>> (I see Tony already said "No thanks", but I'd like to know anyway).
>>
>> Why would we want to remove support for a board that should work fine
> with
>> linux-omap and isn't causing any problems with existing code?
>
> I'm not sure it works fine, and if there are no users that care about
> the board, then it would be nice to drop the support. If the board
> works fine today, that's good, but has anyone tested the current
> kernel on that board?
>
> (we're struggling to keep linux-omap working on boards available now,
> why support something that nobody cares about. It's not like I'm asking
> 3430 support to be dropped)
>
> - the ES1 chip has never been available to the outside world beyond
> sampling quantities
> - no new developments are likely to happen on that board
> - nobody's likely to have one of these around and care to boot it up
> - there are plenty of replacements like the beagles which are lower
>    cost, easier to obtain, and can beat an ES1 in speed
>
> I'm okay having support for the board if someone's actually using it.
> It's not such a big deal. It was just a thought - it came up because
> Manju was looking at old errata docs, and came across something that
> was specific to an ES1, but we realized there was no way to test it.

If this is the SDMA bug we are talking about, it was unfortunately 
already there in OMAP2420. For some reason I didn't find it in 2430 
errata, but since it was still there in 3430 ES1, we can assume that 
2430 also has the issue.


That being said, ES1 devices for both OMAP3 and OMAP4 were supposed to 
be engineering samples.
There is no product out there with OMAP3 ES1, and same thing is 
happening with 4430 ES1.

So, it makes sense to keep supporting them during the transition, but as 
soon as everybody is upgraded to the next production version, what the 
point to keep maintaining these buggy devices?
Hopefully the auto-destroy mode after 2 years seems to work fine :-)

Regards,
Benoit


