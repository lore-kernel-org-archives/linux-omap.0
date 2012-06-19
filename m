From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv8 13/13] I2C: OMAP: simplify omap_i2c_ack_stat()
Date: Tue, 19 Jun 2012 15:33:52 +0200
Message-ID: <20120619133352.GB18711@pengutronix.de>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-14-git-send-email-shubhrajyoti@ti.com>
 <20120618153000.GC10768@pengutronix.de>
 <CAM=Q2ctOS19ToH7JRLxmEkoz8eUj8umcWFhaTQ-MWBbeh_DHtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41829 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab2FSNeA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jun 2012 09:34:00 -0400
Content-Disposition: inline
In-Reply-To: <CAM=Q2ctOS19ToH7JRLxmEkoz8eUj8umcWFhaTQ-MWBbeh_DHtA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Felipe Balbi <balbi@ti.com>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2012 at 02:50:23PM +0530, Shubhrajyoti Datta wrote:
> On Mon, Jun 18, 2012 at 9:00 PM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> > On Mon, Jun 18, 2012 at 08:00:28PM +0530, Shubhrajyoti D wrote:
> >> From: Felipe Balbi <balbi@ti.com>
> >>
> >> stat & BIT(1) is the same as BIT(1),
> >
> > Not true. I'd guess you are missing some context in the patch
> > description.
>=20
>=20
> See the explanation , hope I understood your concern correctly.
>=20
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70277.html

The code may be right, but as Russell pointed out, the patch description
is very weak. I could read the mail now to understand, but I prefer to
wait for a better patch description. Because I need to ensure other
people reading the git history later will understand easily without
having to search the web.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/gf8AACgkQD27XaX1/VRs6ngCgvceYI8tX6PNSYZgeLlS/jk+W
doUAoIVGvc+cVFxrX7ahIuzsGaQWaCNR
=FLcB
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
