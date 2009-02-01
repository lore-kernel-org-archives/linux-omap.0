From: zmc@lurian.net
Subject: Re: TI omap850
Date: Sun, 1 Feb 2009 11:17:24 -0400
Message-ID: <20090201151724.GA25266@polaris.lurian.net>
References: <e7c6a05e0901311138t8e37768ya8e47f5fb8f2d728@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lurian.net ([64.209.10.12]:45468 "EHLO polaris.lurian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbZBAPRf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 1 Feb 2009 10:17:35 -0500
Content-Disposition: inline
In-Reply-To: <e7c6a05e0901311138t8e37768ya8e47f5fb8f2d728@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: linux-omap@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2009 at 08:38:12PM +0100, Belisko Marek wrote:
> Hi,
>=20
> I'm trying to port Linux on HTC Oxygen (omap850). As start point I choose
> previous port at:http://vivien.chappelier.free.fr/typhoon/index.html

You may want to try our linwizard branch.  We've been working on
it for many years now and have (mostly) working support for keyboard,
mmc, framebuffer,  bluetooth, touchscreen and some basic support for
gsm / wifi in the works.

> I try to modify tft driver for my board but with no success. I'm still
> missing some
> variables in  lcd_panel structure.

We have a few panels setup in our code that might work for you,
but many devices are different, even ones with the same model often
have different screens.

> What important is still missing is pixel_freq parameter.
> I have an egg and chicken problem. Rootfs as initrd is not working
> (don't know why)
> and display also not :). So I try to focus on display.

How are you booting, haret or EOL, or some other method?
=20
> I dump some memory regions with Haret to get clock detailed infos.
> Dumps:
> ARM_CKCTL=3D0x6506 is different from the settings in
> the linux kernel for CONFIG_OMAP_ARM_195MHZ (0x050e).
>=20
> DPLL_CTL=3D0x2fb3 is different from the settings in
> the linux kernel for CONFIG_OMAP_ARM_195MHZ (0x2790).
>=20
> For retreiving of pixel_freq I can use
> function in lcdc.c lck =3D clk_get_rate(omap_lcdc.lcd_ck); but
> I'ts hard for me to find how clock on OMAP is working (very complex
> for beginner).
>=20
> Could you please clarify this to me and also why values ARM_CKCTL
> and DPLL_CTL are in kernel set differently (compare to wince).

Honestly I can't.  Clocks were really alot of trial and error for
us, and it took a long time to get things working.  Also now the
kernel is redoing the clock framework, so I don't even know where
to start.

Please take a look at linwizard.sourceforge.net

also we have a git repository up on polaris.lurian.net and that
gets mirrored every 30 min by gni (hosting company) see=20

http://linwizard.wiki.sourceforge.net/How+to+help

The precompiled kernels linked on that page no longer exist. The
repo is alive and well though.

=46rom polaris/gni the "candidate" branch is linux-2.6.25-dirty
it has a lot of nasty debugging things enabled and the code is
not very clean, but we have a lot of driver support working.

The new "for-tony" branch represents clean minimal patches
to get the 850 booting off of mainline linux.  As of this writing
that is based on linus's 2.6.29-rc2.  Please note that the
"for-tony" branch does not have compressed image support in yet
so use an Image instead of a zImage if you test.

There is also a gitweb running at:

http://git.lurian.net

There are a lot of precompiled packages and "gizard" userspace
distributions at:

http://tinderbox.dev.gentoo.org/embedded/linwizard/

And we usually are available on irc (irc.freenode.net #linwizard)

> thanks,

HIH
=20
> Marek

zmc

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkmFvQQACgkQZhRzv0gWXLkoXQCeLUDJfUillhNGdQzwiOkYe3IY
HDgAnig+AsXrIV7ngx8pr+Lbk3LICWiG
=HXsw
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
