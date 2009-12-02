From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Wed, 2 Dec 2009 08:07:21 -0700
Message-ID: <fa686aa40912020707p70eb693dp6fcd03facabb5892@mail.gmail.com>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
	<1259599010.4649.51.camel@thunk> <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
	<20091130194031.GV4348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:45611 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbZLBPHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 10:07:34 -0500
Received: by yxe17 with SMTP id 17so205161yxe.33
        for <linux-omap@vger.kernel.org>; Wed, 02 Dec 2009 07:07:41 -0800 (PST)
In-Reply-To: <20091130194031.GV4348@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Barada <peterb@logicpd.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Mon, Nov 30, 2009 at 12:40 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Grant Likely <grant.likely@secretlab.ca> [091130 09:01]:
>> http://www.elinux.org/Device_Trees
>>
>> I expect to have my prototype ready for review mid-January, and most
>> of the common code should be either merged or queued up in linux-next
>> by that time.
>
> While device tree is a nice solution to some of the problems, it still
> leaves all the issues we already have with buggy and and outdated
> bootloaders. So we still need to properly initialize the devices in
> the kernel.

Yes, buggy firmware is still a problem.  However, if the required
configuration is described in the device tree data, then for some
things the driver can handle setting up the device and the amount of
board-specific code can be reduced.

> Just for reference, most of the omap bootloader bugs seem to be
> related to not muxing the pins right or using wrong timings for GPMC.
>
> And then things that mostly change during the board development are
> the GPIO pins, but those can be easily rewritten in the board-*.c
> files based on the omap_rev.
>
> But at least the device tree is a standard model, while the earlier
> omap tag approach was non-standard.
>
> Peter, maybe you've already thought through all this.. But would it be
> possible to do lightweight device tree that we just use to populate
> the platform data?

This is completely possible.  Just having the device tree available
doesn't force the kernel to use it for everything.  I've found it
useful to start small and add things as I need them.  Most important
thing to remember is to follow the documented & established device
tree conventions so that common code can understand it.

Oh, and speaking of GPIOs, there is a binding for describing GPIO pin
connections in the device tree:
Documentation/powerpc/dts-bindings/gpio/gpio.txt

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
