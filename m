From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] OMAPDSS: restore "name" sysfs entry.
Date: Wed, 25 Feb 2015 07:31:31 +1100
Message-ID: <20150225073131.7fbff605@notabene.brown>
References: <20150224203706.1eafa129@notabene.brown>
	<54EC5520.1020105@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/2y6vD25nJhPeM6NCrW+sun3"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EC5520.1020105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/2y6vD25nJhPeM6NCrW+sun3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Feb 2015 12:40:32 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
wrote:

> Hi,
>=20
> On 24/02/15 11:37, NeilBrown wrote:
> >=20
> >=20
> > commit 303e4697e762dc92a40405f4e4b8aac02cd0d70b
> >     OMAPDSS: rename display-sysfs 'name' entry
> >=20
> > broke the xorg X server on my device as it couldn't find the display
> > any more.  It needs the 'name' file and now there isn't one.
> >=20
> > That commit claims that 'name' is not compatible with i2c or spi.
> > i2c does register it own 'name' file, but spi does not, hence my
> > problem - I have an spi display.
> >=20
> > So create a special case for i2c: add the name attribute for non-i2c
> > devices.
>=20
> What X driver is that? What's it doing with the display name? Is it just
> using the display name to show something for the user, and the returned
> value can be essentially any string?
>=20
>  Tomi
>=20
>=20
/usr/lib/xorg/modules/drivers/omapfb_drv.so
from package xserver-xorg-video-omap3 in Debian.

I don't know where the main upstream source is, but here:

https://gitorious.org/gnutoo-s-programs-for-shr/xf86-video-omapfb/source/28=
c006c94e57ea71df11ec4fff79d7ffcfc4860f:src/omapfb-output-dss.c#L258

is the code which reads
   /sys/devices/platform/omapdss/display0/name
and fails if that file cannot be opened.

Thanks,
NeilBrown

--Sig_/2y6vD25nJhPeM6NCrW+sun3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVOzfoznsnt1WYoG5AQIXJA/+MupFWgKYdlGwDmK2H+1jh5jUjghewEJ+
oD0+kl2dcyaT8eg60487OSiQa1PiOMxXvEd8Ioabv1vhi2tYmdqK+HtlWa4ZYpPY
iRNFLWb1fQglxDKydQjS/eWOcu1FHqUOq2X+1r/p7QqyYzPqK//CexRlPX3l4T0C
toicpiTExwfgXInMO0q/0Zdxbs6oYFhMZKnRf677bjj2Jp6bGmYVtsbzE3Nbt48s
3wzp8Qo3xXHiHoGKC9S+KpN1OBUy76I9KK38n2X4PZKyqbDYBON5pWosfrVek8Np
RGdHbh0fsfG/5+l5xZe+EWN2aJlHK9avMcbxTt64uawt+NsI/7Kf3UV690T8zlQP
E4gI7CbzTs6UARTV482xyCUgrjNVci3E9J6t47K6PIQYOcDhKjziiE4/+RJ3GRVC
qLPMgqVlFICNU8BBQ6JierrVTTKiNOp8QhyoO56siAYy5ON5MgkCFSKf71BkQJKH
DNcoasDM+7Rsn6PYKzNs7xM7JzAVYLxa87mRTtqzlMhlzqFozxgkfHatow6iPgdC
8rokMJQs7KosfAVmK75Z54qs+xKVr0ON2KYBFyaWtO+1HFdTARM5eH3DaZ9Ik4yd
50otiXpgAewDC/tGNd2oZfAy/f11z6Tl0KD9G6XaEbyiRe1flh/27XqgULoZPfCc
5F8+gX7BXL0=
=MLTu
-----END PGP SIGNATURE-----

--Sig_/2y6vD25nJhPeM6NCrW+sun3--
