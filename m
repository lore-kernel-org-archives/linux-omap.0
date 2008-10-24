From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-omap-git 3/4] remove omap_set_gpio_direction()
Date: Fri, 24 Oct 2008 00:52:35 -0700
Message-ID: <200810240052.35896.david-b@pacbell.net>
References: <200810222356.21049.david-b@pacbell.net> <20081024100031.0d5a1db5.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:38655 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751117AbYJXHwi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Oct 2008 03:52:38 -0400
In-Reply-To: <20081024100031.0d5a1db5.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org, marek.vasut@gmail.com

On Friday 24 October 2008, Jarkko Nikula wrote:
> > =A0drivers/leds/leds-omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
> >
> IMO this driver should go and board-palmtt.c to use
> drivers/leds/leds-gpio.c instead.

I second that.  There's no need for leds-omap.c ...

In a similar vein, drivers/leds/leds-omap-pwm.c seems like
it should be able to use led_classdev.blink_set(), or maybe
fit into that newish PWM framework being discussed.  (Not
that it has PWM controlled led *blinking* yet ...)

The PWM support can likely wait a while though, unless
someone's keen on getting that part of n800 support upstream
sooner rather than later.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
