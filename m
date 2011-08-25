From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/4] usb: Introduce DesignWare USB3 DRD Driver
Date: Thu, 25 Aug 2011 23:36:06 +0300
Message-ID: <20110825203606.GA27161@legolas.emea.dhcp.ti.com>
References: <1313766659-28360-1-git-send-email-balbi@ti.com>
 <1313766659-28360-4-git-send-email-balbi@ti.com>
 <20110825191509.GB8030@xanatos>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46219 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753973Ab1HYUgL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Aug 2011 16:36:11 -0400
Content-Disposition: inline
In-Reply-To: <20110825191509.GB8030@xanatos>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Paul Zimmerman <paul.zimmerman@synopsys.com>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 25, 2011 at 12:15:09PM -0700, Sarah Sharp wrote:
> On Fri, Aug 19, 2011 at 06:10:58PM +0300, Felipe Balbi wrote:
> > +enum dwc3_link_state {
> > +	/* In SuperSpeed */
> > +	DWC3_LINK_STATE_U0		=3D 0x00, /* in HS, means ON */
> > +	DWC3_LINK_STATE_U1		=3D 0x01,
> > +	DWC3_LINK_STATE_U2		=3D 0x02, /* in HS, means SLEEP */
> > +	DWC3_LINK_STATE_U3		=3D 0x03, /* in HS, means SUSPEND */
> > +	DWC3_LINK_STATE_SS_DIS		=3D 0x04,
> > +	DWC3_LINK_STATE_RX_DET		=3D 0x05, /* in HS, means Early Suspend */
> > +	DWC3_LINK_STATE_SS_INACT	=3D 0x06,
> > +	DWC3_LINK_STATE_POLL		=3D 0x07,
> > +	DWC3_LINK_STATE_RECOV		=3D 0x08,
> > +	DWC3_LINK_STATE_HRESET		=3D 0x09,
> > +	DWC3_LINK_STATE_CMPLY		=3D 0x0a,
> > +	DWC3_LINK_STATE_LPBK		=3D 0x0b,
> > +	DWC3_LINK_STATE_MASK		=3D 0x0f,
> > +};
>=20
> AFAICT, the link state values are exactly the same as the xHCI link
> state values in the Port Link State field in the PORTSC register.  Is
> the gadget side (xDCI side) meant to be somewhat compatible with the
> xHCI host controller spec?

I guess Synopsys would be best to answer this question. Paul, do you
happen to know the answer ?

> Would it make sense to share these link state macros (and any other
> similar #defines) with the xHCI driver?  We could move them into
> include/linux/ch11.h.

I'm not sure it makes sense to make gadget side use ch11 definitions,
but we could move them to some other common header, maybe ?

--=20
balbi

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOVrI2AAoJEAv8Txj19kN1Uw8IAKZAVAuVsFKgNj+T/zQBcHLT
AWYlB/T2wvqRaguF9+FFRbXEBeILt74VITFLgqb0A9lmoRdJv1hL4xbDwnTlt4mA
nLyW3Ysrj9EfWyUCEiGg40s61EqaQtjY1HMmYqMF8RNVE+apreWFPZc2k+7EH1jI
gsEKjB3CKx+UK/uR1/vJF6rHEJXw2uYylVykKtZP0ZJzE/PEcbON2myXOGfPGOnr
yjqhSl7sRahAD199OoIfFNdBVtvE4o6bDwbm1K9I8+2a2fKR39XxRddurFKd3nb5
quvSeIKKA3GdG3Y1vpEc5M35KVfrDIVgLOunDvMYODLsEjjxTSUfoGkPj/yJUWU=
=hYaj
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
