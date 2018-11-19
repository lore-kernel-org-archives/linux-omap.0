From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCHv4 5/6] drm/omap: add framedone interrupt support
Date: Mon, 19 Nov 2018 13:05:20 +0100
Message-ID: <20181119120520.qaw6qyxyirjahzcn@earth.universe>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
 <20181115230645.15748-6-sebastian.reichel@collabora.com>
 <20181117210840.GE22813@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bqwzwua6ufld5yke"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181117210840.GE22813@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--bqwzwua6ufld5yke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 17, 2018 at 10:08:40PM +0100, Pavel Machek wrote:
> > This prepares framedone interrupt handling for
> > manual display update support.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks.

> > @@ -217,6 +239,9 @@ static irqreturn_t omap_irq_handler(int irq, void *=
arg)
> > =20
> >  		if (irqstatus & priv->dispc_ops->mgr_get_sync_lost_irq(priv->dispc, =
channel))
> >  			omap_crtc_error_irq(crtc, irqstatus);
> > +
> > +		if (irqstatus & priv->dispc_ops->mgr_get_framedone_irq(priv->dispc, =
channel))
> > +			omap_crtc_framedone_irq(crtc, irqstatus);
> >  	}
> > =20
> >  	omap_irq_ocp_error_handler(dev, irqstatus);
>=20
> Will the mgr_get_framedone_irq(priv->dispc, channel) change from
> interrupt to interrupt? Would it make sense to cache result as a
> micro-organization?

Maybe. But this is the same for the the omap_crtc_error_* and the
driver is currently being restructured by Laurent. I think this can
wait for later.

-- Sebastian

--bqwzwua6ufld5yke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvypv0ACgkQ2O7X88g7
+ppzRxAAh8Bdr0nPl+lmrsqr+40IJjkCTfyFxcSB8tUlfluEvE9mpEPKJB75orDo
oYUkT1DzUN4ZoMtmcmi5QnPdx2uREOBxcO/05nzG9ZJzSL1Ev7eVOR/h1AntZTRQ
C9bATio97Y7dThnMee2jlBhPFboDAbsR+ti8QKBIAsgT15tMgWL6JWnOR3UB7wLX
pFSF0RJAq5jKTbG77VFZLQKaIIvaXsthX6vZk2jhlOFBg+LJzBZ6B3QyqE54qiC6
8Ql3IUenw+/IDp2Lg9ELhwmVQJSCJclSejeG2TJMEF+tfODen3eS48PEVTflvojR
qQ880glUkuxHD59lXdFyCB7OUNSJWObYfheReL/omOl+CHXSAU4hJZp1RQpoNntH
mM/oa0ecaPLwfUUEf8l0dbPPeLLl581WvuRhOnlRkRtWDZ8WiCT2VBZQRDQ/9vgn
HtPCkZrWxUy/qzM6/Txl08BjPa/16HrWNzEW+2xtn2Fp8jQ3kHLwdmCZqX59s3wH
xaeuSCY6zaqeoP12OmdxXt0GcUYC/R0vVHtdQdbedguvyDTRUABcmZs49VxUancJ
IAMB8pYQDJHkEWmm8v89UvdMg4guyECETiLwrVsRTEOWMQXg45Q1wrJLQWywUOT4
Iu4sYw0ifXt0vIiWmqKrwaXkDONE5LpwRE+cJQiy/qPtzApOkMY=
=LJsg
-----END PGP SIGNATURE-----

--bqwzwua6ufld5yke--
