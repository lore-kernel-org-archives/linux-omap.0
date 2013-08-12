From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC 2/2] usb: dwc3: Add Qualcomm DWC3 glue layer driver
Date: Mon, 12 Aug 2013 13:24:39 -0500
Message-ID: <20130812182439.GG27954@radagast>
References: <1375789991-30041-1-git-send-email-iivanov@mm-sol.com>
 <1375789991-30041-3-git-send-email-iivanov@mm-sol.com>
 <20130809132349.GC12041@radagast>
 <1376064558.7709.31.camel@iivanov-dev.int.mm-sol.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1376064558.7709.31.camel@iivanov-dev.int.mm-sol.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: balbi@ti.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, gregkh@linuxfoundation.org, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--/i8j2F0k9BYX4qLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2013 at 07:09:18PM +0300, Ivan T. Ivanov wrote:
> Hi,=20
>=20
> On Fri, 2013-08-09 at 16:23 +0300, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Tue, Aug 06, 2013 at 02:53:11PM +0300, Ivan T. Ivanov wrote:
> > > diff --git a/drivers/usb/dwc3/dwc3-msm.c b/drivers/usb/dwc3/dwc3-msm.c
> > > new file mode 100644
> > > index 0000000..e509abc
> > > --- /dev/null
> > > +++ b/drivers/usb/dwc3/dwc3-msm.c
> > > @@ -0,0 +1,175 @@
> > > +#undef CONFIG_REGULATOR
> >=20
> > why ??????
> >=20
>=20
> 1. This shows that driver is still not fully tested=20
>    Regulators support is still missing in the MSM
> 2. Helps me to load driver successfully.=20

Then remove all the regulator-related code from this.

> > > +	clk_prepare_enable(mdwc->core_clk);
> > > +	clk_prepare_enable(mdwc->iface_clk);
> > > +	clk_prepare_enable(mdwc->sleep_clk);
> > > +	clk_prepare_enable(mdwc->utmi_clk);
> >=20
> > do you really need to enable your clocks here ? Why don't you enable
> > them on runtime_resume and disable on runtime_suspend ?
>=20
> I will like to make it working first and then will improve
> power management.

alright, makes sense.

> > > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	tcsr =3D devm_ioremap_resource(&pdev->dev, res);
> > > +	if (!tcsr) {
> > > +		dev_dbg(&pdev->dev, "tcsr ioremap failed\n");
> >=20
> > no need to ioremap, also you're likely leaking clocks and regulators
> > enabled here.
> >=20
> > Make sure to have something like:
> >=20
> > 	if (!tcsr)
> > 		goto err_disable_clocks;
> >=20
> > 	/* TODO This has to be revised */\
> >=20
> > 	[...]
> >=20
>=20
> Sure.

just to make it clear, I meant to say that you don't need to print the
error message :-)

--=20
balbi

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSCShnAAoJEIaOsuA1yqREvsYP/3POPDG+3Xt/Jm9+ntvZwRpe
q0I8EVHQrw/UpcnJdjLkwCW0Z8ieHBbmmECMGuzQ+f6ZIUPGEQt9NM96qqEweMwd
jQA6Sjm1CkMNFv6OU/yKr7LpjS/mc7xv3pCkTka9PKRJSqmoh2qF9Me0fO9WT/fY
Sg1K2O8YBri2pqlKS/7fT4lTh+wUnz87f+NE+CfW+K4samgTZDNEDz02xMIOS85Y
gF0jT3y1hmJWbkfobFihlR+KqBZPmzgZpYaVLiOwwNGrZE/o0aS9mbEjtKeh11Cf
Zbx7h9CHBbff731xTFZn5gj6HWRGyFN97DYsat0Yn2e+bqCOTCqeNM/FgkMncl6I
U2nAnYL1YlHDkID2H6okLljgnjoo1/zcY1hRVKY+cFYJH1G3ewz7CuGD17U0k06w
oWWM7erXoE/GZ+qvOOCQ48Q2seOY+WUyE/Emjx0qcsZJsrcreo92ybo6OA2miMLJ
/7qkOYs55kqYASpsL7maW67S4A6JOj5qapesrH39R9iEwnHZz2PR0GDDI+7lRpXC
OZTKJLKNScxDaUantdWWqSJ5y9Kmimx7SWJgiShfBe9TeLMQYKZY8BoFqsqodyJz
ocuzAC+T+XCcIquQANoO4Ry9244QkuxhMgMHqqJLJXogZbE4DBcisVwCSZpaoS72
0bBxwdVmgdnrYs/gpmuz
=HJ44
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--
