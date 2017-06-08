From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 00/11] Remove unused omap legacy code
Date: Thu, 8 Jun 2017 10:13:05 +0200
Message-ID: <20170608081305.fyxu7tvimox4wbjg@earth>
References: <20170531225139.30723-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4627616783116399560=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531225139.30723-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============4627616783116399560==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3iylotvc24gtnbvk"
Content-Disposition: inline


--3iylotvc24gtnbvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 31, 2017 at 03:51:28PM -0700, Tony Lindgren wrote:
> We can now remove quite a bit of clutter with legacy booting
> gone. Basically anything with of_have_populated_dt() not set
> can now go.

Except for the comment on patch 4 the series is

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> Tony Lindgren (11):
>   ARM: OMAP2+: Remove unused legacy code for opp
>   ARM: OMAP2+: Remove unused legacy code for timer
>   ARM: OMAP2+: Remove unused legacy code for PMU
>   ARM: OMAP2+: Remove unused legacy code for device init
>   ARM: OMAP2+: Remove unused legacy code for McBSP
>   ARM: OMAP2+: Remove unused legacy code for io.c
>   ARM: OMAP2+: Remove unused legacy code for DMA
>   ARM: OMAP2+: Remove unused legacy code for PRM
>   ARM: OMAP2+: Remove unused legacy code for interconnects
>   ARM: OMAP2+: Remove unused legacy code for watchdog
>   ARM: OMAP2+: Remove unused legacy code for n8x0
>=20
>  arch/arm/mach-omap2/Makefile               |   4 -
>  arch/arm/mach-omap2/board-n8x0.c           |  14 +--
>  arch/arm/mach-omap2/devices.c              | 163 -----------------------=
----
>  arch/arm/mach-omap2/dma.c                  |  30 +----
>  arch/arm/mach-omap2/io.c                   |  59 +++-------
>  arch/arm/mach-omap2/mcbsp.c                |  70 ------------
>  arch/arm/mach-omap2/omap_device.c          |   5 +-
>  arch/arm/mach-omap2/omap_hwmod.c           |  23 ++--
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   3 +-
>  arch/arm/mach-omap2/opp.c                  | 104 -----------------
>  arch/arm/mach-omap2/opp3xxx_data.c         |  86 ---------------
>  arch/arm/mach-omap2/opp4xxx_data.c         |  79 -------------
>  arch/arm/mach-omap2/pmu.c                  |  97 ----------------
>  arch/arm/mach-omap2/prm3xxx.c              |  17 ++-
>  arch/arm/mach-omap2/prm44xx.c              |  59 ----------
>  arch/arm/mach-omap2/prm_common.c           |   9 +-
>  arch/arm/mach-omap2/timer.c                | 172 ++++-------------------=
------
>  arch/arm/mach-omap2/wd_timer.c             |  28 -----
>  18 files changed, 63 insertions(+), 959 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/opp.c
>  delete mode 100644 arch/arm/mach-omap2/pmu.c

--3iylotvc24gtnbvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5Bw4ACgkQ2O7X88g7
+pqA2g//eUjevk0oVyVJBAIZzPZb63Yn4C5omUnl6zxnFfqGIRfWtLtJBQrAz9z4
ax3iNOtDMXxro20XWjTxFuiqcZ2n9CYC+MIiBXu3eSG3tuw/cWZ+lsakBoj1z4K/
DXUhMTcMMObUIH5mH0QQYbzS8fvQgdrh7Q6gC1DIMvYtpeVx75kX4NG1ja+/GWiV
Z9CGzwl8PqZ5W4cGaiAlhKopAGYcPs2Du4yjmuyEjabiod5vlBEJ3AreOszfgol2
nC39ymfp7qUsTCSlvTtwrF4PyO7MbZNUpUR28QqtFDBNWiPqahXuNZzNYaIrUU6I
9RHe9ddZP1Of8Os9JcBIs0RwwR27zwbrSQOWpt19fjgUbsC3Oijxz1+EfbpF486l
joWdFO/an9hrVrHoVk4dagzEoibS9zyixWEFbMvj/gZUfu4UU1lBHcHmzwsAaBZ6
1+w53ra/eIc5qahhdiccJlPnSRvqRhSY12x5FUbcCLc2IGdbfzbwc/HiMXJCML35
joO7+hsuH/hIVq486Ck5Ez7MDBnVduDZMoyr4CpL2mnOzAhmYQS3hSHb6GNYkcEx
fmnITFHzAGh/lcz269OiXA5hM4j17cOVsMKLZzt2TuOA+sDtp23VSVxeJWi3DtHb
1WwykjG+fEQLahPYVchbaje10HQIvVRx2XGESd+oBjuNrIY6e+0=
=Cce8
-----END PGP SIGNATURE-----

--3iylotvc24gtnbvk--


--===============4627616783116399560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4627616783116399560==--
