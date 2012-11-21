From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 02/16] mfd: omap-usb-tll: Clean up clock handling
Date: Wed, 21 Nov 2012 16:03:55 +0200
Message-ID: <20121121140354.GR10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-3-git-send-email-rogerq@ti.com>
 <20121121115556.GD10216@arwen.pp.htv.fi>
 <50ACCAE0.3030907@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IfZ+tgy+ooJOsAAy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32872 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591Ab2KUOKZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 09:10:25 -0500
Content-Disposition: inline
In-Reply-To: <50ACCAE0.3030907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--IfZ+tgy+ooJOsAAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 21, 2012 at 02:36:48PM +0200, Roger Quadros wrote:
> >>  		break;
> >>  	default:
> >> -		dev_err(dev, "TLL version failed\n");
> >> -		ret =3D -ENODEV;
> >> -		goto err_ioremap;
> >> +		tll->nch =3D DEFAULT_TLL_CHANNEL_COUNT;
> >> +		dev_info(dev,
> >> +		 "USB TLL Rev : 0x%x not recognized, assuming %d channels\n",
> >> +			ver, tll->nch);
> >=20
> > this hsould be dev_dbg().
> >=20
>=20
> I think it should be more of a warning because it signals a problem.
> There is another pr_info in the success path which could probably be a
> dev_dbg.

it's not a problem at all. It just means that a newer OMAP has come to
market and perhaps we don't need extra code to support it. A revision
detection should *never* be grounds to failure. When we can't understand
the revision, we default to the highest possible value we know.

that's not an error.

> >> +		struct clk *fck;
> >> +
> >> +		sprintf(clk_name, "usb_tll_hs_usb_ch%d_clk", i);
> >=20
> > this will overflow if 'i' (for whatever reason) goes over 9.
>=20
> OK i'll add an extra character. Highly unlikely to go above 99 :)

I'd stick to snprintf() though, or something safer.

> >> +		fck =3D clk_get(dev, clk_name);
> >=20
> > please use devm_clk_get().

sidenote, it would be amazing to a patch at the top of this series
converting to devm_* api ;-)

> >> @@ -373,11 +385,17 @@ static int usbtll_runtime_resume(struct device *=
dev)
> >> =20
> >>  	spin_lock_irqsave(&tll->lock, flags);
> >> =20
> >> -	if (is_ehci_tll_mode(pdata->port_mode[0]))
> >> -		clk_enable(tll->usbtll_p1_fck);
> >> -
> >> -	if (is_ehci_tll_mode(pdata->port_mode[1]))
> >> -		clk_enable(tll->usbtll_p2_fck);
> >> +	for (i =3D 0; i < tll->nch; i++) {
> >> +		if (is_ehci_tll_mode(pdata->port_mode[i])) {
> >> +			int r;
> >> +			r =3D clk_enable(tll->ch_clk[i]);
> >> +			if (r) {
> >> +				dev_err(dev,
> >> +				 "%s : Error enabling ch %d clock: %d\n",
> >> +				 __func__, i, r);
> >=20
> > you don't need __func__.
> >=20
>=20
> Thought it would be useful to point out where the message is coming
> from. But it should be easy to grep too so I'll remove it.

correct, if messages are unique, you don't need __func__ anyway ;-)

--=20
balbi

--IfZ+tgy+ooJOsAAy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrN9KAAoJEIaOsuA1yqREbfQQALZhQMOnovjSy8b/MYSPcvdm
KGmXEhHk+ij83fEYt3UZtJux0rbgbBQ3GjxCvR47JjeoSvLfDXL6Xe8khFigZuoB
mxHTprFUvz3zYtVAeQwD4EcQ6qbV7GzgrjH4ei7vyYU6vJXGmSbSBsniru0Ju0rh
zzNIW5P9e6+S0lI7+xpCjpRa4ql9POY3yDWN3gmSDuGwt5XkGPjXFYC1om4q7UpC
E67sFs21W/o77ygxG6d4ZLPmPH/JiZxnZsFpnnzKJtm8TwBAU4sO6IT6AWJWTju8
L0Wld6Trc7G/0z6XGzqs4kIRiL5sFzAHr4mQPiq7cZcXXv8ha5Y2A4dgO0ZNrVMI
duukJIoHZhE270tlARVhAPcTCu00/kpfdmblv0P7xQfwBXmBFEHRHAOX9d8PS0sv
xvzE0RIIb4h7jPlJoBEluiVuchfCSijRGWbl6Pk8GMum8Ehp60F3TGvehHeKahaZ
12Qc8GCDLxZf/ar+KKspXplJCJHtU41EAFsOe3iQNS/HYcy5LZtoIalyiTsbgx1t
f6jd+bIolTd0AJeM2iBIwq5jXDzFl3g5BWZApFSl3pK7CdvPuqZvBv1rhuoH1Rli
uH3vmLLhARstCb2GYg+M2sQr1lQQ/POFKZWfF5pDw05Rb1HXY3tD9B6MLxMEXPkb
IQZIjecLiO7+lsUfuogY
=jksR
-----END PGP SIGNATURE-----

--IfZ+tgy+ooJOsAAy--
