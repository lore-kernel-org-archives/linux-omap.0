From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] twl4030-gpio: Fix getting the value of the TWL4030 GPIO  output pin
Date: Wed, 11 Feb 2009 18:16:41 -0800
Message-ID: <200902111816.41569.david-b@pacbell.net>
References: <4e1455be0902062213o769a4d15ha0c892508839dbad@mail.gmail.com> <200902070000.49089.david-b@pacbell.net> <4e1455be0902090502l554ca462m9c096e359a5b29c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:39029 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754921AbZBLCQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Feb 2009 21:16:43 -0500
In-Reply-To: <4e1455be0902090502l554ca462m9c096e359a5b29c3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joonyoung Shim <dofmind@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Monday 09 February 2009, Joonyoung Shim wrote:
> but, it doesn't return actual value of the pin if twl4030 GPIO pin is=
 output.

So it would seem that these GPIOs don't support
bidirectional usage.  Documentation/gpio.txt includes:

>>>		However, note that not all platforms can
>>>	read the value of output pins; those that can't
>>>	should always return zero. =20

Which is exactly what's happening here, it seems...




> For example, the GPIO13 pin of twl4030 is configured as an output
> using gpio_direction_output() and assigns the GPIO's value to 1
> using gpio_set_value_cansleep(), the result of "# cat /sys/kernel/deb=
ug/gpio"
> reports to me as follows.
>=20
> GPIOs 192-209, platform/twl4030_gpio, twl4030, can sleep:
> =A0gpio-205 (keyled =A0 =A0 =A0 =A0 =A0 =A0 =A0) out lo
>=20
> but it should have reported "hi" instead of "lo".
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
