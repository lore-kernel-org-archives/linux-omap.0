From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/3] usb: dwc3: add a quirk for device disconnection
 issue in Synopsis dwc3 core
Date: Mon, 5 Jan 2015 11:09:21 -0600
Message-ID: <20150105170921.GH19336@saruman>
References: <1418695828-605-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <1418695828-605-4-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <20141222153730.GA12815@saruman>
 <CAJ1gpc3jVpz=5ME4+wCJDW5NKihvB4xYzwi0co=UuPtG9Ubmjg@mail.gmail.com>
 <CAJ1gpc3-Wjtm54WOhO6RXjZft9BMngzyYC0-S-XnTacV-qKgMg@mail.gmail.com>
 <20141229160641.GD29379@saruman>
 <CAJ1gpc0Uu4vS2iA_o_W5NaE_QBWDYFZJio7yKvhpaR5f=qWcGA@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KscVNZbUup0vZz0f"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ1gpc0Uu4vS2iA_o_W5NaE_QBWDYFZJio7yKvhpaR5f=qWcGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb
List-Id: linux-omap@vger.kernel.org

--KscVNZbUup0vZz0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 04, 2015 at 08:55:01PM +0800, Sneeker Yeh wrote:
> > > So far Fujitsu Semiconductor got Synopsys internal case id , that is "
> > > Case: 8000679552".
> > > However the contents belongs this id cannot be referred except Fujitsu
> > > Semiconductor and Synopsys.
> > > Synopsis decide the official errata (STAR information) will be disclo=
sed
> > > next February.
> > >
> > > Would you suggest if this quirk can be accepted with this case ID, or=
 can
> > > only be accepted with STARS ticket number?
> >
> > The thing is that without the STARS number I can't really verify which
> > versions of the IP would be affected. Clearly, it's not only your setup
> > and I think it's pretty unfair to have "is_compatible("fujitsu")" to
> >
>=20
> just found some way of quirk injection i miss,
> does it looks more reasonable if i have to decide to use it via Kconfig? :
> 20f6fdd01c2c0de9cc1109083222edded24c5350
> b2f463e1300016785d63475c56f5807e2be00934

We will only use Kconfig for those which can't be detected in runtime.
LPM is one such case as there's no way for SW to detect that core was
configured with LPM Errata, IIRC.

> > enable the quirk only for you. Isn't there a better way of enabling the
> > quirk based off of revision detection couple with a look on GHWPARAMS*
> > registers ?
> >
> > What's tricking me is this claim that only config-free PHYs would be
> > affected, why ?
> >
>=20
> i'm still struggling now to try to get more information about this.
> some security policy inside Fujitsu make me unable to access full
> information of this errata today.
>=20
> Someday after i get enough information,
> i shall take your suggestion here that seems better to incur quirk
> dynamically via GHWPARAMS,
> and then send it here again.

ok, hopefully you'll find a way ;-)

--=20
balbi

--KscVNZbUup0vZz0f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUqsVBAAoJEIaOsuA1yqREKv0P/Ru1Q/EYlXFalvHJeVmouThA
tBV5RQXIQVBgUYnSKgFmr8dDfSEmY4hw/M3QTEA/v9aHzUBCSzcIWPda4dXrSrI2
i0edd3jGppso9Of5W/v8ruXP5eXIiGOuBCgZ/n2Ew1o16cOArwUu2taSrnBhEvkD
77rBEclp6S4TmtME5TXl+xRpc9zfRd+NMCRKrJU4zh2N3Ny667x7fwHdax3GBoQ2
wctUul5EiWFG3/axEzLiKGs4DPXpbeuOMOCuQdnwnCW03GVoiCM/Z5iJHSO0vyUv
jpD4pAX68KIeHE6hAqblgxNpkJwMmT6239pRyeHDNyXkx7U5jQGwdBmoYK5k6Wyt
ILbax5mWhxi4sLAPOaot2WJjvEcaNYZxMkSDfDTm18arh9qWnwpOVvJ7sClfC5vE
NNJuSAJ65nbtvZB8utVfbB4/PsJ/mOSG9iYNalAVjS6eFQkU9qr3mIpgCX5FaGh+
AJ2k/7MezmiRI1F4IcBrzsfCn32f7mPb4dN3lLQiXqfsSNYBnF27gB1JwzvEa1v4
Yy4MJtsGr+Aj2XJYJKF42JWofK9nbP2IjRc0PqCT6kc2heA2i4se1cFtX/Qi5fWh
XL23pM1mg12nnKdZ/ZmeACY1KrcfFTGyRycWo1kOY9KEXlC1uXWKrwkpA3M67TQe
bG9cNDvCrlUKE8l/pCcS
=S/CV
-----END PGP SIGNATURE-----

--KscVNZbUup0vZz0f--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
