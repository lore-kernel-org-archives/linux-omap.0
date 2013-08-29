From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 08:29:37 -0700
Message-ID: <CAGa+x85u0OpB9o71xUTs15wt8Te-o5f0C9o22GHzZwOjn5F6=w@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
	<CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
	<20130829110534.GV10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:58980 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab3H2P3j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 11:29:39 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so574374wes.27
        for <linux-omap@vger.kernel.org>; Thu, 29 Aug 2013 08:29:37 -0700 (PDT)
In-Reply-To: <20130829110534.GV10783@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Russ Dill <Russ.Dill@ti.com>, =?ISO-8859-1?Q?Jan_L=FCbbe?= <jlu@pengutronix.de>, devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 29, 2013 at 4:05 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 27, 2013 at 06:05:34PM -0700, Russ Dill wrote:
>> On Tue, Aug 27, 2013 at 3:44 PM, Kevin Hilman <khilman@linaro.org> wrote:
>
>> > The framework already has a concept of suspend voltage, suspend mode
>> > etc.  Maybe it needs some generalizing so low-level platform code could
>> > query the framework for the sequence so it can be done late in platform
>> > idle/suspend paths.  Especially for regmap drivers, this seems feasible.
>
>> Yes, my main hesitation for going down this path is possible lack of
>> support for such an interface upstream.
>
> Someone is going to have to walk me through the context for me to fully
> understand what this is all about - what's the problem?

The basic problem is how to have low-level platform code (or possibly
firmware) send commands to a regulator to scale voltage.  This has to
happen *very* late in the suspend process, so having the drivers do it
themselves is not feasible.

The proposal in this series is to define the i2c commands sequence to
be sent to the regulator in the i2c node of the DT.  The
platform-specific code then reads the sequence from the DT and sends
the commands (or in in the case of the current series, passes the
sequence to some firmware on a microcontroller which does the
sequence.)

> Generally for suspend if the sequencing is being done by the processor
> it's been handled by the drivers for the components in question.  For
> sequencing beyond that you're into hardware features which aren't all
> that regular sadly and often aren't controllable either.  It sounds like
> this is the latter case but the thing that manages some of the late
> power down stages does so using a firmware we can rewrite?

For the TI AM335x, the source for M3 firmware is available and
configurable[1].  However, I'd still rather see this done by the
low-level platform code in linux, not offloaded to the firmware, but
the linux vs. firmware decision orthogonal to how to define/probe the
sequences that need to be sent to the regulator.

Kevin

[1] git://arago-project.org/git/projects/am33x-cm3.git
