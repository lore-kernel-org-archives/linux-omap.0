From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 05/43] CLK: TI: add DT alias clock registration mechanism
Date: Thu, 31 Oct 2013 11:18:03 +0200
Message-ID: <5272204B.2030106@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>	<1382716658-6964-6-git-send-email-t-kristo@ti.com>	<CAHCPf3uPhkVhdn3Db06YZfrwQuA7khdZEXiZ+pqJ06J9YdBoLg@mail.gmail.com>	<5270C368.9000701@ti.com> <CAHCPf3vcdriV3n2BvG2+saJFH6hR_gEFU=BhTBa0yqZUUWcg1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34648 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab3JaJSe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Oct 2013 05:18:34 -0400
In-Reply-To: <CAHCPf3vcdriV3n2BvG2+saJFH6hR_gEFU=BhTBa0yqZUUWcg1A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Sealey <neko@bakuhatsu.net>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Benoit Cousson <bcousson@baylibre.com>, rnayak@ti.com, Mike Turquette <mturquette@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 10/30/2013 07:38 PM, Matt Sealey wrote:
> On Wed, Oct 30, 2013 at 3:29 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> On 10/29/2013 07:50 PM, Matt Sealey wrote:
>>>
>>> I have one question here, what makes this part of the patch
>>> TI-specific at all except the definition of the structure ti_dt_clk?
>>> Mapping DT clocks to generic clkdev legacy namings seems like it would
>>> be a necessary evil across *all* SoC platforms.
>>>
>>> I would say there is a good case for this being generic
>>
>> An earlier implementation of this patch (or at least a patch that tries to
>> accomplish the same as this does, add support for legacy devices) did try to
>> add generic solution. There was some discussion on it and I decided to drop
>> it due to bad feedback.
>>
>> See: http://www.spinics.net/lists/linux-omap/msg95147.html
>
> I don't see anything that says this should not be generic, just that
> it was implemented relatively poorly at the time...
>
> I agree with Tomasz, find_by_name in device trees is basically evil
> (it's only supposed to be used if you already know the name because
> something else passed it to you, and just want it's phandle, but names
> CAN be ambiguous. The real fix is always pass phandles and not strings
> of the name property), but that's not to say this thing needs to be
> TI-specific..
>
> Ah well. If it ends up getting used elsewhere, it can be quickly
> patched into a generic version anyway, so.. yay!

Yeah, this can be converted to generic version easily if need be. The 
thing with this patch is also that it is kind of temporary solution, it 
should not be needed anymore once all the drivers are converted to DT.

>
> I'm really interested in this all going in - but I would love to see
> where this is just all patched into a tree already. Pulling things out
> against a bunch of trees gave me more merge failures and weird
> happenings than I care to deal with. Is there a TI clock development
> tree with all this in somewhere publically accessible? I'd like to get
> a feel for how the DT looks and what's going on, I can't "see" it from
> the patches. Once it's there.. I'll spend a week or 5 doing all of the
> i.MX chips and you'll have a second test case for any problems :)

Did you try the fully integrated test tree I mentioned in the cover letter?

tree: https://github.com/t-kristo/linux-pm.git
branch: 3.12-rc6-dt-clks-v9

This has everything in it, and compiles cleanly.

-Tero

