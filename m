From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Fri, 30 Aug 2013 09:06:50 -0700
Message-ID: <87eh9bqi1x.fsf@linaro.org>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
	<CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
	<87ppsw7cgq.fsf@linaro.org>
	<CA+Bv8XbxV=BFjcSsUMX2pz9LeCkSwrjzZmj_=YbHGzyfbLXmaQ@mail.gmail.com>
	<874na8xqfl.fsf@linaro.org>
	<CANacCWzK1w9+XKEoUfS4ZB7QGxi_0JkVWBLs_wsaUjrzW2QB+A@mail.gmail.com>
	<87hae8tc6e.fsf@linaro.org>
	<CA+Bv8XaQgOiSiScQW=CVxzXBuG0soafQotApjoVEZ0P9U3netg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:63153 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309Ab3H3QGy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 12:06:54 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so2052264pbc.4
        for <linux-omap@vger.kernel.org>; Fri, 30 Aug 2013 09:06:53 -0700 (PDT)
In-Reply-To: <CA+Bv8XaQgOiSiScQW=CVxzXBuG0soafQotApjoVEZ0P9U3netg@mail.gmail.com>
	(Russ Dill's message of "Thu, 29 Aug 2013 17:25:24 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Vaibhav Bedia <vaibhav.bedia@gmail.com>, devicetree@vger.kernel.org, Jan =?utf-8?Q?L=C3=BCbbe?= <jlu@pengutronix.de>, Mark Brown <broonie@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Russ Dill <Russ.Dill@ti.com> writes:

> On Thu, Aug 29, 2013 at 2:33 PM, Kevin Hilman <khilman@linaro.org> wrote:
>> Vaibhav Bedia <vaibhav.bedia@gmail.com> writes:
> [snip]
>>> Morevoer, all the suggestions on how to keep the code in Linux working
>>> around the complications due to the main memory not being accessible
>>> will need to be replicated on the non-Linux s/w stacks and that's just
>>> make it more difficult for them.
>>
>> The linux code has to be very self-contained (in assembler or C), so I'm
>> not sure how it's difficult to replicated in any other OS (or non-OS.)
>
> Let me pull on this thread a little bit. Would this involve defining a
> bunch of different sections for each arch so that I could do:
>
> void __sram_am33xx am33xx_some_pm_function(args....)
> {
> }
>
> static struct am33xx_foo_dyn *blargity __sramdata_am33xx = { ...};
>
> static const struct am33xx_foo_const *blarg __sramconst_am33xx = { ... };
>
> The sram push code could then push these sections into sram. There
> would then be a set of inlines or macros for converting addresses
> within these sections to SRAM addresses, maybe also inlines or macros
> for calling code that has been pushed into sram by wrapping the
> original function pointer. The macros or inlines that call SRAM code
> could perform the trampoline as well.

Well, I was thinking of something much dumber.

I was thinking about just _carefully_ writing a single, self-contained C
function, with all of its data on the stack (and consts as #defines).
Think of it is a step up in readability from straight assembly (which
was the stated reason for moving the code to the M3 in the first place.)

Kevin
