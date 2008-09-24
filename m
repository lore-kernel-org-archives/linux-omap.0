From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] OMAP3EVM: TWL4030 Keypad irq error fix
Date: Thu, 25 Sep 2008 01:44:14 +0300
Message-ID: <20080924224413.GJ10156@frodo>
References: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com> <200809231245.42614.david-b@pacbell.net> <20080924104431.GL24627@gandalf.research.nokia.com> <200809240834.17155.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46234 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbYIXWo0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 18:44:26 -0400
Content-Disposition: inline
In-Reply-To: <200809240834.17155.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: felipe.balbi@nokia.com, Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Wed, Sep 24, 2008 at 08:34:16AM -0700, David Brownell wrote:
> On Wednesday 24 September 2008, Felipe Balbi wrote:
> >=20
> > > I'll do the GPIO code, which will be a slightly more
> > > interesting example than the RTC.
> >=20
> > I can do the keypad since I'm already working on the usb as well.
>=20
> OK.  Good to know folk are actively working on getting
> this in shape for upstream!
>=20
>=20
> > Dave,=20
> > I'm gonna add twl_has_rtc(), twl_had_keypad() and twl_has_usb() to =
clean
> > a bit add_children. With those, we're gonna be able to:
> >=20
> > if (twl_has_keypad() && pdata->keypad) {
> > =A0=A0=A0=A0=A0=A0=A0=A0...
> > }
>=20
> Sounds good.  Fault handling might need attention too.

Sure, think I was thinking that in case in run out of memory I'm gonna
stop trying to add any more children but leaving the ones we could
create up and running. What do you think ?

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
