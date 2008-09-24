From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP3EVM: TWL4030 Keypad irq error fix
Date: Wed, 24 Sep 2008 08:34:16 -0700
Message-ID: <200809240834.17155.david-b@pacbell.net>
References: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com> <200809231245.42614.david-b@pacbell.net> <20080924104431.GL24627@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:21516 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751528AbYIXPeU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Sep 2008 11:34:20 -0400
In-Reply-To: <20080924104431.GL24627@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Wednesday 24 September 2008, Felipe Balbi wrote:
>=20
> > I'll do the GPIO code, which will be a slightly more
> > interesting example than the RTC.
>=20
> I can do the keypad since I'm already working on the usb as well.

OK.  Good to know folk are actively working on getting
this in shape for upstream!


> Dave,=20
> I'm gonna add twl_has_rtc(), twl_had_keypad() and twl_has_usb() to cl=
ean
> a bit add_children. With those, we're gonna be able to:
>=20
> if (twl_has_keypad() && pdata->keypad) {
> =A0=A0=A0=A0=A0=A0=A0=A0...
> }

Sounds good.  Fault handling might need attention too.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
