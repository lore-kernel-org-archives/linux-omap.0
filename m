From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 02/23] ARM: dts: n950: add display support
Date: Wed, 23 Mar 2016 15:01:06 +0100
Message-ID: <20160323140105.GA31703@earth>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-3-git-send-email-sre@kernel.org>
 <21766689.NesyW3QHk4@avalon>
 <20160317174901.GB3864@earth>
 <87lh59pdt6.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lh59pdt6.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 23, 2016 at 02:40:53PM +0200, Jani Nikula wrote:
> On Thu, 17 Mar 2016, Sebastian Reichel <sre@kernel.org> wrote:
> > On Thu, Mar 17, 2016 at 02:14:26PM +0200, Laurent Pinchart wrote:
> >> [...]
> >> > +
> >> > +		/* panel is 480x464 with top and bottom 5 lines not visible */
> >>=20
> >> I assume you mean 480x864 ?
> >
> > Yes, nice catch. Basically the screen is 480x864, but only
> > 480x854 are visible.
>=20
> It's been a while, but I thought the full 480x864 was actually usable
> and visible.

I tried that first and the first few lines were missing. The stock
kernel also uses only 854px:

https://github.com/nemomobile/kernel-adaptation-n950-n9/blob/mer-n9-2.6.32-=
20121301/arch/arm/mach-omap2/board-rm680-video.c

(search for partial_area)

-- Sebastian

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW8qGeAAoJENju1/PIO/qaPXcP/1Z3EdOcNFnbinuBwsKvxslg
o/DhJe/Fz4CxRoBJMFBvSWDR17xb7h9LmaIgr8q8SsC/9gw6I0nQUfdUREvar4oo
umRpbgWjIM6qCqGQ/ulXnGr9SGOTUxJ8F4x+xB8cKSONmhr68xZkvYqgRafcP4A7
U/1XyirnOZfcE02TV3TIruQBHY9FgXuDsDbHHeACAoagUO39ZiBfST/krG376eXf
UMZgiHqFLAFpNPEyABK84WPDqgab4a9k2yDph+3CC4EHu6RntmVXB/6OgF2oMTj5
Z4ggZvvP1DtLmj0y011tjw8EWGIQtimUVSFjU2z3YvASKR0Dx6hVTcetN6JNqce/
yKch81ejoxMe92PlKtA6Xx/xZiQqd+p7lH2Bi5sfNmXf56iux74YMRy7qmtRAa9m
bMbe8MT9tMBVF1DQqBoDaX2TuUeN8sJqj4NnzwWTWUe/9Ewv075L3nQ/lvwnlWVo
Aa/GaZmMSHb4z3H7spdiBDVIiHIV/mw/8UE/jd3Ha4zG/V6wKw7Gq8lNqrIhJeGM
hqg6yvNgTpzwPD5CIOFyN/u2lonzYRM4qJD3JKZLrPhWFmETXmjdzdhpPMFeGRc1
rSUTBs3UqCVhBQUArbY71gwBpDDnde5MetS41t/OisgQFCB3tDfSvRdMAB6RjuHd
bzGpq8bNySr/dihQW+Zs
=nQbd
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
