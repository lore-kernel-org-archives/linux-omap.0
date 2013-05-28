From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: configs: omap2plus_defconfig: enable USB bits which
 work
Date: Tue, 28 May 2013 22:24:13 +0300
Message-ID: <20130528192413.GA13842@arwen.pp.htv.fi>
References: <1368494600-18953-1-git-send-email-balbi@ti.com>
 <87ip2ly7p7.fsf@linaro.org>
 <519C7EB3.2040801@ti.com>
 <87hahnc6je.fsf@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52810 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab3E1TZA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 May 2013 15:25:00 -0400
Content-Disposition: inline
In-Reply-To: <87hahnc6je.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, kevin.hilman@linaro.org, Kishon Vijay Abraham I <kishon@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 28, 2013 at 11:18:13AM -0700, Kevin Hilman wrote:
> Roger Quadros <rogerq@ti.com> writes:
>=20
> > On 05/14/2013 05:09 PM, Kevin Hilman wrote:
>=20
> [...]
>=20
> >>> @@ -206,10 +207,18 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
> >>>  CONFIG_USB_DEVICEFS=3Dy
> >>>  CONFIG_USB_SUSPEND=3Dy
> >>>  CONFIG_USB_MON=3Dy
> >>> +CONFIG_USB_EHCI_HCD=3Dy
> >>=20
> >> NAK (on this particular change)
> >>=20
> >> This cannot be enable by default yet as EHCI *still* breaks core
> >> retention[1] (which has been broken since at least v3.5, almost a year
> >> now.)
> >
> > True. Due to broken smart idle/wakeup, EHCI host has to rely on
> > IO Daisy chaining mechanism for remote wakeup.
> >
> > So this can't be fixed till we have daisy chaining working with device =
tree
> > boot.=20
>=20
> ... and is anyone working on that?

Let's ask Tero :-)

--=20
balbi

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRpQRdAAoJEIaOsuA1yqREIZsP/3zB4VqGbuNJP/Ib0LxjDFOf
O2yUeMRtId7FBSC77brb7IBHtqQcl58Gu0WMfZ6Ti6E7Te+Zl1jNCOPHYAE9U6f/
g15i5iOHedtOCSZK0a5fdNaCpsE+QZTH8zUJ7LUo5li4jjwW+V6I2jg0NX2/j+Gt
+Qihh++RZ65IAqK4UbJgTU72pz7CIbqI8vPTpTs9pOsbfbKIJ/4avWUm0XrzB6NC
a0YjXs0C2+i4pAuAZ+oUwe1r6hpG1Xn5n70fq7bBmocIktbsen9NB/nbszLD9g2h
j1VwU9UJpPyoreN2TomJtWRGkr4AFnSDuxblqQYuY3T0Qpwn0f+F8Hu61aNOaWZB
18Av2cMtbtaNTYoBjUbZdLW4+vgXmlcisssOXzH3ooo/q0EMkMwiSVSX6krI3vBk
UJu7V78F+fFFrVx5hN6xqBZCYytSK96xxp26tU0jzlUEgoupbN0fqLcMZUpJSUJ3
v3bGMqtsfKNld683jzp9vyEi7If9xDP6sll+6Jx8D4TW7845P8h/8rMN0nHQfpp3
ddLKpdJ6auXZ3sShzC7raRl1PMY4VhgZ+BkJvS6D1UsBsBEh90JwWAZdwjOHaq3P
K6R+EaJu4YHwywMS/NXRUD9YH8qFqgr4ZSz7nN4BnZ/KVqWY9i6INPukBLzm5a0Y
sJkeVGJQm8rCx0n4BwP6
=f8Z6
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
