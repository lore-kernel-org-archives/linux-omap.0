From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: MMC/SD cards hotplug scenario
Date: Wed, 21 May 2008 20:32:02 +0200
Message-ID: <20080521203202.6d84a02b@mjolnir.drzeus.cx>
References: <004e01c8bb09$989fac00$538918ac@ent.ti.com>
	<20080521073017.GB23427@flint.arm.linux.org.uk>
	<005d01c8bb25$63345fe0$538918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-24515-1211394661-0001-2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from server.drzeus.cx ([85.8.24.28]:35478 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751360AbYEUScw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2008 14:32:52 -0400
In-Reply-To: <005d01c8bb25$63345fe0$538918ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-24515-1211394661-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 21 May 2008 15:01:00 +0530
"Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com> wrote:

> What I meant here is that reinsertion of the card does not seem to result=
 in reinitialization of the card consistently.

Previously, that has always been because of bad interactions with the
block layer. 2.6.24 should be more resilient though.

>=20
> Details of few things I noticed is listed below stepwise and to start wit=
h card is detected and mounted on mount point /mnt/mmc dir.
>=20
> 1. Start copy of data.
> 2. Removed the card in the middle of transfer. At the controller driver l=
evel this generated card removed interrupt. The
> mmc_detect_change fn called.
> 3. I/O Errors generated.

The obscene amount of noise here seems to be caused by ext2 being
extremely persistent. This is generally a good thing for your data
though. :)

What is missing is a decent way for a block device to tell the upper
layers that is gone with no hope of ever coming back. Right now we just
tell it that there was a write error, which just makes the upper layers
retry and retry.

> 4. Reinsert the card. This generated card inserted interrupt. The mmc_det=
ect_fn called. But the card does not seem to be
> reinitialized correctly.
>    cat /proc/partitions does not list mmc partitions.
>=20

Anything in dmesg?

>=20
> So my question is for the above scenario does the MMC/SD core need to tak=
e care of anything explicitely or should this be fixed at
> the controller
> driver level?

Host drivers shouldn't have to bother with any of this for the simple
reason that there should be no state inside the driver except for the
current request. Keeping track of cards and block devices are handled
in the core and mmc_block respectively.

Rgds
Pierre

--=_freyr.drzeus.cx-24515-1211394661-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkg0aqgACgkQ7b8eESbyJLg/1gCg4HNjlR6m//cpON5HkTFQmMKF
bYgAoL02qzJhHQpOiL7RNrsFJOACl0CD
=+u3N
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-24515-1211394661-0001-2--
