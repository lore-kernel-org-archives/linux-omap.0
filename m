From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 09/12] ARM: OMAP2+: usb_host_fs: add custom
 setup_preprogram for usb_host_fs (fsusb)
Date: Mon, 11 Jun 2012 10:13:02 +0300
Message-ID: <20120611071301.GC6845@arwen.pp.htv.fi>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004617.20034.21714.stgit@dusk>
 <20120611063416.GT12766@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na6sys009bog002.obsmtp.com ([74.125.150.44]:44906 "EHLO
	na6sys009bog002.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751431Ab2FKHUr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 03:20:47 -0400
Received: by lagu2 with SMTP id u2so2828558lag.26
        for <linux-omap@vger.kernel.org>; Mon, 11 Jun 2012 00:20:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120611063416.GT12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2012 at 11:34:17PM -0700, Tony Lindgren wrote:
> Hi,
>=20
> Similar comments to the asess patch on this one below.
>=20
> * Paul Walmsley <paul@pwsan.com> [120610 17:57]:
> > --- /dev/null
> > +++ b/include/linux/platform_data/fsusb.h
>=20
> This would be better as include/linux/platform_data/omap-usb.h.
>=20
> > +#include <plat/omap_hwmod.h>
>=20
> This include should not be needed here if the hwmod function is
> a static function in the some hwmod*.c file.
>=20
> > +/* HCCOMMANDSTATUS: the register offset of the HCCOMMANDSTATUS registe=
r */
> > +#define HCCOMMANDSTATUS			0x0008
> > +
> > +/* HCCOMMANDSTATUS_HCR: the bitmask of the host controller reset flag =
*/
> > +#define HCCOMMANDSTATUS_HCR_MASK	(1 << 0)
>=20
> I think these already have standard defines in some OHCI header?
> Felipe may be able to comment more on this?

Well, yeah... but it's defined on drivers/usb/host/ohci.h and it's
actually a structure:

| /*
|  * This is the structure of the OHCI controller's memory mapped I/O regio=
n.
|  * You must use readl() and writel() (in <asm/io.h>) to access these fiel=
ds!!
|  * Layout is in section 7 (and appendix B) of the spec.
|  */
| struct ohci_regs {
| 	/* control and status registers (section 7.1) */
| 	__hc32	revision;
| 	__hc32	control;
| 	__hc32	cmdstatus;
| 	__hc32	intrstatus;
| 	__hc32	intrenable;
| 	__hc32	intrdisable;
|=20
| 	/* memory pointers (section 7.2) */
| 	__hc32	hcca;
| 	__hc32	ed_periodcurrent;
| 	__hc32	ed_controlhead;
| 	__hc32	ed_controlcurrent;
| 	__hc32	ed_bulkhead;
| 	__hc32	ed_bulkcurrent;
| 	__hc32	donehead;
|=20
| 	/* frame counters (section 7.3) */
| 	__hc32	fminterval;
| 	__hc32	fmremaining;
| 	__hc32	fmnumber;
| 	__hc32	periodicstart;
| 	__hc32	lsthresh;
|=20
| 	/* Root hub ports (section 7.4) */
| 	struct	ohci_roothub_regs {
| 		__hc32	a;
| 		__hc32	b;
| 		__hc32	status;
| #define MAX_ROOT_PORTS	15	/* maximum OHCI root hub ports (RH_A_NDP) */
| 		__hc32	portstatus [MAX_ROOT_PORTS];
| 	} roothub;
|=20
| 	/* and optional "legacy support" registers (appendix B) at 0x0100 */
|=20
| } __attribute__ ((aligned(32)));

[...]

| /*
|  * HcCommandStatus (cmdstatus) register masks
|  */
| #define OHCI_HCR	(1 << 0)	/* host controller reset */
| #define OHCI_CLF	(1 << 1)	/* control list filled */
| #define OHCI_BLF	(1 << 2)	/* bulk list filled */
| #define OHCI_OCR	(1 << 3)	/* ownership change request */
| #define OHCI_SOC	(3 << 16)	/* scheduling overrun count */

> > +static int fsusb_reset_host_controller(const char *name, void __iomem =
*base)
> > +{
> > +	int i;
> > +
> > +	writel(HCCOMMANDSTATUS_HCR_MASK, base + HCCOMMANDSTATUS);
> > +
> > +	for (i =3D 0; i < MAX_FSUSB_HCR_TIME; i++) {
> > +		if (!(readl(base + HCCOMMANDSTATUS) & HCCOMMANDSTATUS_HCR_MASK))
> > +			break;
> > +		udelay(1);
> > +	}
> > +
> > +	if (i =3D=3D MAX_FSUSB_HCR_TIME) {
> > +		pr_warn("%s: %s: host controller reset failed (waited %d usec)\n",
> > +			__func__, name, MAX_FSUSB_HCR_TIME);
> > +		return -EBUSY;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> This should be "static inline int fsusb_reset_host_controller" as it's
> in a header.

why is it even in a header ? Only hwmod_fsusb_preprogram() will use it
anyway.

--=20
balbi

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1Zp9AAoJEIaOsuA1yqRE9EEP/ivvyHLSICDJ+l51SQ0joZ/E
yDrq0MCyHHBl2iYJwi3vzUd6US/Sfw7Lu0RmPKEvLSmTC5/3icTg3zJck4B91USO
Iri1jPBwN9o0nnK/y8YRuxY5aF5o3AYgA10PXjGjkUfvxa9EVQXvAJe5p2AsjoO+
rnMqiPSo/zNdNiNET2tihQry4Q+/OUFwJSvEEf4GE824xvaNDds7hkdLYizuF8HY
Ekcy6Ov/166vwHH5IZqvd5gZzP3ml+dz3/Jd9MH4b+qnTu9jPlR/1+ZfYvKto2Z5
QGuNEIavOSP9h1e7cxXO2FSqI0V4WNhaGORwair+YUDNSQb0E4k2BG4fPTzk9VqP
KW+mxuUUB0cas7o3eOHpXYPfJUkwgPdosPI/8zmTQ94XV3LYgZL1Jqiav+5Ujp5x
zSpAx1bv+2lAFNk3Wggp/6O9AGl2IpnHCdJ9ZRisy/+us30xLFmRXMAefmY0+GlA
tVLOU20KMp/mPWciJHMTeQRV/WHAspz8Vk6G/5ChAjUbzl3LVqjVWNQ48+x4Oayg
y47+IXlozqq3zqDDFINGQH9I/yebO14CGAp4tfr4/6XWPvZpRjXa0EALbBa0oYGh
D0kVNtMF3vIAtL/JJpym87qS5IyVqIRRTngIHRN6XqcJ3dRrwsr9GusURviVcuYC
CJQda0qlTQbzP1ijWO7j
=TjLV
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
