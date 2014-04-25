From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 10/14] HSI: Introduce driver for SSI Protocol
Date: Fri, 25 Apr 2014 20:49:01 +0200
Message-ID: <20140425184900.GF22721@earth.universe>
References: <1396053110-21639-1-git-send-email-sre@kernel.org>
 <1396053110-21639-11-git-send-email-sre@kernel.org>
 <20140419194936.GJ5148@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140419194936.GJ5148-tWAi6jLit6GreWDznjuHag@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon-uiMcrn6V0Vs@public.gmane.org>, Joni Lapilainen <joni.lapilainen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Carlos Chinea <carlos.chinea-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2014 at 09:49:36PM +0200, Pavel Machek wrote:
> Hi!
>=20
> > This adds a driver for the SSI McSAAB protocol as used in
> > the Nokia N900.
> >=20
> > Signed-off-by: Carlos Chinea <carlos.chinea-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>=20
> > +#define SSIP_MIN_PN_HDR		6	/* FIXME: Revisit */
> > +#define SSIP_WDTOUT		2000	/* FIXME: has to be 500 msecs> */
>=20
> Can they be fixed now, or do they have to wait?

I would prefer to wait. The timing above works and having it in the
git history doesn't hurt.

> > +#ifdef __LITTLE_ENDIAN
> > +	((u16 *)skb->data)[2] =3D swab16(((u16 *)skb->data)[2]);
> > +	dev_dbg(&dev->dev, "RX length fixed (%04x -> %u)\n",
> > +			((u16 *)skb->data)[2], ntohs(((u16 *)skb->data)[2]));
> > +#endif
>=20
> Uh. Can this be replaced by
>     ((u16 *)skb->data)[2] =3D htons(((u16 *)skb->data)[2]);
>=20
> (without the ifdef?)

Yes.

> > +	/*
> > +	 * Modem sends Phonet messages over SSI with its own endianess...
> > +	 * Assume that modem has the same endianess as we do.
> > +	 */
> > +	if (skb_cow_head(skb, 0))
> > +		goto drop;
> > +#ifdef __LITTLE_ENDIAN
> > +	((u16 *)skb->data)[2] =3D swab16(((u16 *)skb->data)[2]);
> > +#endif
>=20
> Here, too?

Fixed in PATCHv4.

> But it looks like the comment does not match the code, because we
> swap.

The swap only converts the package length field from/to network byte
order. I think the comment still applies for the other actual message.

I added a comment for the length field and kept the other comment as
is for PATCHv4.

-- Sebastian

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTWq4cAAoJENju1/PIO/qauXgP/AkArax6cNzm05x6VkLTcVwX
sa+/H1kHdryPo8l+jiQyu6qcPA8gTnPIPXfEBN+ZwafamFlKgci47KYeCf+YDE1o
IBbfoKZ/SFrzYCCON90HbayBBG/GoSK9ycFz1gdEwb37PTsgiIgo/507o8AzAljQ
0Pl0mhLLXVi71OcevNwWA4+bO6xUl7HkNT1NoVafYZrHhTR7VDQ/D97y/4lH4mMz
tT7ApT2sgtC8UwDc76hQaB1SXjQVjUa3pNs+7B1oOO9EfGbgcnelCOlva2ImD6vh
YhIRfxb/DWpsRBMWuFkT3AB/vmIZ/aelxnvdCZryPQgdqGCKzBBAhHkkTjHa8oLT
jjnlw52k2gthzH1G3f4ZZAuAHh1ZcZ9P5YScYkjNSIHgy9x6MMrMxA+T4NEPhOoW
KBXvwpnqqhIFGn1chWTHOCd6o+LW2+/frfQwh4riD2duO4OGW8te367vaC5FNL80
EJB5RAzpdQlsywEBAwKL2975XIL4rgtjgK371dCCLTOlWOybguaMAeoER7Mdy/kc
jlkrf3MmQ+pKknR0kEX52ArvQfTLKjRrj3E3jvknkmAHWTqHinECEt3ta96QGdEb
5JLEY3TQAhacft7eHh628i7VBoICcPoNqOSxHORmKML2RYrw8vkGavuR1iWtamWg
MEb7Foi2ZH2LwxKtPK4b
=cBwO
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
