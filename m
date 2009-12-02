From: Olof Johansson <olof@lixom.net>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Wed, 2 Dec 2009 09:53:19 -0600
Message-ID: <20091202155319.GA3628@lixom.net>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com> <1259599010.4649.51.camel@thunk> <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com> <20091130194031.GV4348@atomide.com> <fa686aa40912020707p70eb693dp6fcd03facabb5892@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:41332 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322AbZLBPvN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Dec 2009 10:51:13 -0500
Content-Disposition: inline
In-Reply-To: <fa686aa40912020707p70eb693dp6fcd03facabb5892@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Tony Lindgren <tony@atomide.com>, Peter Barada <peterb@logicpd.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org

On Wed, Dec 02, 2009 at 08:07:21AM -0700, Grant Likely wrote:

> Oh, and speaking of GPIOs, there is a binding for describing GPIO pin
> connections in the device tree:
> Documentation/powerpc/dts-bindings/gpio/gpio.txt

That binding is more about documenting a bank of GPIO pins, while
chips like OMAP will need something a bit more flexible.

Given the flexibility and complexity of configuring the pins on
mobile-oriented SoCs where each function can come out a variety of
different pins, and many pins can 3 or 4 functions associated with them
(selected by software config), it will definitely bring a new level of
complexity to the device tree descriptions.

I'm definitely not saying that it is impossible, but it might take a
little work to hash out a binding that everyone will be happy with.


-Olof
