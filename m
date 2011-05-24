From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] USB patches for next merge window
Date: Tue, 24 May 2011 13:04:56 +0300
Message-ID: <20110524100455.GA14371@legolas.emea.dhcp.ti.com>
References: <20110518110353.GH13908@legolas.emea.dhcp.ti.com>
 <20110518114242.GI13908@legolas.emea.dhcp.ti.com>
 <20110523061346.GD3095@legolas.emea.dhcp.ti.com>
 <20110523101515.8c47e7a2.jhnikula@gmail.com>
 <20110523081524.GL3095@legolas.emea.dhcp.ti.com>
 <20110524085244.GE30799@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41354 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753187Ab1EXKFE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 06:05:04 -0400
Received: by fxm16 with SMTP id 16so5714788fxm.23
        for <linux-omap@vger.kernel.org>; Tue, 24 May 2011 03:05:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110524085244.GE30799@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 24, 2011 at 11:52:45AM +0300, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110523 11:11]:
> > On Mon, May 23, 2011 at 10:15:15AM +0300, Jarkko Nikula wrote:
> > > On Mon, 23 May 2011 09:14:38 +0300
> > > Felipe Balbi <balbi@ti.com> wrote:
> > >=20
> > > > a gentle ping here too. Without this we will have regressions on
> > > > ehci/ohci as the pm_runtime patches have gone in via Samuel.
> > > >=20
> > > Does this mean that those regressions happened already when those
> > > patches were made if there is pull request dependency?
> >=20
> > not really, no.
> >=20
> > > Remember bisectability is important. And very important if you are
> > > bisecting something else but which is dependent on this as then you
> > > could mark wrong good/bad points or not able to determine.
> >=20
> > True, true... I just wanted to avoid conflicts as much as possible so
> > arch/arm/*omap*/ goes through Tony, and drivers/mfd/* goes through
> > Samuel.
> >=20
> > pm_rutime and hwmod conversion aren't really that tightly coupled. As
> > long as the arch code is in place, we can do pm_runtime at any time. Not
> > sure if it's true the other way around. But one thing is for sure, if
> > this pull request isn't taken, then I guess clocks won't enable on
> > omap-usbhs...
>=20
> Looks like these patches are missing acks from Benoit and Paul?
> I'd rather not pull them in without the acks. Note that we have
> a very short merge window this time, so let's see if we can still
> get them in.

Ok... let's see if they'll Ack the patches which have been floating
around. [1], [2] and [3] are the patches which need Ack.

[1] http://marc.info/?l=3Dlinux-omap&m=3D130512838504191&w=3D2
[2] http://marc.info/?l=3Dlinux-omap&m=3D130512862104681&w=3D2
[3] http://marc.info/?l=3Dlinux-omap&m=3D130512812503806&w=3D2

--=20
balbi

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN24LHAAoJEAv8Txj19kN1NmwH/3cLhVrLOAcDk6kyM3R15J7k
2MBku7LpxFGm6AsEpAgHhEP23f2goTb4W+yRpLA6jLn5vpntGVYRQVbHiaj4l86z
nU1OCjOji2+L9fM3HX5Y/fOqSaxatwn399xHehQhXc7kr3K7zXk4PsGOOw4GcayK
RCDU91HR75BL5iZhmYwx5TWAZ89qic5WRcetVURwqXDBZNt3zsu9z5bHFwMk0UFp
GLFxw4tlYW4ytaYVtnYSZHE3Wbt8Ej2nb9Z8vu4oRQwPDW54M/n8W6qs4DIlY7Te
zxykT8JG37xyxcKjqwouKVNz6PIWJTWikDdfQWJ456zkMn0+uHVX9u151y7tKig=
=Yz/8
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
