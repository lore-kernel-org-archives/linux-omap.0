From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP3 GPIO: Fix getting the value of the GPIO output pin
Date: Sun, 8 Feb 2009 21:53:30 -0800
Message-ID: <200902082153.30479.david-b@pacbell.net>
References: <4e1455be0902062015i1ff94b28p93588e61b7860618@mail.gmail.com> <200902082011.36500.david-b@pacbell.net> <4e1455be0902082129i2c038477g886c8de03d3073dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:24932 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751342AbZBIFxc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 00:53:32 -0500
In-Reply-To: <4e1455be0902082129i2c038477g886c8de03d3073dd@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joonyoung Shim <dofmind@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, kyungmin.park@samsung.com

On Sunday 08 February 2009, Joonyoung Shim wrote:
> > Which should clearly be AE6_34XX_GPIO141_OUT since it does
> > not enable the input driver. =A0Try making that ...PIN_OUTPUT
> > read ...PIN_INPUT and see if things behave.
>=20
> Of course, it will be better if the name is clear as AE6_34XX_GPIO141=
_OUT.
> but, the core of this problem is not it, the chip->get() called in
> gpiolib_dbg_show()
> of drivers/gpio/gpiolib.c or dbg_gpio_show() of arch/arm/plat-omap/gp=
io.c
> can return the wrong value when gpio pin is configured as an output.

No, the core of the problem is that you're using a GPIO
which is explicitly configured as output-only ... but are
treating it as if it were a normal bi-directional GPIO.

It's acting *exactly* right for an output-only GPIO.  But
that's not the behavior you expect, or want.

If you weren't disabling the input driver, then when you
ask for the input value it would work as you expect.  Which
is why I suggested you change how that ball is configured.
(That's actually a bugfix to those muxing tables ...)

- Dave

p.s. This specific confusion is new on OMAP3; previous
     OMAPs didn't have the extra byte of options to
     configure.  The PIN_INPUT flag was, on previous
     chips, effectively hard-wired on for GPIOs.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
