From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 1/3] arm: omap: use generic implementation
 if !od
Date: Fri, 15 Feb 2013 18:04:50 +0200
Message-ID: <20130215160450.GC20334@arwen.pp.htv.fi>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <871uch7g15.fsf@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48333 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593Ab3BOQFD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 11:05:03 -0500
Content-Disposition: inline
In-Reply-To: <871uch7g15.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Fri, Feb 15, 2013 at 07:28:22AM -0800, Kevin Hilman wrote:
> > @@ -796,13 +796,18 @@ static int __init omap_early_device_register(stru=
ct platform_device *pdev)
> >  static int _od_runtime_suspend(struct device *dev)
> >  {
> >  	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct omap_device *od =3D to_omap_device(pdev);
> >  	int ret;
> > =20
> >  	ret =3D pm_generic_runtime_suspend(dev);
> > =20
> > +	if (!od)
> > +		goto out;
> > +
>=20
> Rather than adding a check for every function, I think you will get the
> effect by simply not hooking up the PM domain.
>=20
> IOW, in omap_device_build_from_dt(), conditionalize:
>=20
> 	pdev->dev.pm_domain =3D &omap_device_pm_domain;
>=20
> then none of the callbacks will be called in the first place, so they
> won't need to be conditionalized.
>=20
> Without a PM domain, they will fallback to the bus level hooks, which in
> this case will be the platform_bus hooks, which will just call the
> pm_generic functions.

good point, let's just sort out the other comments first though ;-)

--=20
balbi

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHlyiAAoJEIaOsuA1yqRE5TYQAIByHN46dalD/bVNpW5Xr0vU
sNxcBdLF+//7IWr3Vo+MurVrpe/JQKgSnXMkVUa0kUu7fuYJOkIS99PEvWmHamEG
X0VlkHZUq5MsjQtFT0EDzJxgWs8pq8z0YLDXk6RwcNbbOqXPCezWksA9cALPRNDe
vYOHwsRD2YaQ1ImqmwgQiYPxDMN4RykE8ANr94wPqG4qjNq7f34iCEJnQZ/RxhVs
9H3fs6UEgoJo7iLj/ALHvLxUIbSFTDVGMVFQAlxYlrUO6dCGE9xJRrQwG8wTklUG
u8pPvclOJKaiWQ7RHu8SEvpzWRdnVO8okrL5TAsRMJE9L7v2UokO0xGWK65sBMB4
Y2M2NCGyf51Mp9J5YkH1CH32/OeXhyimkZuN3MQnwb8u3MlRH+kJoJhJzQtIV5Zo
A82wggp4+6h2wLEOJswPU5NQFHurMI4//PxdP8S2X3cRli9aIZb5ZCtM2wCEDX29
jMRAU8u7MOrwEc4XtaDPGwzihTMuIQyCWslpHD7tl2Kq4m9GpnvVH0syob520kAW
3QE/MgyVTh9Iuv03KI4Rokj6pRtMlTTE5E1NYwYJAKe31zufXx+Wkez7EYU3Zhy2
H/hoFPqaO9eAptYCLEg1zw3rCbXEku/ZmFUev5B7r3kDXc20ytRNuRhAde943AWK
eH6wSrd2cO9gFbz+IE/w
=CTJd
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
