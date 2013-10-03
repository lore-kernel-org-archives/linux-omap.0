From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v7 09/10] usb: dwc3: omap: manage "usb_otg_ss_refclk960m"
 clock
Date: Thu, 3 Oct 2013 07:29:41 -0500
Message-ID: <20131003122941.GD3230@radagast>
References: <1379508542-22389-1-git-send-email-rogerq@ti.com>
 <1379508542-22389-10-git-send-email-rogerq@ti.com>
 <52403E02.4070208@ti.com>
 <20131002131113.GM1476@radagast>
 <524C22A1.30200@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59790 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442Ab3JCMaT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Oct 2013 08:30:19 -0400
Content-Disposition: inline
In-Reply-To: <524C22A1.30200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, bcousson@baylibre.com, tony@atomide.com, george.cherian@ti.com, kishon@ti.com, bigeasy@linutronix.de, sergei.shtylyov@cogentembedded.com, thomas.langer@lantiq.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 02, 2013 at 04:41:53PM +0300, Roger Quadros wrote:
> On 10/02/2013 04:11 PM, Felipe Balbi wrote:
> > On Mon, Sep 23, 2013 at 04:11:30PM +0300, Roger Quadros wrote:
> >> Hi Felipe,
> >>
> >> On 09/18/2013 03:49 PM, Roger Quadros wrote:
> >>> "usb_otg_ss_refclk960m" is an optional functional clock to the
> >>> UBS_OTG_SS module. So manage it in the driver.
> >>>
> >>
> >> Just realized that "usb_otg_ss_refclk960m" is in fact functional clock=
 to the=20
> >> PHY and not USB_OTG_SS module. The name is misleading.
> >>
> >> So please ignore patch 9 and 10.
> >=20
> > ignored. All others are fine, right ?
> >=20
> Yes. But I might have to rebase this on top of Phy framework stuff.

alright, Greg already took the PHY framework, so maybe we need to just
give him my Acked-by and he takes the patches directly as I don't have
PYH framework.

--=20
balbi

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSTWM1AAoJEIaOsuA1yqREMUgQAIviVIGCPe+ngvEcQTJaBK6E
FQJR50vbaNyTTKRhtn7O8dyHLfZvK82Z/U3n3OkSMicrkv80lljSRRk/3XqjITjs
GLUCOVlrYifvRSN1ome/wDkpe4bLsu5OfpT0b5yPmU4FUo3pNt8DYdoWWDFaHJkG
CrWs7MDRHYAz7VO/ZOTvR+jmWES+QeHtMxwwPDCabeXBjTTzeO5/hE5KN8Qg+bbe
K+kY6d1RZlUq0rnmenwyFtICPvh9A/l7ehDJJSNcpmdg5BXfolKnqllnK3qcm/eF
pbfEr/Lk9/ZhDZYo74JrCnoBtd91++DTrWxryi1SDQr5wGaG2AFRZQrXi1FN4XVU
Ak6FtUrWmeyttM9JkC853SF9FeyxcAVtwL1iBK0WHgspAlo5664Uqp5lShU1U5lc
XilOMUkjVELs9k31kH+rOtGbJRcQr+sZGPVgHb2qFSy5bilKTlOEXiGC6yUNpPtU
fsY+F7antDA+cgyYAL/b7alLf/9vSLJY/2injHGh87ry5u2szGtL1qbU68RpTRAw
7jJuss61cQLXJOn6Ym+5icl2l/Wp67Y559SuV7pNYDSw9pHR4zU2UoCGtoTD5A5r
aWIkz8LVJPEsY8nNTWPLxUamrIG2fb1goTitbOPWDb8ojsLSdoFetmntzWdfLwWB
bF1/XQBtFfz+WePXUeWX
=dkxk
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
