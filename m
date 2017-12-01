From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv1 03/14] drm/omap: plane: update fifo size on ovl setup
Date: Fri, 1 Dec 2017 13:25:02 +0100
Message-ID: <20171201122502.ynl3aubhsoiatfby@earth>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <20170724173311.27170-4-sebastian.reichel@collabora.co.uk>
 <34c2588e-7d7e-219f-fd34-9a441d46e0cc@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="loywtm66zg2dfhmr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <34c2588e-7d7e-219f-fd34-9a441d46e0cc@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--loywtm66zg2dfhmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tomi,

On Fri, Dec 01, 2017 at 02:10:42PM +0200, Tomi Valkeinen wrote:
>=20
> On 24/07/17 20:33, Sebastian Reichel wrote:
> > This is a workaround for a hardware bug occuring on OMAP3
> > with manually updated panels. Details about the HW bug are
> > unknown to me, but without this fix the panel refresh does
> > not work at all on Nokia N950.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  drivers/gpu/drm/omapdrm/dss/dispc.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omap=
drm/dss/dispc.c
> > index fd7504b37e3b..b6dca5ee34d4 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> > @@ -1398,6 +1398,18 @@ void dispc_ovl_compute_fifo_thresholds(enum omap=
_plane_id plane,
> >  	}
> >  }
> > =20
> > +void dispc_ovl_set_manual_fifo_threshold(enum omap_plane_id plane)
> > +{
> > +	u32 fifo_low, fifo_high;
> > +	bool use_fifo_merge =3D false;
> > +	bool use_manual_update =3D true;
> > +
> > +	dispc_ovl_compute_fifo_thresholds(plane, &fifo_low, &fifo_high,
> > +					  use_fifo_merge, use_manual_update);
> > +
> > +	dispc_ovl_set_fifo_threshold(plane, fifo_low, fifo_high);
> > +}
> > +
> >  static void dispc_ovl_set_mflag(enum omap_plane_id plane, bool enable)
> >  {
> >  	int bit;
> > @@ -2566,6 +2578,10 @@ static int dispc_ovl_setup(enum omap_plane_id pl=
ane,
> >  		oi->zorder, oi->pre_mult_alpha, oi->global_alpha,
> >  		oi->rotation_type, replication, vm, mem_to_mem);
> > =20
> > +	/* manual mode needs other fifo thresholds */
> > +	if (mgr_fld_read(channel, DISPC_MGR_FLD_STALLMODE))
> > +		dispc_ovl_set_manual_fifo_threshold(plane);
> > +
> >  	return r;
> >  }
>=20
> We don't have the stallmode for all channels. And on OMAP2 it's for
> RFBI, and I don't know if that needs different thresholds or not. Also,
> I'm not sure if OMAP4-5 DSI needs this. And I think it's good to mention
> the unknown bug in the comment too. And yes, it's unknown to me too, I
> never figured it out. These thresholds just seemed to work, while the
> default did not.
>=20
> So I think we need to check that the platform is OMAP3 and channel is
> LCD. We can later extend that to cover OMAP4-5 if needed.

Ok. I will have a look at this later today. FWIW I test this
patchset with OMAP3 (N950) and OMAP4 (Droid 4). OMAP4 works
without this patch, but also with the changed thresholds.

-- Sebastian

--loywtm66zg2dfhmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlohShMACgkQ2O7X88g7
+ppfBg//ZLhUaDvPQ9RTsu3o1na/8pBM/vTa9vnDHHopzptw00YDS4f+IBoxRInq
ja4bbPe0JcweGyY2+ZoywAAGS+JH7OR8pv6nbGFyM9R92YPKfANVphPB5kDrKg/+
h5c+4ogUKu8ezDNtMdcu8ZoD45bk/gTOzYJFhBgpWA8JYBZ2JxBPL918U5OrjySC
PCO4jLcc+9zjbZiIIjf+14MlUNtdJpUJrasdUVzQS1v2oPpk4lCGiy64wNWtpjAU
KVVtws/hiCyDpPFD1QNGx+Z0TtKAEyOYaLUJldvtMwzm//+SGuDkg6jmJM9J0wFp
fIwPfsettkiXMk2yFcsweEBVtaNKDpee8H4xsHMux29qvO+azLv4V7ydYlGqYwsQ
i3iCklgzAay6uGgp18jQHzVZE9+/dvWIDbhBH7x7hpDyBvriHDTahmMYwHgYl5ig
LOyET979SiSyYdQIB9Hr9XpcJn9s/dZBLFv2O063EEExDh3JThq02rKId+kpXbmv
n3iJWzzvucka64GFD8chzWyH58dUCVl/zjYeTQad2e3tYz/suzDesA9Z8l3Xde96
F8U9315d17yFITUWmnfQN9K+mk2oB+jsZOmR4fHlru6t10+MA9GdCCPgxPmw+BMO
1pwxa5dYlORvMKKDiaGfwHrNBsMY2PG/XsgwKrI64Lb+Gz7I6O0=
=eAqg
-----END PGP SIGNATURE-----

--loywtm66zg2dfhmr--
