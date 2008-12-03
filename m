From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Add tsc2007 based touchscreen driver.
Date: Wed, 3 Dec 2008 12:18:35 -0800
Message-ID: <200812031218.36036.david-b@pacbell.net>
References: <483a38b80812020539v2323a784h7f202749687764db@mail.gmail.com> <5d5443650812030321p77c4941cj2202418f0b0d44a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:28392 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759575AbYLCUSi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2008 15:18:38 -0500
In-Reply-To: <5d5443650812030321p77c4941cj2202418f0b0d44a2@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wednesday 03 December 2008, Trilok Soni wrote:
> Adding linux-omap mailing list. Sometime I am thinking that same chip
> might have interface to be connected on another board/cpu through SPI
> too, so in this case we will have two drivers doing the same thing an=
d
> difference is =A0just a change of the bus interface.

Is this chip an example of that?  It's I2C-only, and a quick
scan of TI's touchscreen chip page didn't show a sibling chip
with a logically-identical interface using SPI.


> We should do something v4l2_subdev framework right now going on on
> v4l2 mailing list to abstract the sensor drivers from bus.

I'll disagree.  When it's needed, this is easy to do ... bus
glue talking to chip-specific code, and including some kind of
bus-specific register access wrapper.  No framework necessary,
just straightforward design for any such drivers.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
