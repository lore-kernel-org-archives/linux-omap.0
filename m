From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Display on Nokia N950 was Re: Serial cable N9
Date: Wed, 1 Nov 2017 22:59:01 +0100
Message-ID: <20171101215901.GA18151@amd>
References: <b05ead6d-3996-3bfc-8f09-09d0229a79b3@gmail.com>
 <20171030074816.GA31977@amd>
 <1cbe2c73-754d-f0c5-1732-b306c7f86f85@gmail.com>
 <20171030205232.GA28601@amd>
 <0f4b8908-7421-6481-8415-3563f347b9de@gmail.com>
 <d3682a85-7910-78fc-407d-fdd333a1d60f@gmail.com>
 <50c15c96-36f5-1e1b-0538-9c758919141c@gmail.com>
 <20171101193220.GA14009@amd>
 <2851c57a-7aba-ddab-3201-03d91fdfa040@gmail.com>
 <20171101214618.GB1636@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171101214618.GB1636@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, airlied@redhat.com, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > For the record, display does not work for me in 4.14 on either n9 or
> > > n950. I did not investigate that, yet.
> >=20
> > On v4.13 framebuffer console works OK (I haven't tested anything more in
> > fact), but somewhere between v4.13 and v4.14-rc1 there is a commit that
> > breaks things - my best guess at this time after a partial git bisect is
> > that 906dde0f355bd97c080c215811ae7db1137c4af8 is the one to look at.
>=20
> Confirmed. Reverting the merge (as far as it can be reverted) gets me
> booting N950 with working display. (With 906dde applied, backlight
> goes turns on, so it looks like display driver is initialized, but
> then machine is killed, probably by watchdog).
>=20
> AFAICT N950 display never worked on mainline; I'm using Sebastian's
> patches to get it to work.
>=20
> Linux n900 4.14.0-rc7-28884-gdf7c8f0-dirty #283 Wed Nov 1 22:31:35 CET
> 2017 armv7l GNU/Linux
>=20
> Filip did all the work here, thanks!

Reverting just fc5cc9678e130196012c17b37e555d53d3d3476b fixes the
display for me, too.

commit fc5cc9678e130196012c17b37e555d53d3d3476b
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Wed Aug 23 12:19:02 2017 +0300

    drm/omap: work-around for omap3 display enable

    Seems that on omap3 enabling a crtc without any planes causes a
    sync
        lost flood. This only happens on the first enable, and after
    that it
        works. This looks like an HW issue and it's unclear why this
    is
        happening or how to fix it.

    This started happening after
    897145d0c7010b4e07fa9bc674b1dfb9a2c6fff9
        ("drm/omapdrm: Move commit_modeset_enables() before
    commit_planes()")
        which, as a work-around, changed omapdrm first to do the
    modeset enable,
        and plane set only after that. This WA should be fine on all
    DSS
        versions, but apparently OMAP3 DSS is an exception.

    This patch reverts that work-around for OMAP3 DSS.

    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
   =20
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAln6Q6UACgkQMOfwapXb+vIkgwCgspypo0U/9sFoTXK7qwXeUDqx
PVMAoLKcNMAtpxA5SCnUnNB7VNMJhdxw
=9WD1
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
