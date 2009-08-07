From: Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Subject: Re: MMC3 Overo
Date: Fri, 07 Aug 2009 11:24:34 +0200
Message-ID: <4A7BF2D2.7060608@nt.tu-darmstadt.de>
References: <bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com> <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com> <4A79C83E.9040603@deeprootsystems.com> <5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com> <4A79D104.60607@deeprootsystems.com> <bb2708720908051229x49f10094w9b19b468d4bfaec8@mail.gmail.com> <bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com> <871vnp8170.fsf@deeprootsystems.com> <4A7AF213.6040301@balister.org> <1249574990.10885.43.camel@blitz> <20090807082115.GY2358@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:60114 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbZHGJYg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 05:24:36 -0400
In-Reply-To: <20090807082115.GY2358@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Barada <peterb@logicpd.com>, Philip Balister <philip@balister.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren wrote:

<snip>
>>  Here's an idea:
>>
>>  1) Replace index with enum search in pin table - this breaks the
>>  requirement that the enum list and table align - a good thing as
>>  misalingment has bitten me multiple times when adding pins to the
>>  current mux table.  Also, pinmux setup is done infrequently, so the
>>  search doesn't add much overall execution time.
>
> Yeh something like that sounds good. We should just move the omap1
> specific code to live in mach-omap1 and keep it as it is for now.
>
> You might also want to take a look at what the sh people have done:
>
> $ find arch/sh -name \*mux*
>
>>  2) Break up mux table into two parts, the "common" mux list, and a
>>  "custom" mux list - the latter in the board file, and add a function to
>>  add the custom mux list to mux lists searched by omap_cfg_reg().
>>
>>  3) Search the custom mux list first (if specified - allows replacing an
>>  entry in the common table if hardware required differences in
>>  termination, custom pins for GPIO, etc).
>>
>>  For example, on the OMAP3530, balls H18-H21 can be associated with
>>  either UART3, or GPIOs 163-166. In the common mux list (where multiple
>>  boards use those pins for UART3, the common mux file can have the
>>  entries:
>>
>>  H18_35XX_UART3_CTS
>>  H19_35XX_UART3_RTS
>>  H20_35XX_UART3_RX
>>  H21_35XX_UART_TX
>>
>>  that sets up the mux for those pines as a UART.  If a board wants to use
>>  those pins instead for GPIO, then in the board file it can have a custom
>>  mux list with:
>>
>>  H18_35XX_GPIO_163
>>  H19_35XX_GPIO_164
>>  H20_35XX_GPIO_165
>>  H21_35XX_GPIO_166
>>
>>  and call into the mux code to add the custom mux list to be searched
>>  first.
>>
>>  Thoughts?
>
> Sounds pretty good to me!

but does not solve yet the "package" issue, where different omap3 packages have
different balls connected, no? It would be ok for board files, assuming that a
board has only one package, but what about the common code?

Or are the package differences only for a few pins, in this case they could be
"banned" from common and must live in board files..




