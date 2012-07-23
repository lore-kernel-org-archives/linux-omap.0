From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] usb: otg: OMAP4: Fix the omap4430_phy_set_clk
 function
Date: Mon, 23 Jul 2012 13:36:37 +0300
Message-ID: <20120723103636.GQ8265@arwen.pp.htv.fi>
References: <1339522581-8124-1-git-send-email-ruslan.bilovol@ti.com>
 <20120702081358.GF16670@arwen.pp.htv.fi>
 <CAEa47NokHNwkpoM-7q1BoxsNw7Cfr+qd7YsvJ2VKriHEU-A+og@mail.gmail.com>
 <20120703161349.GA23380@arwen.pp.htv.fi>
 <CAEa47NpZu77b8dWOPOvGjPpZyNHQGvLAmVKmF40Beox-ugA1rA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VjP/dwTbBl6I9PQk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:36839 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752056Ab2GWKjq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jul 2012 06:39:46 -0400
Received: by lbbgg6 with SMTP id gg6so8174834lbb.36
        for <linux-omap@vger.kernel.org>; Mon, 23 Jul 2012 03:39:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEa47NpZu77b8dWOPOvGjPpZyNHQGvLAmVKmF40Beox-ugA1rA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org


--VjP/dwTbBl6I9PQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 05, 2012 at 08:16:54PM +0300, Ruslan Bilovol wrote:
> Hi,
>=20
> On Tue, Jul 3, 2012 at 7:13 PM, Felipe Balbi <balbi@ti.com> wrote:
> >
> > Hi,
> >
> > On Mon, Jul 02, 2012 at 08:10:49PM +0300, Ruslan Bilovol wrote:
> > > Hi,
> > >
> > >
> > > On Mon, Jul 2, 2012 at 11:13 AM, Felipe Balbi <balbi@ti.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Jun 12, 2012 at 08:36:21PM +0300, Ruslan Bilovol wrote:
> > > > > If the clocks are enabled and we want to enable them again
> > > > > omap4430_phy_set_clk disables them.
> > > > >
> > > > > Fix this - so now if we try to enable already enabled clocks
> > > > > it works correctly.
> > > > >
> > > > > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> > > > > ---
> > > > >  arch/arm/mach-omap2/omap_phy_internal.c |    2 +-
> > > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
> > > > > b/arch/arm/mach-omap2/omap_phy_internal.c
> > > > > index 4c90477..0196683 100644
> > > > > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > > > > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > > > > @@ -97,7 +97,7 @@ int omap4430_phy_set_clk(struct device *dev, int
> > > > > on)
> > > > >               clk_enable(clk48m);
> > > > >               clk_enable(clk32k);
> > > > >               state =3D 1;
> > > > > -     } else if (state) {
> > > > > +     } else if (!on && state) {
> > > >
> > > > why don't you let clocks be enabled twice then ? That would cut down
> > > > the
> > > > churn.
> > >
> > > Currently we have unbalanced call of this function.
> > > I meet first during musb initialization - it tries to disable the phy
> > > that leads to disabling already disabled clocks.
> > > Next goal is to use internal clocks counter and to throw static
> > > variable 'state'.
> >
> > don't even go that way... what you need is to fix the unbalanced calls
> > instead of hacking around some generic API.
>=20
> Okay Felipe, I understand your position and agree with you. However,
> right now the 'hack' that I'm fixing works incorrectly.
> So while we do not have replacement of the 'hack', it will be good to
> have at least fixed version of this 'hack'.

the problem is that once it "works" nobody ever looks into this again.
So, sorry but I can't accept anything other than a real fix

--=20
balbi

--VjP/dwTbBl6I9PQk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDSk0AAoJEIaOsuA1yqREFbEP/1GueTELhvpiKOj4x/NLZVRP
gZ+g9i6YuSjLLk5s82/mnkl8VqaSQkk1t4O2c8XimwWCMtr46Cc2rSq0vtcIxdMG
XV7SAsOLZNEL9aIp4wmUNfzWw6bA9e1WiDgNCQRtBBFES+AbixNu6Dp3o/IN8xBX
9SUAww6wHDMO6x9JoxZwKfKCD66Uc1Czd87+Gf6aCinV4fKozvBsL/H+n0wgizN1
ScTfKS3DWfajbHkTwExZRZp9pPj7SLcxNzF1H3t7q8wxRUL+DmL5TBXpchQo0ZsI
kl2k0PxRWaAq0FR4617NREnB4x6pEzeAmuSFWujPVUxoMjLnc1rtKCqPKFTQlREd
rg6n+R9gy+9omEeOEG+A0IK+1ZAA3LO0c07xEvH7/9ra1iKXSEsJdmwP+2RS5OzG
xPM6RFcm5/oQeMgg5wxwoPwczUcP/59l429Qj6by7g4kfw7lNfsYaQOqDjIVq8W8
qPz5nfMNWBY4YWHZrxsKAjXrvCUkYfEtFlPEWoHwQS6CbTjRGLac1acOD7szkuLc
0Ny+Ks+dxMcUHXYOJmV7JRIbl5BY5HBlBvpKdMaxgnJavCiRew6tuJlMF73VW2gx
6RqRAV9r0npaQAAMRgUHG2N6fOLNdhH5YEp6CSVQ649RowOXNl7nIY4hg119MJ3v
3HRG1/HkhXtO9vqp1QK9
=6AyO
-----END PGP SIGNATURE-----

--VjP/dwTbBl6I9PQk--
