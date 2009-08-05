From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Fwd: MMC3 Overo
Date: Wed, 05 Aug 2009 11:35:48 -0700
Message-ID: <4A79D104.60607@deeprootsystems.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>	 <6ed0b2680908050132n33abc45bgd4e91690c43ba277@mail.gmail.com>	 <bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>	 <bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com>	 <873a866xdo.fsf@deeprootsystems.com>	 <bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com>	 <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>	 <4A79C83E.9040603@deeprootsystems.com> <5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:53179 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbZHESf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 14:35:56 -0400
Received: by wf-out-1314.google.com with SMTP id 26so78748wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 11:35:56 -0700 (PDT)
In-Reply-To: <5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: John Sarman <johnsarman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Steve Sakoman wrote:
> On Wed, Aug 5, 2009 at 10:58 AM, Kevin
> Hilman<khilman@deeprootsystems.com> wrote:
>> Steve Sakoman wrote:
>>> And up to now in each case I shrug and say "no time to do that now,
>>> I'll just leave kernel pinmuxing turned off and do it in u-boot"
>> I agree there are lots of shortcomings in the current mux code and we've
>> been hitting them regularily lately.
>>
>> That being said, for mux settings that done one-time only at boot, what are
>> the problems you're running into?
> 
> It's been a few months since I last encountered this, so the exact
> details are a bit fuzzy.
> 
> I seem to recall that there were some basic issues with enabling
> kernel pinmuxing in that some of the setup that was done for all
> machines was just wrong for my particular machine.  IIRC, it was due
> to assumptions about which pad was used for a particular function (for
> those functions which can be steered to multiple GPIO pads).
> 
> So I faced having to undo that change in my board file as well as any
> issues that may have arisen from glitches on the GPIO pins during the
> process.  And since there were several of these I gave up and turned
> off kernel pinmuxing.
> 
> I'd be happy if we cleaned up the "one size fits all" pinmuxing to
> just that subset that truly does fit all boards, and leave the rest to
> the board files.  I'd also be content to have it all done in the board
> file for each machine.

Indeed, any assumptions about common muxing that are not indeed common 
are bugs and should be fixed.

The "right" solution is to have everything in the kernel, and split 
across SoC "common" init and board specific init.  Of course u-boot
will still have to do some early muxing, but it should be redone in
the kernel so it's trivial to change bootloaders.

So the real missing piece is someone to step up and rework the mux code.
The bigger problem is that the vast majority of folks don't care about 
the common case and only care about getting thing working for a specific 
platform.

Kevin
