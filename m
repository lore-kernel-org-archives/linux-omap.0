From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv1 00/14] omapdrm: DSI command mode panel support
Date: Thu, 8 Feb 2018 19:30:59 +0100
Message-ID: <20180208183059.uynz4nwfzyz2oed7@earth.universe>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <5c747b23-c586-4997-cf92-2725483343c5@ti.com>
 <20180208094105.GB4595@amd>
 <7202f913-8048-885a-ac90-eeb49a3bed31@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fxcs5yvanxpca5ip"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7202f913-8048-885a-ac90-eeb49a3bed31@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--fxcs5yvanxpca5ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 08, 2018 at 12:53:16PM +0200, Tomi Valkeinen wrote:
> On 08/02/18 11:41, Pavel Machek wrote:
> >> I've also picked patches 7-12.
> >=20
> > It seems that part of the support made it to v4.16. Is it supposed to
> > be complete?
> >=20
> > I still have these in my tree, and result works on Nokia N9. Is there
> > any way I can help with the merge?
>=20
> I picked the patches that seemed safe to pick. I think we can do another
> review round if someone rebases and posts the patches. Although I see
> that they have conflicts with other patches that have been posted, so
> we'll see how it goes.
>=20
> Btw, you seem to have something in your tree that was not in the series.
> Nothing in the series touches mipi_display.h.

I have a rebased series based on recent origin/master. It works
properly on Droid 4 (omap4), but has issues on omap3 even with
the fifo bug fix applied. I do not yet know the reason, but I
think we should proceed anyways. I originally planned to send
this based on rc1, but will do so now.

-- Sebastian

--fxcs5yvanxpca5ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp8l1kACgkQ2O7X88g7
+pq8wg//UUjS8R4lQ/72MFGaBsqUBCszDjW/0zwDQ8GhfeOoOLnHadVQ9aeplWdE
8rJ3izpf+DmRkl33sDgsq51WHv6LuLHqEjMuhEbOgOUeA/6hAq/0MegM+qpWHbjE
cK2rSM/j0BXCYw3y4gaVqKVpkB8sNoxiYVM8vGdpgJFLRuPMb+n7U6+kh4Y6ITyc
ez5eZI5ujYFUyxFdv1vZ1uorfH+m70LVNy1JwiS98lfZr8tDAMHJ/s6iHppvrum4
T3ffpUG2Ct8LIDGfTB1Bf3g1QRV5TB9R5QC2gcbG2ZYfasCUJMNXsZyHJkpRROoD
bujuc1PKPgwHfPNRkarE5N3gxK/V56cH+KqCCEG+KEbSJ3QBN+yoxHdjEdNYE5bO
+0DzPb/LDsTrT1dbfl63jxsc7lOt1wCws3bB031D70CFkJcI7DTaOLB1lLqMxenD
q1lQ4D6CzvUCv557ASs9+8YtFhwAI/Uo929ooTzUFKFh9s4oXGSesgYQAyge3Iqb
n8yDRoYmrKRFU8DgZj8oOp2wZYkXRnk4ilIrkPKcyWOAOXcaRdiZuZjTpLNu91Rj
qYqz0V2LMUmRKmv0qZNbLRiJ02+h1LWT2J9L68u3M6RXQQ6IzFmcYEsde2EaDgP8
+jJMb3ei7W+RJRsiDNFqO/bwrAU8Oll6VpGAr681e2B7qY0vuWY=
=sRfS
-----END PGP SIGNATURE-----

--fxcs5yvanxpca5ip--
