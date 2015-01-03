From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] usb: dwc3: add Fujitsu Specific Glue layer
Date: Fri, 2 Jan 2015 19:21:28 -0600
Message-ID: <20150103012128.GA11373@saruman>
References: <1418695828-605-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <20141222155936.GB12815@saruman>
 <CAJ1gpc0uniw3F3O9nxTLHp9M2boxrOACYDB=fgruhLOLdqg9yA@mail.gmail.com>
 <1456155.YPH2fYoGgF@wuerfel>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456155.YPH2fYoGgF@wuerfel>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgli
List-Id: linux-omap@vger.kernel.org

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 30, 2014 at 11:12:51AM +0100, Arnd Bergmann wrote:
> On Monday 29 December 2014 01:52:04 Sneeker Yeh wrote:
> > > > +static int dwc3_mb86s70_remove_child(struct device *dev, void *unu=
sed)
> > > > +{
> > > > +     struct platform_device *pdev =3D to_platform_device(dev);
> > > > +
> > > > +     of_device_unregister(pdev);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static u64 dwc3_mb86s70_dma_mask =3D DMA_BIT_MASK(32);
> > >
> > > why ? Use dma_coerce_mask_and_coherent().
> > >
> >=20
> > okay.
>=20
> Actually that is still wrong: we use dma_coerce_mask_and_coherent() to
> annotate drivers that have traditionally been forcing their own dma mask
> by some other means and that need to be changed to something proper (after
> finding out why they did it in the first place).
>=20
> Since this is about a child device, the correct interface is to use
> platform_device_register_full().

no, that's wrong. He's essentially fixing the default set by OF core,
which is always 32-bits anyway, so this can actually be removed. Your
suggestion would just make it worse.

--=20
balbi

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUp0QYAAoJEIaOsuA1yqREcjIP/363ej7TuB2etVjKFfJQ3U+l
aK2jFXPVcHoabf1QZ/ikFRByl0VJa7sHfugLjeQjRWf2gl+YgWKCfDkz96fo2M6N
pP5mgtiZR1iVoZ031ZU3yo6DRq1dg7ZL3Wh76q/UysryeDAYO/bcSoDF3WAKWp+A
3VtmAkKgJqZeayUB7bfNo57GQhZEbHKeUGjA4oZ/XSkB+nWUXgshqiN8bJ0XD4Ux
nv5qK2h1FuqTJKzv1qTQnpgORSQWt+3326Snlxle9jhq4/KlSPjvogSROP9Yi+O9
i8teFmTN3YbYMs6Lvzdsi4FUnH3LPHbCNnJVsxYN+TFhS+MoQ5Y2fmecIqziY07m
8+hnh0i9V6MuTQ9ZTKhlHlN5qfEm88ajoq7JltuRA9SEL5Zzd6ISQl4SeaKCb05q
HCKeI+QfTP6dNOhaGbhm7PjBbtIByJNnaQIb9OR1qWh0dbCx86YLtvtVIgsm4u8b
shnwt5yZQPzXTeHh2Shrb1qoW3bZppX9Hta0+UXEqztQW3cne7nlQsjOgvQ41kmP
5XsSPnnetCNk+5xLmxe1/TnQW+ksWe7rtXDIcHnoJo4Jt4yFC+/WqaxxQvyHx852
wcoWW5G00kaGe98QWD4fKhA7oHZAGHLzhcrenQT5rEd+xx8NmPIh0IVgQEu405Kd
jLVtWfc4sckaPBYNCxN7
=lLKe
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
