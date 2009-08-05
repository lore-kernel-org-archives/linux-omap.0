From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Fwd: MMC3 Overo
Date: Wed, 5 Aug 2009 11:21:03 -0700
Message-ID: <5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
	 <6ed0b2680908050132n33abc45bgd4e91690c43ba277@mail.gmail.com>
	 <bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>
	 <bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com>
	 <873a866xdo.fsf@deeprootsystems.com>
	 <bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com>
	 <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>
	 <4A79C83E.9040603@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:40334 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbZHESVD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 14:21:03 -0400
Received: by qw-out-2122.google.com with SMTP id 8so119270qwh.37
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 11:21:03 -0700 (PDT)
In-Reply-To: <4A79C83E.9040603@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: John Sarman <johnsarman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Aug 5, 2009 at 10:58 AM, Kevin
Hilman<khilman@deeprootsystems.com> wrote:
> Steve Sakoman wrote:
>> And up to now in each case I shrug and say "no time to do that now,
>> I'll just leave kernel pinmuxing turned off and do it in u-boot"
>
> I agree there are lots of shortcomings in the current mux code and we've
> been hitting them regularily lately.
>
> That being said, for mux settings that done one-time only at boot, what are
> the problems you're running into?

It's been a few months since I last encountered this, so the exact
details are a bit fuzzy.

I seem to recall that there were some basic issues with enabling
kernel pinmuxing in that some of the setup that was done for all
machines was just wrong for my particular machine.  IIRC, it was due
to assumptions about which pad was used for a particular function (for
those functions which can be steered to multiple GPIO pads).

So I faced having to undo that change in my board file as well as any
issues that may have arisen from glitches on the GPIO pins during the
process.  And since there were several of these I gave up and turned
off kernel pinmuxing.

I'd be happy if we cleaned up the "one size fits all" pinmuxing to
just that subset that truly does fit all boards, and leave the rest to
the board files.  I'd also be content to have it all done in the board
file for each machine.

Steve
