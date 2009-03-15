From: David Brownell <david-b@pacbell.net>
Subject: Re: Overo broken after recent mainline merge
Date: Sat, 14 Mar 2009 20:18:55 -0700
Message-ID: <200903142018.55337.david-b@pacbell.net>
References: <5e088bd90903140624u5b5098f4vd9b1afa937325779@mail.gmail.com> <200903141414.06045.david-b@pacbell.net> <20090314223435.GA6523@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:23976 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751106AbZCODS6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Mar 2009 23:18:58 -0400
In-Reply-To: <20090314223435.GA6523@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Steve Sakoman <sakoman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Saturday 14 March 2009, Mark Brown wrote:
> > A third approach (after applying that one patch that's
> > in the regulator-next tree) would be
>=20
> > =A0=A0=A0=A0=A0=A0if (rdev->is_enabled() > 0)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rdev->use_count =3D 1;
>=20
> That won't work with consumers that can share their supply - they can=
't
> tell if the regulator was enabled because it was left on at startup o=
r
> if it was enabled by some other consumer.

It works *exactly* like it would if the bootloader were
able to poke the "boot_on" flag for each regulator it
left enabled.

It also helps that the typical scenario I need to care
about is where there's only one consumer ... but in any
case, the change sketched above can't add new problems.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
