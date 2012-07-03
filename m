From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RESEND] usb: otg: OMAP4: Fix the omap4430_phy_set_clk
 function
Date: Tue, 3 Jul 2012 19:13:51 +0300
Message-ID: <20120703161349.GA23380@arwen.pp.htv.fi>
References: <1339522581-8124-1-git-send-email-ruslan.bilovol@ti.com>
 <20120702081358.GF16670@arwen.pp.htv.fi>
 <CAEa47NokHNwkpoM-7q1BoxsNw7Cfr+qd7YsvJ2VKriHEU-A+og@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEa47NokHNwkpoM-7q1BoxsNw7Cfr+qd7YsvJ2VKriHEU-A+og-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 02, 2012 at 08:10:49PM +0300, Ruslan Bilovol wrote:
> Hi,
>=20
>=20
> On Mon, Jul 2, 2012 at 11:13 AM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> >
> > Hi,
> >
> > On Tue, Jun 12, 2012 at 08:36:21PM +0300, Ruslan Bilovol wrote:
> > > If the clocks are enabled and we want to enable them again
> > > omap4430_phy_set_clk disables them.
> > >
> > > Fix this - so now if we try to enable already enabled clocks
> > > it works correctly.
> > >
> > > Signed-off-by: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
> > > ---
> > >  arch/arm/mach-omap2/omap_phy_internal.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
> > > b/arch/arm/mach-omap2/omap_phy_internal.c
> > > index 4c90477..0196683 100644
> > > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > > @@ -97,7 +97,7 @@ int omap4430_phy_set_clk(struct device *dev, int on)
> > >               clk_enable(clk48m);
> > >               clk_enable(clk32k);
> > >               state =3D 1;
> > > -     } else if (state) {
> > > +     } else if (!on && state) {
> >
> > why don't you let clocks be enabled twice then ? That would cut down the
> > churn.
>=20
> Currently we have unbalanced call of this function.
> I meet first during musb initialization - it tries to disable the phy
> that leads to disabling already disabled clocks.
> Next goal is to use internal clocks counter and to throw static
> variable 'state'.

don't even go that way... what you need is to fix the unbalanced calls
instead of hacking around some generic API.

--=20
balbi

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8xo9AAoJEIaOsuA1yqREWN8QAJHkZx0F5ms2gxtQ2A33G2xD
NfoIi1sYqckKxkDyg4Y0n5YONTMTHqwz6kxowwOQC2KcqJJe6Jms6wWJ9/ebY8vT
6IYZyEpaGZFBJCUCAOjTH32pWXJ1lMMFBABpk0GmZu6pgJv40eTqHVrZv2h96WWS
vRA2sgKJV40vzQ8Eos4NP36tdo5IFxu0rb10KSNkICVYRZai5rtYZSiAknHafES+
N4WBNE1ijbSAVAH0Rf96lS1Js2DOqUEaCvf1/XvWmhVasEpcHKARnoKnqRpkgw51
BvLqKnfPC4t2RLDzwgmAMbiIpbEzcqWt7S2O9eZyIHO7RQcPuxStNMMwFC1g0Gsz
gZpWZD+qdgAnVb9YrTm7aXghVtrEdhL43a1XaPbpH29rY++GOPOnaIKSKRcWOXdB
/uG6Vi+6Ay1mIHJr3Q+L9Jk82VTup5Yueb8vSlc8SozCLlR0fmhoKF4MfESj2Utf
F2F/K/kG52tXWzNYkY11eis+xxqpIppqBOKWr+Qw2ykMu7z5lkbqPAgQYjC5ATMc
L+jYT/Dv3fTBBpn+JmgSVnPLiKYpC75v4Ut9OelPkLzyV7gWgz8zJcXUpSU4FBro
MkDCg/n7Hwa9unWmKHMF/N0T+b4yIPY6pZUx2I2gqhilxn6Md9tLvLC9kjXIZOKt
+AB8VeGCQAw61MIiElcl
=GU0T
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
