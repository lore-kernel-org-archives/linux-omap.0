From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable misc options for
 BeagleBoard-X15 platform
Date: Thu, 8 Jan 2015 15:58:39 -0600
Message-ID: <20150108215839.GV31926@saruman>
References: <1420751680-21230-1-git-send-email-nm@ti.com>
 <20150108212538.GU31926@saruman>
 <CAGo_u6p-6EuZR8JC2Z=o1t9EgXKQnH6R9mYrfLxrsD7sYXdAxg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xMJbWctQEcNQiBqK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48417 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbbAHV7i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2015 16:59:38 -0500
Content-Disposition: inline
In-Reply-To: <CAGo_u6p-6EuZR8JC2Z=o1t9EgXKQnH6R9mYrfLxrsD7sYXdAxg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--xMJbWctQEcNQiBqK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Thu, Jan 08, 2015 at 03:49:11PM -0600, Nishanth Menon wrote:
> On Thu, Jan 8, 2015 at 3:25 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, Jan 08, 2015 at 03:14:40PM -0600, Nishanth Menon wrote:
> >> @@ -205,6 +206,7 @@ CONFIG_PINCTRL_SINGLE=3Dy
> >>  CONFIG_DEBUG_GPIO=3Dy
> >>  CONFIG_GPIO_SYSFS=3Dy
> >>  CONFIG_GPIO_TWL4030=3Dy
> >> +CONFIG_GPIO_PALMAS=3Dy
> >
> > other than the power button, do you have anything else attached to a
> > palmas GPIO ? We might not need this for boot.
> we dont, but setting it to 'm'
> "warning: symbol value 'm' invalid for GPIO_PALMAS"

alright, should've checked. Guess we will need to patch that up at some
point.

cheers

--=20
balbi

--xMJbWctQEcNQiBqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrv2PAAoJEIaOsuA1yqRElgMP/A0M0z3GhClB3lczVLSGkrN4
55DBdBoDwy9QIyd/scxIRA7FUq6gIOlQaPmWT+7KvFaXuciAEpfi7MqZbXlzWHOQ
4XbrrzqTQor5OyreK8MXVtNVu84FfNl1TJREiCwaxdBhV5EhKkd4QCapMrJY/6sM
eDO6RFHmvpuUa4p8J3yRAb5yJqH3LRIth6qhiQZ1GE4pNiVcARhLi5CdOf6Pv6Rt
H3nDx+/tT+Zo1anVIM9Y8dYbWWTanpsW1SENS3YfjlJnKzr4fsV03Hv+Up2eFE7v
ZD8mV8tFXkneQ5oZ/qZJUhayTot+xuhBM9umzuxETRdbw1Kq1MiUIOCJxds8Mxay
kTGrTRCzM/Zm8es3On0vti1WmTAxznsjYUoKTAgAUss7QeomsC5aMu4xsS0RhpOM
DiIoTe2aHfAM5C3XHFJQli1RnHzSljhcmYifJhQX9clt+ECpVIGJvtvyS6Z8qxTx
NAaWanf30Dt1mzstmiwtJk83V4AnxkwOJHFctiqtz3iW+GmNtOlxhlDz5xdbz/+B
TZhZLQRH1YOs73O4IicU5eDqGDnYot9J793Ha4XVQi5bvpTKLD8p3gQRm8ZExNUo
FPryk31JGbw0429O2fFqF1OLP3R8nPg1PxX0nPEW/p4grI99JtbL7dWyoPVxlIWC
hApVXPX74jWrU+MInKWL
=JuPv
-----END PGP SIGNATURE-----

--xMJbWctQEcNQiBqK--
