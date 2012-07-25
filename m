From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 01/11] usb: musb: add musb->id to identify core
 instance
Date: Wed, 25 Jul 2012 15:20:29 +0300
Message-ID: <20120725122028.GV16794@arwen.pp.htv.fi>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-2-git-send-email-ajay.gupta@ti.com>
 <20120725121128.GO16794@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAE5B87@DBDE01.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZUxj+kVYsk1YKJSS"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA93EAE5B87-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--ZUxj+kVYsk1YKJSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

On Wed, Jul 25, 2012 at 12:19:32PM +0000, Gupta, Ajay Kumar wrote:
> Hi,
> >=20
> > On Wed, Jul 25, 2012 at 05:37:19PM +0530, Ajay Kumar Gupta wrote:
> > > diff --git a/drivers/usb/musb/musb_core.c
> > > b/drivers/usb/musb/musb_core.c index 89d1871..f5eb8a7 100644
> > > --- a/drivers/usb/musb/musb_core.c
> > > +++ b/drivers/usb/musb/musb_core.c
> >=20
> > <snip>
> >=20
> > > @@ -1889,6 +1921,7 @@ musb_init_controller(struct device *dev, int nI=
rq,
> > void __iomem *ctrl)
> > >  	pm_runtime_enable(musb->controller);
> > >
> > >  	spin_lock_init(&musb->lock);
> > > +	musb->id =3D pdev->id;
> >=20
> > I fail to see where this musb->id would be used. Care to clarify ?
>=20
> Sure, It is used in musb_init_debugfs(). Please refer 02/11.

Then it's a bit unnecessary right ?

You can change the directory name to dev_name(musb->controller) as that
will already have the id appended to it.

--=20
balbi

--ZUxj+kVYsk1YKJSS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD+SMAAoJEIaOsuA1yqREOv0P/RIjE4AeL+E3mPC0P1JvVCMC
eHjvaAou35i5VqZudiwyLS04rmqNoNpntq7i7Gz2DDyrym9vyyjpXgQfYQm1PS5M
AwofE93rCBr2B1UbbCvlDiB3bN/g6k3rW5ot36Lcl+irxnrmQ5RgA8AR6Kc6RG8+
eNXjCbsbSayJFns9qo2ZGI0KV8Mdw77JQCnCMyJNYEHhaQLQTXlWYFk+Sk0lrGYU
khxmVA9bFWA2pJKtPjtPfJdiHQ2MHrmRIXfjefYfLnICZAqaLSVU6MsODGIfiP22
XorBKZBU/xxsmzqTgwObDwXiRg6ySDFLTOZE884mzq6175Y/FDS81tDPNY8ZkH07
N90YI1p4yOzTe8uPYG3XlUBk5YLAYiBR/T2qhtaGqnO3AGySD9YtejQLORbWS0bg
+htRthLPmdTiJd9pPd/LkroY9M8cjCKgNKZThnQwBQzoNNpSZVaBBW77cLLTMHvU
T4+DwDMNuL9WkBOwkB5qEzMdCfeQscyMoerqOVGHyvS+BP79aYMSoWbxlns1Vwtz
o69pqcvSji6fUpIB6X404hnjHZjYhxD9B0HFSPqxEQShfjrbmQVpAJmOSviQMxRn
Er9dEP1AkQr+D0GgpkF15Q8VFNDTKVcb9wFyI0vzsrgh4kHS4UQMP9489dR545hb
F4Dh6lNprxBw70zBTqQZ
=pGlI
-----END PGP SIGNATURE-----

--ZUxj+kVYsk1YKJSS--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
