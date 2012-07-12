From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv11 0/6] I2C cleanups
Date: Thu, 12 Jul 2012 14:52:29 +0200
Message-ID: <20120712125229.GG2194@pengutronix.de>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <CAM=Q2ct0PUisYGcaX6EAPWT-SmZAgRV_O8mAOodH-V4Q0O-Vww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38559 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab2GLMwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jul 2012 08:52:35 -0400
Content-Disposition: inline
In-Reply-To: <CAM=Q2ct0PUisYGcaX6EAPWT-SmZAgRV_O8mAOodH-V4Q0O-Vww@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2012 at 05:17:07PM +0530, Shubhrajyoti Datta wrote:
> On Thu, Jun 28, 2012 at 8:41 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wro=
te:
> > This is a minimal cleanup series.
>=20
> If there are no further comments can this series be queued?

I just applied a few of them. BTW I get a build warning when compiling the
kernel, maybe someone is interested. It is not related to the patches, thou=
gh.

=3D=3D=3D

WARNING: arch/arm/mach-omap2/built-in.o(.data+0x2b5c0): Section mismatch in=
 reference from the variable rx51_si4713_dev to the (unknown reference) .in=
it.data:(unknown)
The variable rx51_si4713_dev references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

=3D=3D=3D

I think this is what I'll pull in for the next merge window. The big OMAP
cleanup (latest version from 3. July) would then go in early into -next for
3.7. Is that OK with the omap-people?

Also, thanks to Shubhrajyoti Datta for reviewing other patches on the
i2c-list, much appreciated.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/+yI0ACgkQD27XaX1/VRtyJQCfVIMDkXaeybjBRKj+WTIDP/Ie
XYMAnj2BAPID8vxQiHkKPqgQp41jGiVr
=0gin
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--
