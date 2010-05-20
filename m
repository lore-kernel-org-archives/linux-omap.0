From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] gpiolib: introduce set_debounce method
Date: Thu, 20 May 2010 15:50:41 -0700 (PDT)
Message-ID: <598314.1671.qm@web180305.mail.gq1.yahoo.com>
References: <20100520194509.GB10739@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n4-vm0.bullet.mail.gq1.yahoo.com ([67.195.9.7]:42622 "HELO
	n4-vm0.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753133Ab0ETWum convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 18:50:42 -0400
In-Reply-To: <20100520194509.GB10739@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>


> This would be generally useful for embedded systems,
> especially where the interrupt concerned is a wake source.
>=A0 It allows drivers to avoid
> spurious interrupts from noisy sources so if the hardware
> supports it
> the driver can avoid having to explicitly wait for the
> signal to become
> stable and software has to cope with fewer events.

True.

Not all GPIOs have hardware debounce though, so offering this
capability sort of begs the question of where/how to provide a
software debounce mechanism too...


> We've lived without it for quite some time, though.

I looked at adding debounce support to the generic GPIO calls
(and thus gpiolib) some time back, but decided against it.  I
forget why at this time (check list archives) but it wasn't because
of lack of utility in certain contexts.

One thing to watch out for is just how variable the hardware
capabilities are.  Atmel GPIOs have something like a fixed number
of 32K clock cycles for debounce, twl4030 had something odd, OMAPs
were more like the Atmel chips but with a different clock.  In some
cases debouncing had to be ganged, not per-GPIO.  And so forth.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
