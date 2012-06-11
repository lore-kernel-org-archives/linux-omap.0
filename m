From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 09/12] ARM: OMAP2+: usb_host_fs: add custom
 setup_preprogram for usb_host_fs (fsusb)
Date: Mon, 11 Jun 2012 10:48:56 +0300
Message-ID: <20120611074854.GG6845@arwen.pp.htv.fi>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004617.20034.21714.stgit@dusk>
 <20120611063416.GT12766@atomide.com>
 <20120611071301.GC6845@arwen.pp.htv.fi>
 <20120611074133.GZ12766@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na6sys009bog002.obsmtp.com ([74.125.150.44]:49327 "EHLO
	na6sys009bog002.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752366Ab2FKHuy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 03:50:54 -0400
Received: by lagu2 with SMTP id u2so2743278lag.12
        for <linux-omap@vger.kernel.org>; Mon, 11 Jun 2012 00:50:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120611074133.GZ12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 11, 2012 at 12:41:33AM -0700, Tony Lindgren wrote:
> > > This should be "static inline int fsusb_reset_host_controller" as it's
> > > in a header.
> >=20
> > why is it even in a header ? Only hwmod_fsusb_preprogram() will use it
> > anyway.
>=20
> Well ideally it would be something that any OHCI driver can use for
> it's reset, and whatever bus code can also call to reset and idle
> for the unused devices that don't have the driver compiled in. Got
> any better suggestions where to place it? I could be a generic
> ohci_reset function in some header?

maybe create <linux/usb/ohci.h> ? Then, while doing that, move register
definitions to this new header too... Something like:

$ mv drivers/usb/host/ohci.h include/linux/usb/
$ sed -i 's/\"ohci.h\"/<linux/usb/ohci.h>/g' $(git ls-files)

then add your ohci_reset() function...

> I don't want to have driver specific code under arch/arm/*omap*/* as
> the bus level code should not need to know anything about the driver
> specific registers.

I see.

--=20
balbi

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1aLmAAoJEIaOsuA1yqREg3EQAKpsuuYKf0+3W/tp35o8sq/Z
UCU81ZOZWLqJlQIQp6q8eBfX2u/CdE+NzOXIFnI/hk2UYWYnR/ooPNVN08jTvCpd
iLWiCI60/ciqWTjGlbueYB51ud7JD9yT6YmlyF/ICvXP371CkTjc3d3sqk+PjgWH
GgfcJMkKouRkSczvVfLN03Fl8gIqZvH6DHj+pQCBYedo2KTGoymOvLw4kb/eNpE4
Ul188n2uRO/sQ4Z7a0CzsFThRk2r5JGCInX0fn7Clupyf9zmfH4MbF9kE6yr1G+E
Skg/4i5UYhQI6STkmzKxmPnDMFaQwdZxGrS1gTC9Bvj3GT7Z2hukfMYIb8zbYeZz
G7EUgKB7G0qt6CROsEI5WWqpXQqMAPlbj72wVQWbHdI1TkED8ZXKiPjjw/y9pQuw
AwJNJr0qU7ssTDKV+vztLAQFfGawqhtsc8nOi8k9z4gP4xko3IuFyaEsltXLgKfb
9EHzhrblNaJnIAUW5tOb7qgncEI//rf8w9BFOBDwDz4ZZYn2I+lWmiatinPnNakq
yqMSGo52FZwW6lwtd2/vY1ceRpp9Rklk4lxm/YGUjzCKA0KDB6KLiE/kucJxrNBm
eTV/PtiM64a7jRp8jfz6WNQb5fUkUbaK5d+D0xHAHrQoELwlGunxEleIOInGzl5j
YfDRZMPdOHhILTaEtA0u
=6T/V
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
