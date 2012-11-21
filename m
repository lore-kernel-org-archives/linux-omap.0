From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 05/16] mfd: omap-usb-tll: Add OMAP5 revision and HSIC
 support
Date: Wed, 21 Nov 2012 16:08:12 +0200
Message-ID: <20121121140812.GT10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-6-git-send-email-rogerq@ti.com>
 <20121121121238.GG10216@arwen.pp.htv.fi>
 <50ACCDE5.9040505@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wu6d9FdQ4ohoCGf7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44102 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754587Ab2KUOOn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 09:14:43 -0500
Content-Disposition: inline
In-Reply-To: <50ACCDE5.9040505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--wu6d9FdQ4ohoCGf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 21, 2012 at 02:49:41PM +0200, Roger Quadros wrote:
> On 11/21/2012 02:12 PM, Felipe Balbi wrote:
> > On Thu, Nov 15, 2012 at 04:34:03PM +0200, Roger Quadros wrote:
> >> The TLL module on OMAP5 has 3 channels.
> >> HSIC mode requires the TLL channel to be in Transparent UTMI mode.
> >>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> ---
> >>  drivers/mfd/omap-usb-tll.c |   14 ++++++++++++++
> >>  1 files changed, 14 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> >> index 31ac7db..c48d545 100644
> >> --- a/drivers/mfd/omap-usb-tll.c
> >> +++ b/drivers/mfd/omap-usb-tll.c
> >> @@ -54,10 +54,13 @@
> >> =20
> >>  #define	OMAP_TLL_CHANNEL_CONF(num)			(0x040 + 0x004 * num)
> >>  #define OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT		24
> >> +#define OMAP_TLL_CHANNEL_CONF_DRVVBUS			(1 << 16)
> >> +#define OMAP_TLL_CHANNEL_CONF_CHRGVBUS			(1 << 15)
> >>  #define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF		(1 << 11)
> >>  #define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE		(1 << 10)
> >>  #define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE		(1 << 9)
> >>  #define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE		(1 << 8)
> >> +#define OMAP_TLL_CHANNEL_CONF_MODE_TRANSPARENT_UTMI	(2 << 1)
> >>  #define OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS		(1 << 1)
> >>  #define	OMAP_TLL_CHANNEL_CONF_CHANEN			(1 << 0)
> >> =20
> >> @@ -96,6 +99,7 @@
> >>  #define OMAP_USBTLL_REV1		0x00000015	/* OMAP3 */
> >>  #define OMAP_USBTLL_REV2		0x00000018	/* OMAP 3630 */
> >>  #define OMAP_USBTLL_REV3		0x00000004	/* OMAP4 */
> >> +#define OMAP_USBTLL_REV4		0x6		/* OMAP5 */
> >=20
> > looks wrong to me. Are you sure this is what that 32-bit register reads
> > out ? Bits[31:30] should read as 0b01 as per internal documentation.
> >=20
>=20
> Yes I'm pretty sure about that. I'm on 5432 though. Not sure if 5430
> shows different.

this is really peculiar about these IPs... Anyway, if you made sure,
fair enough. Just make the 0x6 more explicitly 32-bits like the other
macros (0x00000006)

--=20
balbi

--wu6d9FdQ4ohoCGf7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrOBMAAoJEIaOsuA1yqRE2AsP/1xiyoq43DieJdimIZG04nmi
8xdes6riVcpbKvWKXEJf5TdrdBMfhwWK9wfGPJdJdfwMT8cotfYiu3WgQFI7qnwV
R/OHAKVmxo5vqx+0EQpqBG9+NJ83rdAdEF7HGsjutFumhLeZVlVV1ouZZ3gvAPPx
5lyqXwpHY2uvvAOkC9L5DKr3K4OXiIyCRsRhjMvYQHDL1kKjWsvq7Oxp3lNOQmwL
ubxohwzGMo+lfm5lFBD40EV9M6aW/j/O9f2v+LadlsIqIiStKxZliEUxl8Q3Q7DV
Lgmv7u7KxOF9WHiQoj5vFNTDsKjCorte+g9PHvEdroR1p5JNLCU1AIiALb4msI1A
NQp2P+7t1giuG03bXAL+BBFv8YhfnuC0bt6hZ9B8zBjVVlJN/S1Z96rqa+GZiQwR
Ug9RXkUiCEJSqzujXUMm61GdsYVBSm4BYRyjBFS4Rt+lC3+qG39Z86gsRLlNzoqJ
4GSuGO4uIIPU1waYEqhRfHLXHco2j/jTQJ3LgFP6tLz2/+aD3+JXgX0fEfO38SYA
XwKiDhNNoEdIAxnHME/3IbQ+BA/6Dm6BWPtyUgw71Y+2B5HjDwz9Ixb3F+VWNdb0
DvuweBK4GXcCc1jdUVweB8s9/XzgKybE6Tk5rPMJT8HaLRo1pNkCsZoixLrcBTdc
0le6n0vAGYWNYEyO/6XR
=kVci
-----END PGP SIGNATURE-----

--wu6d9FdQ4ohoCGf7--
