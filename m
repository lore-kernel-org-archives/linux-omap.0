From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Wed, 2 Dec 2009 09:04:49 -0700
Message-ID: <fa686aa40912020804g34e1258k626349d711cfadd4@mail.gmail.com>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
	<1259599010.4649.51.camel@thunk> <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
	<20091130194031.GV4348@atomide.com> <fa686aa40912020707p70eb693dp6fcd03facabb5892@mail.gmail.com>
	<20091202155319.GA3628@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:34406 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbZLBQFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 11:05:03 -0500
Received: by iwn1 with SMTP id 1so208786iwn.33
        for <linux-omap@vger.kernel.org>; Wed, 02 Dec 2009 08:05:09 -0800 (PST)
In-Reply-To: <20091202155319.GA3628@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, Peter Barada <peterb@logicpd.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org

On Wed, Dec 2, 2009 at 8:53 AM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Dec 02, 2009 at 08:07:21AM -0700, Grant Likely wrote:
>
>> Oh, and speaking of GPIOs, there is a binding for describing GPIO pin
>> connections in the device tree:
>> Documentation/powerpc/dts-bindings/gpio/gpio.txt
>
> That binding is more about documenting a bank of GPIO pins, while
> chips like OMAP will need something a bit more flexible.
>
> Given the flexibility and complexity of configuring the pins on
> mobile-oriented SoCs where each function can come out a variety of
> different pins, and many pins can 3 or 4 functions associated with them
> (selected by software config), it will definitely bring a new level of
> complexity to the device tree descriptions.

Ah, you're talking about pin muxing configuration, right?  Yes, that
GPIO binding deals with controllers, not pin mux.  Pin mux is very
much an SoC specific thing that isn't mapped easily to a generic
binding.

On the 5200, I haven't attempted to describe pin-mux in the device
tree at all, and have either expected firmware to set it up correctly,
or fixed it up in the platform code.

> I'm definitely not saying that it is impossible, but it might take a
> little work to hash out a binding that everyone will be happy with.

Right.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
