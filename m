From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP3EVM: TWL4030 Keypad irq error fix
Date: Wed, 24 Sep 2008 16:24:29 -0700
Message-ID: <200809241624.30071.david-b@pacbell.net>
References: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com> <200809240834.17155.david-b@pacbell.net> <20080924224413.GJ10156@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:22736 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752543AbYIXXYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Sep 2008 19:24:32 -0400
In-Reply-To: <20080924224413.GJ10156@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Wednesday 24 September 2008, Felipe Balbi wrote:
>=20
> > > if (twl_has_keypad() && pdata->keypad) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0...
> > > }
> >=20
> > Sounds good. =A0Fault handling might need attention too.
>=20
> Sure, think I was thinking that in case in run out of memory I'm gonn=
a
> stop trying to add any more children but leaving the ones we could
> create up and running. What do you think ?

Pretty much my conclusion:  report the problem, but continue.
In fact there's no point in returning error codes from that
routine...

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
