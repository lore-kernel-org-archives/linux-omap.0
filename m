From: Kevin Hilman <khilman@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Mon, 26 Mar 2012 17:34:21 -0700
Message-ID: <87haxaq3ua.fsf@ti.com>
References: <WC20120322110946.6413AA@terrafix.co.uk> <87r4wka6bf.fsf@ti.com>
	<WC20120326134115.9815DF@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:33566 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751236Ab2C0AeY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Mar 2012 20:34:24 -0400
Received: by mail-gx0-f177.google.com with SMTP id k1so5184582ggn.8
        for <linux-omap@vger.kernel.org>; Mon, 26 Mar 2012 17:34:23 -0700 (PDT)
In-Reply-To: <WC20120326134115.9815DF@terrafix.co.uk> (Joe Woodward's message
	of "Mon, 26 Mar 2012 14:41:15 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, govindraj.raja@ti.com, Felipe Balbi <balbi@ti.com>

+Govindraj,

"Joe Woodward" <jw@terrafix.co.uk> writes:

> Right, I've stepped back a bit and dug out a GUSMTIX Palo43 carrier
> board on which to test the Overo OMAP3530 COM and I've found:
>  - Running a stock 3.3 (with absolutely no changes) does indeed suspend correctly.
>  - Running the 3.3 kernel with my (minor) board modifications
>  (basically defining some buttons) suspends correctly as well.
>
> Then I went back to my original board and the 3.3 still wakes up from
> suspend immediately. So I had a think, and the only real differences
> between my board the the GUMSTIX Palo43 board is that I am using
> multiple UARTs.
>
> Up to this point I've only wanted to wake on the console (ttyO2), and
> not any other UARTs so I've stopped them waking with:
>   echo disabled > /sys/devices/platform/omap/omap_uart.0/power/wakeup
>   echo disabled > /sys/devices/platform/omap/omap_uart.1/power/wakeup
>
> I wanted to check that this still worked, so tried disabling wakeup on
> the console (ttyO2):
>   echo disabled > /sys/devices/platform/omap/omap_uart.2/power/wakeup
>
> And if I do "echo mem > /sys/power/state" I was expecting to stay in
> suspend when I typed on my keyboard... However, the kernel still woke
> from suspend, which leads me to believe that the UART wakeup hasn't
> been disabled?

Just to confirm: did the above work for you before v3.3?

> Could you test if this is also the case your end?

Yes, I get the same behavior, which is indeed broken.

Govindraj, can you look into this?

A quick glance suggests that disabling wakeups via the sysfs file is
only disabling runtime PM, but not actually disabling wakups at the
module-level or at the IO ring.

Kevin
