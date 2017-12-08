From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv1 00/14] omapdrm: DSI command mode panel support
Date: Fri, 8 Dec 2017 19:01:44 +0100
Message-ID: <20171208180144.j7lu6jnmathusqen@earth>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <5c747b23-c586-4997-cf92-2725483343c5@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7gmqrckmv2cnkimv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5c747b23-c586-4997-cf92-2725483343c5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--7gmqrckmv2cnkimv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tomi,

On Fri, Dec 01, 2017 at 02:58:13PM +0200, Tomi Valkeinen wrote:
> Hi,
>=20
> On 24/07/17 20:32, Sebastian Reichel wrote:
> > Hi,
> >=20
> > This adds support for command mode DSI panels to
> > omapdrm. I tested the patches on Nokia N950 (omap3)
> > and Motorola Droid 4 (omap4). This is basically
> > PATCHv3 of my series adding N950 display support,
> > but I started from scratch without reverting the
> > removal of manual display update support.
> >=20
> > Tested:
> >  * Framebuffer Console
> >  * Display blanking
> >  * kmstest
> >  * Xorg with omap and modesetting driver
> >  * No updates send when nothing needs to be sent
> >=20
> > Known issues:
> >  * Proper display rotation support
> >  * N950 (and N9) has first and last few lines
> >    covered by plastic, so we should expose a
> >    smaller screen
> >=20
> > I plan to look into these issues once basic support
> > has been merged.
> >=20
> > -- Sebastian
> >=20
> > Sebastian Reichel (13):
> >   [A] drm/omap: remove unused function defines
> >   [A] drm/omap: drop incorrect comment
> >   [ ] drm/omap: plane: update fifo size on ovl setup
> >   [ ] drm/omap: add framedone interrupt support
> >   [ ] drm/omap: add manual update detection helper
> >   [ ] drm/omap: add support for manually updated displays
> >   [A] drm/omap: add support for physical size hints from display drivers
> >   [A] drm/omap: panel-dsi-cm: add regulator support
> >   [A] drm/omap: panel-dsi-cm: add physical size support
> >   [A] drm/omap: panel-dsi-cm: add external backlight support
> >   [A] drm/omap: panel-dsi-cm: switch to gpiod
> >   [A] ARM: dts: omap4-droid4: improve LCD description
> >   [ ] ARM: dts: n950: add display support
> >=20
> > Tony Lindgren (1):
> >   drm/omap: panel-dsi-cm: fix driver
>=20
> I've also picked patches 7-12.

Thanks. I just wanted to rebase the remaining patches on your
branch, but I don't see those patches in linux-next and your tree
does not seem to be updated properly either:

https://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git/

-- Sebastian

--7gmqrckmv2cnkimv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloq04MACgkQ2O7X88g7
+popFQ/7Bs8bPNtnrFn4lDDR252XBQ1P/p4nf3AhQ9LGx8aBnT9qbSbo09jA/hK2
7FUjZpsj38qyWzpqYtMwX4FBmUvFilB9uZjTZhjs0u9o6Xg801jLlY/GJ3TkYdaA
KXkBnc7k+ZmjPbHjMLCOfvwGUGKHUABSYTOxkBHMJNzpRe7b9ibUS4Sug32kCtBR
ZktWtQoKdi2jKaVTjgFmtTasDo90zP6XHQ3t0q4z1d+V0Rzf2KFby7vty7vBdwhh
dRtZOjK1IY6S5cEg6MZA3Qmg5FeXg8E7bPm3OU9kneqHk9J6xXD7B6uZnGAiv/MA
satW66OgzhBgEpjhrKl7gC//8PwT/tZyQkwiltiopvTqdxHDmREhsVAa1Mjqh9NU
jZOHErwt7oWWU6Fqoil+bWvEjfgXlCKdz3kC1M3sEZ3b99NvSG2sGeYA/WLbGY8C
QNRA3rCB9w+Kgw6tGRE/08kOgDxXGwvAPVw8d5EyrJzc/yuU+tWWaS6eXT0ln5yU
HNpN+I8Q79WFwtaiAprc646cNPbXY3JBzqm64BwFlBxX7EDwDgPELeZQzFdDLNwF
JKQf1VbWSx3K3Z1jyncBY1HdXRaYL4gDUStvXvBMQZKrit8uU6165jPAHmC09Tlv
1gksmuw2IFoMeEtcOiAM0yZAFjuEIfxkpItwAN5hg0Zn45dxbEo=
=0djj
-----END PGP SIGNATURE-----

--7gmqrckmv2cnkimv--
