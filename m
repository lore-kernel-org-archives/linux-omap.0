From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from
 driver
Date: Fri, 15 Feb 2013 15:07:45 +0200
Message-ID: <20130215130745.GC16558@arwen.pp.htv.fi>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <511E323E.3050104@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33050 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161302Ab3BONIB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 08:08:01 -0500
Content-Disposition: inline
In-Reply-To: <511E323E.3050104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a0131647 <sourav.poddar@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, balbi@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2013 at 06:33:58PM +0530, a0131647 wrote:
> Hi,
> On Friday 15 February 2013 05:36 PM, Santosh Shilimkar wrote:
> >OMAP UART IP needs manual idle modes based on state of the
> >IP. Currently this is handled by the driver with function pointers
> >implemented in platform code.
> >
> >This however breaks in case of device tree because of missing
> >idle handling.
> >
> >The series tries to address the issue
> >
> >Patches has been tested on OMAP4 and OMAP5 devices where the console
> >slugishness was observed without idle mode handling. CPUIDLE and
> >suspend tested ok on these devices.
> >
> >Need help in testing on OMAP2, OMAP3 and AM3XXX devices.
> >
> Tested this series on omap3630 beagle board for:
> 1. Retention in idle and suspend.
> 2. Off mode in idle and suspend.
>=20
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>

try setting autosuspend_delay to -1

--=20
balbi

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHjMhAAoJEIaOsuA1yqREdEMQALHpH2afQAUg7ITZOqI/egXh
RjudN5VNoLbLS3Pqfkvj5NdXO5MW2pvhOef9nmlQwiUIoI2+DifRJGmGg1ulncF+
A3qK5w3nZ/NcEgbVvIeHHAWsgkHFLgK5DfawgcvwtTgOCr7rvuiTAP/BFFjWn9ds
l2/YXfin4aF2EOJae6B8PDUj1ZmKD8yFesastheUdn0Y7IJYwEJgUV7oiQdiTPau
BcPSmmv+xL2+eASIBgopk5LJjgdLqArNSs2sKWkMbD5X4ykKnWaIHPgz0TDJi/iG
RbO3IVdh+EpQHzATDidS9pSkx8Vc9nasAmQ/IEtvWJDh3ah3EqTGb1irVNpEcjmY
pZz2TTu8aJzzCU9DrEotm2vqPZtcboLbaHqvLQ/mYWPMbXnkOSmYS6FQ5qViFmFc
noreVO+twtZpko8YTXky/M0cnt/q+ftUo1AzRA5sPaEcom3X6lZBZt/BfMcUbivw
zq/SA4PJR8judFn2Lt9gmDfipKpMmw07uLBeCp451/2GDZBj2+VIlDiTKENoES8c
/wwSF3td/n8lgpIrfPADizcQTImx9tRk++CmQ0TcXhHX0ywjgVwonK0R/U4PWVyC
4j6jWYxgNf+MAHXhzy268H8wbZvUSdDVTCKnB24U02w1sC1Njt3I+8QVSOE807Pn
mbzDoG0ZVXBiYUAbfZRg
=qnWF
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
