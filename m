From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: add runtime PM to set_cs()
Date: Fri, 24 Jul 2015 17:39:46 +0100
Message-ID: <20150724163946.GN11162@sirena.org.uk>
References: <1437590769-14632-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TA910QTX7AD8TylE"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437590769-14632-1-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--TA910QTX7AD8TylE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2015 at 08:46:09PM +0200, Sebastian Reichel wrote:
> Since commit ddcad7e9068eb omap2_mcspi_set_cs() is called without
> runtime power management requested. Thus the below kernel oops may be
> generated if a device is accessed after the runtime power management
> timeout. This patch fixes the problem by requesting runtime power
> management in omap2_mcspi_set_cs().
>=20
> [   13.933959] Unhandled fault: external abort on non-linefetch (0x1028) =
at 0xfa09802c
> [   13.940490] pgd =3D cfb38000
> [   13.946594] [fa09802c] *pgd=3D48011452(bad)
> [   13.952758] Internal error: : 1028 [#1] PREEMPT ARM
> [   13.958862] Modules linked in: tsc2005(+) omap_sham twl4030_wdt omap_w=
dt
> [   13.965332] CPU: 0 PID: 183 Comm: modprobe Not tainted 4.2.0-rc1+ #363
> [   13.971801] Hardware name: Nokia RX-51 board
> [   13.978302] task: cf572300 ti: cb1f2000 task.ti: cb1f2000
> [   13.984924] PC is at omap2_mcspi_set_cs+0x44/0x4c
> [   13.991485] LR is at spi_set_cs+0x5c/0x60

Please don't paste entire backtraces into commit messages, they are very
large and almost entirely noise (for example in this case the entire
explanation is in the commit message itself).  If you feel a backtrace
helps clarify things then please present an *edited* highlight of the
relevant sections.
present

--TA910QTX7AD8TylE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVsmpRAAoJECTWi3JdVIfQ6ZQH/1cYJQE/fY4/OCRRu8Ey5nSc
m9jwFnrTrSwp4eUqEiYQwa1Z7cXAVAWNd29M6k19PGYYRMGU0H5CqRlQX23kTFjk
u9Rsk+yBXzpO2hon9xKfxrdTc2pn8Qlv6LGY1vHWBtKUdgcbI/9qn/PcgC/D8bTf
subeq+9QB0LzUnzrwne71F31tmWjwTPIfOZ0E4Nqmz/MzdFPrqTtmjPUn2xs0OIW
0IYRcBWsvvCT2YRiHDBSinfSm0R3bDLX8R5nHKEPg6FqPj/FSBcVq9HWrw3YxGRM
h5vi2EU4eVMWg6dxiLVdMfMb2nkTgTF0FutjgiBJEmHPRwEhooqBLsJk4c9wxJA=
=KCak
-----END PGP SIGNATURE-----

--TA910QTX7AD8TylE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
