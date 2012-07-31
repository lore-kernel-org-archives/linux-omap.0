From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v3 1/3] ARM: omap: clk: add clk_prepare and clk_unprepare
Date: Tue, 31 Jul 2012 01:21:24 -0700
Message-ID: <50179584.9070006@codeaurora.org>
References: <1341224669-15231-1-git-send-email-rnayak@ti.com> <1341224669-15231-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1207301614590.8722@utopia.booyaka.com> <CAJOA=zPmfq+WsAF-7nAkMGghPLYHpd+fCkrsv=3JSWLGMb-zkg@mail.gmail.com> <20120730230233.GA12574@n2100.arm.linux.org.uk> <CAJOA=zNnLahwhzjE0jkmiax8=kU8O4puJQJ1VbA-gDScawg6jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:60332 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab2GaIVZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 04:21:25 -0400
In-Reply-To: <CAJOA=zNnLahwhzjE0jkmiax8=kU8O4puJQJ1VbA-gDScawg6jw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rob Herring <rob.herring@calxeda.com>, Magnus Damm <magnus.damm@gmail.com>

On 07/30/2012 05:31 PM, Turquette, Mike wrote:
> On Mon, Jul 30, 2012 at 4:02 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Jul 30, 2012 at 03:42:13PM -0700, Turquette, Mike wrote:
>>> On Mon, Jul 30, 2012 at 3:31 PM, Paul Walmsley <paul@pwsan.com> wrote:
>>>> So if we make a change like this one, it seems like we would basically
>>>> expect it to break once we start doing anything meaningful with
>>>> clk_prepare(), like using clk_prepare() for voltage scaling or something
>>>> that requires I2C?  We'd also probably want to mark this with some kind of
>>>> "HACK" comment.
>>>
>>> Hi Paul,
>>>
>>> Did you have anything in mind to start using clk_prepare?  I still
>>> hope to get rid of it some day and replace that call with a
>>> combination of clk_enable and a check like clk_enable_can_sleep.
>>
>> Don't you dare.
>>
>> We arrived at the clk_prepare()/clk_enable() split after lots of
>> discussion between different platform maintainers and their
>> requirements.
>>
>> Shoving crap like "clk_enable_can_sleep()" down into drivers is
>> totally and utterly idiotic.  We've had the situation *already*
>> where some drivers can be used on some platforms but not on others
>> because of differences in clk_enable() expectations.
>>
>
> How does having a dynamic run-time check cause a generic driver to run
> on "some platforms but not on others"?
>
>> Don't go back there.  clk_prepare() and clk_enable() are separate
>> calls for a very good reason.  One is sleepable, the other can be
>> called from any atomic contexts.
>
> Two calls exist because of context differences.  But in practice they
> do the same thing: cause a line to toggle at a rate.  If a run-time
> check exists and the framework could handle this gracefully, why would
> you still choose the split api?

No. IMO, the two calls exist because getting a line to toggle at a rate 
can involve both slow and fast steps. It's not just a either/or or a 
random choice to allow doing it in one context vs. another.

Drivers shouldn't care what the actual steps are. Having drivers care 
how long each steps take or what they are (by using the can_sleep APIs) 
in each architecture/platform is a bad abstraction.

The main point of the clock prepare/enable/disable/unprepare APIs is 
about power management. So, the drivers just need to know when they have 
enough time to do the quick part of the enable/disable and the slow part 
of the enable/disable (prepare/unprepare) and make the calls in those 
locations in code/execution flow. That, IMO is the ideal abstraction.

If drivers need to ensure the clock is fully gated for functional 
correctness, then they need to take the time (meaning, postpone the 
action to a non-atomic context) and do the full gating by completely 
unpreparing the clock.

I have heard this idea about removing the clk_prepare/unprepare API too 
many times and it makes me uncomfortable. I would really prefer we (the 
community) take this discussion to the end and put an end to it. We 
either agree to stick with the clk_prepare APIs or figure out the newer 
APIs. I don't want to keep having to deal with the "we really should be 
removing the clk_prepare() APIs" wrench thrown into the discussion every 
time we discuss anything related to a locking issue.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
