From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RFC] usb: dwc3: Get PHY from platform specific dwc3 dt
 node.
Date: Thu, 31 Jan 2013 17:25:27 +0200
Message-ID: <20130131152527.GE4064@arwen.pp.htv.fi>
References: <1359631232-7107-1-git-send-email-gautam.vivek@samsung.com>
 <510A56BF.3040804@ti.com>
 <CAFp+6iFkb=U0CJA=3zmQvd5XfMwbROuRJjXoJG7zvvq4_upzNw@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFp+6iFkb=U0CJA=3zmQvd5XfMwbROuRJjXoJG7zvvq4_upzNw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vivek Gautam <gautamvivek1987@gmail.com>
Cc: kishon <kishon@ti.com>, Vivek Gautam <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 31, 2013 at 08:53:27PM +0530, Vivek Gautam wrote:
> >> Moreover, SoCs having multiple dwc3 controllers will have multiple
> >> PHYs, which eventually be added using usb_add_phy_dev(), and not
> >> using usb_add_phy(). So each dwc3 controller won't be able to
> >> get PHYs by simply calling devm_usb_get_phy() also.
> >
> > No. We have added usb_get_phy_dev() for that purpose in the case of non=
-dt.
> > I think, instead you can have a patch to use devm_usb_get_phy_dev() her=
e and
> > in exynos platform specific code use usb_bind_phy() to bind the phy and
> > controller till you change it to dt.
> >
>=20
> We have dt support for dwc3-exynos, in such case we should go ahead with
> of_platform_populate(), right ?
> But if when i use of_platform_populate() i will not be able to set
> dma_mask to dwc3->dev. :-(

do you have a special need for dma_mask because OF already sets it.

--=20
balbi

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCozmAAoJEIaOsuA1yqRE8dcQAJg0lVwckcCffjdNCGKZtf1w
/gLLZ0jUx7vbzTsVvS/UVVAtIvnVcr7ICYzKsY6yK8xj0YC9K0eY1A74Lv9WOrym
h6hFprN3j7xa7su7WRtBwyANjEI1FncbeNkft04oPOkVFSh+qB7WvuZpgF4dN+aU
8lbDV1Jiku0y5lpQgLnLC98NwQl++SLNtw2TOFpsL5r9Yu+eHVjmWideCEBgAIbB
/QJ3uw9tv36DUY9xr+KRY5AJuhvq5RkAyTgNQHsslBfrJVt26QPzK/gHSmzrcyHr
CiMdToSfAfqkCu/BUiv4jL2/6C0O6eGHzPkF/Z9usrX9Fa68mJjHlDWomFiDpttP
MChkBPzP02HNWnx3vKoJIRYExM0mQ3WDXccO2D9WpZJwT6UbFegiXjo2dO7ASPlI
o/EWZS/65d38CXQOK+tSZxmbcKpmncVpljU4nDB4JCtB1qWID1VZeMpy5lo6RlGD
oYLaFflEQr4rxuTtYbIEexK18l7bFX2FSPMUQkJQfgrbFGT+w5wBjRpwunl/OAbo
/r3UnPX/EsmHlsV99VttqeepGIEs0CVeghcGBI/WkvM9jcRE+L3TfCqCcpDRecED
d8OKQCM7GouH+hJT75eyU27RiN52265x1C7S21w0K5jGiBMt/UkVujXXncOPjznl
FLN69XcHNMamtWZHiNl8
=pTHa
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--
