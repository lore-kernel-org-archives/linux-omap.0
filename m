From: green <greenfreedom10@gmail.com>
Subject: Re: N810 suspend
Date: Tue, 16 Dec 2008 09:56:32 -0700
Message-ID: <20081216165632.GF25056@swansys>
References: <20081215210823.GD5334@swansys> <20081215211430.GJ10664@atomide.com> <20081216092531.c440dc26.jarkko.nikula@nokia.com> <20081216162951.GP19551@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N8ia4yKhAKKETby7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:38275 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299AbYLPQ4p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 11:56:45 -0500
Received: by an-out-0708.google.com with SMTP id d40so1337374and.1
        for <linux-omap@vger.kernel.org>; Tue, 16 Dec 2008 08:56:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081216162951.GP19551@atomide.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--N8ia4yKhAKKETby7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2008.12.16, 351, Tony Lindgren wrote:
> * Jarkko Nikula <jarkko.nikula@nokia.com> [081215 23:26]:
> > On Mon, 15 Dec 2008 13:14:32 -0800 "ext Tony Lindgren" <tony@atomide.co=
m> wrote:
> > > Well you need to make sure the serial clocks are not enabled. Kevin
> > > has some patches for that in his pm branch. So you'll most likely want
> > > to use his whole pm branch.
> > >=20
> > > Also, you need to make sure you have sleep while idle enabled:
> > >=20
> > > # echo 1 > /sys/power/sleep_while_idle
> > >=20
> > > It used to work, but I have not tried for six months or so.
> > >=20
> > How did you disable the LCD and FB clocks? Does
> > xserver-xorg-video-fbdev from Debian (it works!) do necessary steps with
> > omap fb driver or is xomap required?
>=20
> Oh, I just tested that sleep-while-idle worked when fb was blanked. I
> had a script that forced the LCD off via /sys, sorry don't remember
> the path now. Will be also heading to catch a plane in few hours, may
> not be able to check it right now.

'echo 3 > /sys/class/graphics/fb0/blank' turns off the LCD, if that is what=
 you=20
mean.

--N8ia4yKhAKKETby7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklH3cAACgkQ682C+dBP+oQ3HwCg7CUGwCY5FaUERt6Grk6U4ZCr
aegAoOhJau9B8+sWucDcPIb1ehDAVBAO
=77gA
-----END PGP SIGNATURE-----

--N8ia4yKhAKKETby7--
