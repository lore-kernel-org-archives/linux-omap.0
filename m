From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.28-rc3-omap] twl4030-core simplification
Date: Thu, 13 Nov 2008 17:00:41 -0800
Message-ID: <200811131700.42079.david-b@pacbell.net>
References: <200811071645.15687.david-b@pacbell.net> <20081114002948.GB19711@frodo> <20081114004243.GB3106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:42188 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753950AbYKNBAt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2008 20:00:49 -0500
In-Reply-To: <20081114004243.GB3106@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@openedhand.com>

On Thursday 13 November 2008, Tony Lindgren wrote:
> > > I hadn't gotten any test results other than knowing Felipe was
> > > using this. =A0So I'll hold off a bit on sending the updated
> > > patch to Samuel, probably till end-of-week, on the grounds that
> > > the keypad, battery, and ADC devices didn't get tested yet.
> >=20
> > The new add_child() works quite ok and simplifies a lot the code. B=
ut
> > the regulator driver, I think we can hold a bit as that needs caref=
ul
> > testing.
>=20
> That's to make USB use the twl regulator code, right?

Looks for now like twl4030_usb might be the first thing that's
able to use the regulator code "in all its glory".  Felipe can
gain the glory of being the Official First Guinea Pig.  ;)

No rush on that, IMO.

Next two obvious candidates to use "struct regulator" are the
HSMMC support, and the LCD/touchscreen power domains on some of
the SDPs.

I think providing the board-specific init data for anything
else is likely to be a big PITA, since it presumes the actual
device node is known when the regulator device is created.
That's not always going to be practical.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
