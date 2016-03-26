From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 06/23] drm: omapdrm: wait for pending operations before
 updating plane
Date: Sat, 26 Mar 2016 16:52:24 +0100
Message-ID: <20160326155224.GA25190@earth>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-7-git-send-email-sre@kernel.org>
 <2247354.2fBg1ifxEX@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2247354.2fBg1ifxEX@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Sat, Mar 26, 2016 at 11:20:00AM +0200, Laurent Pinchart wrote:
> On Tuesday 08 Mar 2016 17:39:38 Sebastian Reichel wrote:
> > Updating the plane may interrupt ongoing display
> > updates, so wait for any pending operations.
>=20
> There's already an omap_atomic_wait_for_completion() call a couple of lin=
es=20
> below, do we need two of them ? Why can display update be ongoing there, =
given=20
> that the previous omap_atomic_complete() call did wait for completion bef=
ore=20
> returning?

This is a preparation for the manual display update. The planes
should not be touched while a manual display update is in progress.

I only checked the patches for the N950's manually updated DSI
panel, but none of the other supported panel types. Since I wasn't
sure what is triggered by the plane update for the other panel
types, I kept the second wait_for_completion.

I guess I will drop the second wait in the next revision and see
what happens.

-- Sebastian

> > Signed-off-By: Sebastian Reichel <sre@kernel.org>
> > ---
> >  drivers/gpu/drm/omapdrm/omap_drv.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c
> > b/drivers/gpu/drm/omapdrm/omap_drv.c index a3ff35f5f6cd..e142a4245766
> > 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> > +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> > @@ -95,6 +95,10 @@ static void omap_atomic_complete(struct
> > omap_atomic_state_commit *commit) /* Apply the atomic update. */
> >  	dispc_runtime_get();
> >=20
> > +	dev_dbg(dev->dev, "omap_atomic_complete");
> > +
> > +	omap_atomic_wait_for_completion(dev, old_state);
> > +
> >  	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> >  	drm_atomic_helper_commit_planes(dev, old_state, false);
> >  	drm_atomic_helper_commit_modeset_enables(dev, old_state);
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW9rA1AAoJENju1/PIO/qaFDAQAIz2+1imTKFLEtnYiQnMT1O1
TFkyKBlZYy5f/g/nYySDAdgPx2IQbGlJWhy3MyKQm3nP33ug+wXbiOOsuV9IMW7f
QX9HooSBlDycm0W+tgKi2xwjn5lri++VKPsZJXMfQDPA7yVWYzYY06D556wBGqSS
hrRO/6vUH6p+0SzHrojabkALimgVRHliBT9uiQT3uO28STxo4QOnrbKgjbdref8Q
Y1L57gNDrvB+2vDyXpB/WP1xsVbtiCkLvy3oHiXnfBXQhuyi2eaigLhezTSXZyW4
pIxogJuNw2zSuuPfLsE3WzMpoBKwVarThuXWpgv8s+suMAES1q4dZPFIIsNRO+BN
PzBvxQeXHV0Mn4dobAsk4ZeSZCjlcaJn+IIwgoBBZ2jtlsxr/RbdkZRrD5ZI2p8/
sjdsNNPEw9W7hv0FkO67AM4Lk0WfNEnp9NjpNc/ehvBdT0pTRHHItt+FxMNqg+QJ
nSug8eczaEvemV7LtpfoUpzrVs8zemZBlwYwJw+9FbjIGGmhJexx+iHImUNdnNKH
DUpmXyDutjv/jIHDXHFFDg0R/xH8fRsiHclMfsuMIbXQyqYX4YKrGgxCrWeEwiiI
jnzw248InW1HRA3Pqqe6dW1Do/RSj0v4/ZvP4f6s4Wu9jKabl7NjROx8xWHJps4e
fjGW8M/4NI7ZNfKK0Pku
=n3So
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
