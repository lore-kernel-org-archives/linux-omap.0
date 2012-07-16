From: Felipe Balbi <balbi@ti.com>
Subject: Re: PM/UART 3.5-rc5: UART Rx wakeups not quite right?
Date: Mon, 16 Jul 2012 11:40:03 +0300
Message-ID: <20120716084002.GN7955@arwen.pp.htv.fi>
References: <WC20120705133859.690032@terrafix.co.uk>
 <87boju2s8x.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yAzUYvkKIfeS0jQX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48576 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750937Ab2GPInA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 04:43:00 -0400
Received: by lbbgg6 with SMTP id gg6so7458519lbb.36
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 01:42:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87boju2s8x.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Felipe Balbi <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--yAzUYvkKIfeS0jQX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 05, 2012 at 07:32:30AM -0700, Kevin Hilman wrote:
> "Joe Woodward" <jw@terrafix.co.uk> writes:
>=20
> > Are there any patches floating around to fix UART Rx wakeups for 3.5?
> >
> > I have a GUMSTIX Overo with various things hanging off the UARTs, one
> > of which (on ttyO0) sends in periodic (GPS) data.
> >
> > I don't want this data to wake the OMAP from system suspend.
> >
> > I would normally disable UART Rx wakeup for ttyO0:
> > # echo "disabled" > /sys/devices/platform/omap_uart.0/power/wakeup
> >
> > This works on 3.5-rc5 (i.e. I can suspend, and not immediately wake) UN=
TIL
> > I run an application that opens /dev/ttyO0.
> >
> > At this point when entering system suspend ttyO0 wakes the OMAP up
> > immediately, even though the SYSFS reports the wakeup as "disabled".
> >
> > Any ideas?
>=20
> Sounds like a bug.
>=20
> Unfortunately, the OMAP UART driver is currently without an owner as far
> as I know.
>=20
> Felipe, who is looking after the UART driver now?

you said it right. It's without an owner. Joe, any chance you could help
by bisecting the problem down to a commit ?

--=20
balbi

--yAzUYvkKIfeS0jQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQA9NiAAoJEIaOsuA1yqRENx8QAKZPLNdhbwhMmZ1UywdEdFr8
EV54czPUnGr6Usu4PFL0Rojef67Pw80iRU0XA+gT36pJDrk8lak11k6ueJKlucsz
vYRf75Jr8+66XiM6I2/5kidBZe6MaknvtUoOsVd9MJEN4a88QFnWXMXLFIVlZVZL
ykB/9h4bGttgu9pXQz7/60WYElA3G1+izKYx3L2Y3Jbg8VVzelf6B/56Mb+5brAk
cU8jPtF/vruB7JUs4/AzLgShjHQ4ck9R85I+icwIV/hU3t9x1n5wrDXY6IZAalt5
fQeNBvt5JY2Tn0me/WL8Q1MWU4ESBvgQUYPZjqnDbVQz1mzfJ5MptgS+mYICzeO9
6UQmzMuOD53f9hbWEi7hDX47+UP/+z1JxgjAIMYiMThtKs4pmfHmx+2RWsV7UFn2
8LRO+c4EyrTyMLJZSbhrfdmuQ91TMaLuPkM7u/Ri1G/Wk2F3S4wbSAptKPZo5Gau
6rsc63EXLimFkWirlI/8C8z9Y7OroUSEpcqLznplefmbX5GVRkNde3eupqjDbT+Q
KyIaQHDJZewHn/IFmNIXzJff9qDY36Vv5jDyRYekB2MKVjbYOkUxFdQbgAZfcr9y
0oXN7v781+RqVy8NsXyb4vV/3JwQSePzJoIbKc+UwtCyKZxdrL3/4YYZ+5P4hLdv
vp8YicHIzmyUphMLTCBU
=aFtb
-----END PGP SIGNATURE-----

--yAzUYvkKIfeS0jQX--
