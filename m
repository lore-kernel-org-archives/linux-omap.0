From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ARM: OMAP2: Enable Errata 430973 for OMAP3
Date: Thu, 9 Jun 2016 09:57:34 +0200
Message-ID: <20160609075734.GA8595@earth>
References: <1463700017-18527-1-git-send-email-nm@ti.com>
 <20160609071512.GK22406@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160609071512.GK22406@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 09, 2016 at 12:15:13AM -0700, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [160519 16:23]:
> > Enable Erratum 430973 similar to commit 5c86c5339c56 ("ARM:
> > omap2plus_defconfig: Enable ARM erratum 430973 for omap3") - Since
> > multiple defconfigs can exist from various points of view (multi_v7,
> > omap2plus etc.. it is always better to enable the erratum from the
> > Kconfig selection point of view so that downstream kernels dont have
> > to rediscover this all over again.
>=20
> This should safe to select now. Note that proc-v7.S still does not
> do anything with multiarch to configure it. So the bootloader still
> needs to enable it, or it needs to be done in the machine init like
> n900 does.

mh I totally forgot about 430973. I still think [0] is the
better solution. IIRC I never uploaded them to Russel's
patchsystem, though :(

[0] http://comments.gmane.org/gmane.linux.kernel/2002603

> So applying into omap-for-v4.7/fixes as it can solve some mysterious
> app crashers with armhf at least.

Only on N900 though:

$ git grep ARM_ERRATA_430973
arch/arm/Kconfig:config ARM_ERRATA_430973
arch/arm/configs/axm55xx_defconfig:CONFIG_ARM_ERRATA_430973=3Dy
arch/arm/configs/omap2plus_defconfig:CONFIG_ARM_ERRATA_430973=3Dy
arch/arm/mach-omap2/board-rx51.c:#ifdef CONFIG_ARM_ERRATA_430973
arch/arm/mach-omap2/pdata-quirks.c: if (IS_ENABLED(CONFIG_ARM_ERRATA_430973=
)) {
arch/arm/mm/proc-v7.S:#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CON=
FIG_ARCH_MULTIPLATFORM)

-- Sebastian

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXWSFsAAoJENju1/PIO/qaZykP/0jOpMigWbGQphR+VQ7QXp9m
+nWAc0d3DsR7jYOkpXpBQP4TzpiYbqu6AXWeXyDiEYRbxxwyR3VMGsB10GNhDKR8
jKxsxDTtLpj86Hk8ZuOIbHJPkb/dK+QS4wp250N+89s/ZvgsmM5xbeH/FKYSEmvg
csIdyfVh5D19Z0H8EYGfGADzBEDxV5uwveC4qFf82ndDaIgxnVF6dgBs+5oI3aC0
6Sl3QNUX/5iaGnLll3TaRqLnfJS8/nVqYAMA10gO7ZPyEnVaGxluCPLpLvV6D3ui
Z+cnuJy8duo6t13IR42ZDBiRsqDWTtJWMHr1GWhZmQB9pefHOTtH1tdQMEySOz1i
fWDYx/95cBSoSCtBwJTfPBddnBOSd79c3pGSgUh8b0cOQSy+Abg8DchyKD+DUKMb
cAYo9fj+9VhoAbspkBtrPpcvbF34r7w3+CGa/sOmRbkjvBNIJTZUl2gbrbPT/Y0Y
grRWBZd40LFeLuzcdPf1A7PdBz8ivIUtVa1SXHQelD7sQ2CjQA1BshZ+4ZiNKHMw
pgdqaJH53rb29hucgYV44VeppnCOh5jqHDWOabPvPMWjOS2o93yCPJWrm4/TUWxx
L/6aLR/bqHfmoMWQmm/ZBIf/H1Zm+3ROKKtfyz+lzXnTOcFD7Yd9VCo+PAuSUrrC
WUARLGCgN2tlxg4I/ZEh
=2u/+
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
