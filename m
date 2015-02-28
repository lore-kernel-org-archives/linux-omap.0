From: Felipe Balbi <balbi@ti.com>
Subject: Re: am335x: USB DMA IRQ issue
Date: Sat, 28 Feb 2015 15:57:46 -0600
Message-ID: <20150228215746.GA10010@saruman.tx.rr.com>
References: <CAGm1_ktamp-L8nb7UzGvha6EkEfAnDtv3unPE1th9RjK7RkG1g@mail.gmail.com>
 <20150224163612.GA25042@saruman.tx.rr.com>
 <CAGm1_kubHLEA=wbJ81iHeJ9shnUSjdE4H7L=VYORyMiUH2sLsQ@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54023 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbbB1V6N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 28 Feb 2015 16:58:13 -0500
Content-Disposition: inline
In-Reply-To: <CAGm1_kubHLEA=wbJ81iHeJ9shnUSjdE4H7L=VYORyMiUH2sLsQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Felipe Balbi <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 28, 2015 at 10:39:49PM +0100, Yegor Yefremov wrote:
> On Tue, Feb 24, 2015 at 5:36 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, Feb 05, 2015 at 12:19:23PM +0100, Yegor Yefremov wrote:
> >> I have a problem with my am335x based board and USB.
> >>
> >> Kernel: Linux version 3.18.1 (YegorYefremov@development1) (gcc version
> >> 4.9.2 (Buildroot 2015.02-git-00797-gf1b07c0) ) #1 SMP Thu Jan 15
> >> 15:31:27 CET 2015
> >>
> >> I took two devices and equipped them with USB WLAN cards: Bus 001
> >> Device 003: ID 148f:5370 Ralink Technology, Corp. RT5370 Wireless
> >> Adapter. One device as AP and another as client. Client makes
> >> permanent ping to AP. And from time to time I start nuttcp session.
> >> After 2-3 days I get following errors:
> >
> > 2-3 days ? oh man... :-)
> >
> > Here's one thing to try. Can you do some variable size pingtest ?
> > Something like below should do ?
> >
> > random()
> > {
> >         size=3D$(dd if=3D/dev/urandom count=3D1 2>/dev/null|cksum|
> >         cut -f1 -d" "|tr '-' '\0')
> >         size=3D$(expr $size % 60000)
> > }
> >
> > num=3D$1
> >
> > if [ -z $num ]
> > then
> >         num=3D10000
> > fi
> >
> > while ! ifconfig usb0 >/dev/null 2>&1; do
> >         printf "waiting for usb0\n"
> >         sleep 1;
> > done
> >
> > ifconfig usb0 192.168.2.14
> >
> > for i in $(seq 1 $num); do
> >         random
> >         printf "%d: \t pinging with size %-27d" $i $size
> >         if ! ping -c 6 192.168.2.15 -s $size -q -i 0 >/dev/null 2>&1; t=
hen
> >                 printf "FAILED\n"
> >                 break
> >         fi
> >         printf "PASSED\n"
> > done
>=20
> Still haven't tried your test, but have seen this interesting
> patch/proposal http://e2e.ti.com/support/arm/sitara_arm/f/791/t/404743.
> Seems to be somehow related.

patch makes sense. If you can make sure it really solves your problem
then send it as a proper patch on top of my testing/next, I'd be glad.

At some point, I'll just split dma callback into dedicated rx and tx
callbacks to avoid confusion in the future.

--=20
balbi

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU8jnZAAoJEIaOsuA1yqREDP0QAJi5ZSGwxSPaFDdm9jN2P570
9nHP8O/f1/mPKhZ1zLgKfLlafREV6XkMe8vHBkw01f/irGsWCoDF6HdBdRlhs/z8
ifGCgfpQdcX/5EFMurGP5gUv9vbyi4hYrapjBtQBu2j8XQfaNZIaaTNzhx3Bo9Xp
cvFaHC+KTeW4ehkg6sA6iRl8+Ygo55YtbG1ZwV9Xsj47OOHcvQbiCRbZfiyG+wgi
HiARcjDksW4nVqvvCFoLFabdJoNxry3g8s+C5a0KIHEm0mfMfk2GFxWBPdKTIc0m
8cys3vHpI7OrAZfj+blsXsMXntDwnoTa2N1WY/ubVd1WqCBqc8v4efQe0+Wo+35E
33vii8WHLezVP7jMzCDzNVhlwOVDVQKMaDC1US5fltVGx70Ka+L99NOYxERwDZ+p
17KDJT97KIJTEmECWMpawy4FRfZzqwNVFwlz+J2MRq1cxdLH4/tOslKJJ/k2Xgj7
Rr9R+5Kv+FHvTU6JCAnWMIIGgMW5sWxTCdkwUjEWbLB5sCnKLBeETYSOdPm3TYjj
PYM2sDs/8ChMv1hib/gkfQ1WmPtrrYB8d/skYIHjlc6bRMlKqSRU6t4qbC+tbMiQ
3kjx1cR2Z+C1ocgoV43OJmLCULhzfDuxPVLA0mGZnLO2qYZQhxQsO8gpbaljGQ94
iD7mgc9M6JUGGMN23KCP
=R6Rs
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
