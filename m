From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: dwc3: Addition of "dr_mode" dt property.
Date: Fri, 31 May 2013 07:33:41 +0300
Message-ID: <20130531043341.GA8279@arwen.pp.htv.fi>
References: <1369936591-29605-1-git-send-email-ruchika@ti.com>
 <51A7AE26.90909@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51A7AE26.90909@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: Ruchika Kharwar <ruchika@ti.com>, linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>
List-Id: linux-omap@vger.kernel.org

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 30, 2013 at 02:53:10PM -0500, Dan Murphy wrote:
> > @@ -520,9 +520,23 @@ static int dwc3_probe(struct platform_device *pdev)
> >  		mode =3D DWC3_MODE_HOST;
> >  	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
> >  		mode =3D DWC3_MODE_DEVICE;
> > -	else
> > -		mode =3D DWC3_MODE_DRD;
> > -
> > +	else {
> > +		if (of_property_read_string(node, "dr_mode", &dr_mode)) {
> This will not execute if the either CONFIG options are set and then
> the DT property is not even honored
> Did you test this with multiple CONFIG options?
> There seems to be a conflict between CONFIGs and runtime operation.

this is alright. We still want to honor the users who chose to compile
the driver for gadget-only. In that case, there is no choice to be made.

Now, if you build the driver in its entirety (meaning, DRD), you can
still choose in runtime if you want the driver to behave as host-only or
gadget-only.

Picture a situation where you have a single SoC with multiple instances
of this IP and you want to make sure that e.g. ports 1-3 are host-only,
port 4 is peripheral-only and port 5 is DRD.

> > +			dev_warn(dev, "Missing dr_mode so assuming DWC3_MODE_DRD\n");
> If dr_mode is an optional parameter why would the dev_warn say it is miss=
ing?
> Do we even want to warn here?

Yes. Definitely yes. That would mean a less than optimal DTS file.
Still, for the sake of sensible defaults, we can still choose to work on
DRD mode, assuming full capabilities in case user didn't write proper
DTS, still user should be notified about it.

> > +			mode =3D DWC3_MODE_DRD;
> > +		} else {
> > +			if (strcmp(dr_mode, "host") =3D=3D 0)
> > +				mode =3D DWC3_MODE_HOST;
> What if CONFIG_USB_DWC3_HOST is not enabled?

No issues, this will only execute if DRD is enabled, which means both
Host and Device are built in the final binary.

> > +			else if (strcmp(dr_mode, "gadget") =3D=3D 0)
> > +				mode =3D DWC3_MODE_DEVICE;
> What if CONFIG_USB_DWC3_GADGET is not enabled?

see above.

--=20
balbi

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRqCglAAoJEIaOsuA1yqRErVAP/iq77JtrgEkx0Okt8WLDdLmo
7o9SJEFqjidk79lk30bX0poJi2B5+FC41i+t2Yfiaa+h5/E2vSwME+vMTAslhzos
2gSvhgk5nPXepZaaQki0/cXhCBdsonwk1KfDklRSjqx8wAxIdozEkEwTqbh/tjhu
SRay4dp7r5zY0exCRy/W4+2qihskJV0SUthUn0JLL5uN1L6jsRya4+NrSVr9/xa3
iEIWQ+5oKIJNif0HGusyGNKW3uGhsOd4bWARUPyph+Ashb6vu/ZrrAB18gvRRRTJ
LjhHLxoTkNtDY1BJZXdRSxytDsv8OA6XW4RVAYgpPXlUUeQigDJtYnUlpwC7rMSb
tVSvcNAcoSY0m0orLTnKX7PTsMO01/dz7b/pEg3uW2OL5tWNJtWiAYdzV4UAm1SU
tWRF9kNiT2MUE0/DirKdnGrDb/KAmk8bmmiA/HyI/BUp2pvbsR7iwRiKr7GYLnCc
seN1KUl9W6FG2sxn5V8yaDd40ueaJWQcrkITWnRU4PrmJXV3+9rej9F1Z4jyWu1+
7pmgrPv2qoafjR3ggoZ7aKYfSBLWYDKPrlrGbgUBU/FiMul+bSXwjLag6piBs1UA
9QzTXmlONYum0Y89cSpv9sqVcqM6kMVha/DhvIPMW7Hpg1UJn/YKDZ5RcuBNkKSG
SrA2+Q1N28UVM5HHVAj5
=7KWG
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
