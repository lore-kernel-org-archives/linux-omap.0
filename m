From: Tony Lindgren <tony@atomide.com>
Subject: Re: MMC3 Overo
Date: Fri, 7 Aug 2009 12:55:31 +0300
Message-ID: <20090807095528.GC2358@atomide.com>
References: <4A79C83E.9040603@deeprootsystems.com> <5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com> <4A79D104.60607@deeprootsystems.com> <bb2708720908051229x49f10094w9b19b468d4bfaec8@mail.gmail.com> <bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com> <871vnp8170.fsf@deeprootsystems.com> <4A7AF213.6040301@balister.org> <1249574990.10885.43.camel@blitz> <20090807082115.GY2358@atomide.com> <4A7BF2D2.7060608@nt.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50403 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbZHGJzj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 05:55:39 -0400
Content-Disposition: inline
In-Reply-To: <4A7BF2D2.7060608@nt.tu-darmstadt.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Cc: Peter Barada <peterb@logicpd.com>, Philip Balister <philip@balister.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Vladimir Pantelic <pan@nt.tu-darmstadt.de> [090807 12:24]:
> Tony Lindgren wrote:
>
> <snip>
>>>  Here's an idea:
>>>
>>>  1) Replace index with enum search in pin table - this breaks the
>>>  requirement that the enum list and table align - a good thing as
>>>  misalingment has bitten me multiple times when adding pins to the
>>>  current mux table.  Also, pinmux setup is done infrequently, so the
>>>  search doesn't add much overall execution time.
>>
>> Yeh something like that sounds good. We should just move the omap1
>> specific code to live in mach-omap1 and keep it as it is for now.
>>
>> You might also want to take a look at what the sh people have done:
>>
>> $ find arch/sh -name \*mux*
>>
>>>  2) Break up mux table into two parts, the "common" mux list, and a
>>>  "custom" mux list - the latter in the board file, and add a function to
>>>  add the custom mux list to mux lists searched by omap_cfg_reg().
>>>
>>>  3) Search the custom mux list first (if specified - allows replacing an
>>>  entry in the common table if hardware required differences in
>>>  termination, custom pins for GPIO, etc).
>>>
>>>  For example, on the OMAP3530, balls H18-H21 can be associated with
>>>  either UART3, or GPIOs 163-166. In the common mux list (where multiple
>>>  boards use those pins for UART3, the common mux file can have the
>>>  entries:
>>>
>>>  H18_35XX_UART3_CTS
>>>  H19_35XX_UART3_RTS
>>>  H20_35XX_UART3_RX
>>>  H21_35XX_UART_TX
>>>
>>>  that sets up the mux for those pines as a UART.  If a board wants to use
>>>  those pins instead for GPIO, then in the board file it can have a custom
>>>  mux list with:
>>>
>>>  H18_35XX_GPIO_163
>>>  H19_35XX_GPIO_164
>>>  H20_35XX_GPIO_165
>>>  H21_35XX_GPIO_166
>>>
>>>  and call into the mux code to add the custom mux list to be searched
>>>  first.
>>>
>>>  Thoughts?
>>
>> Sounds pretty good to me!
>
> but does not solve yet the "package" issue, where different omap3 packages have
> different balls connected, no? It would be ok for board files, assuming that a
> board has only one package, but what about the common code?
>
> Or are the package differences only for a few pins, in this case they could be
> "banned" from common and must live in board files..

Well we need to mux all the pins that can potentially conflict only in the
board-*.c files.

For naming, I think we should use the default mode0 name in the mux register as the
key, and then link package specific pin names to that key. The pin names are
very handy to see for debugging at least.

Another thing to consider is if we want to support dynamic muxing. That means
we need to keep the mux tables in the memory.

Or do init time muxing in board-*.c files, then re-register the pins needed for
dynamic muxing in board-*.c files. That way most of the mux data can be __initdata,
and only the pins that have been registered for dynamic muxing need to be kept
in the memory.

Regard,

Tony
