From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] usb: Introduce DesignWare USB3 DRD Driver
Date: Fri, 26 Aug 2011 00:03:42 +0300
Message-ID: <20110825210341.GA27228@legolas.emea.dhcp.ti.com>
References: <1313766659-28360-1-git-send-email-balbi@ti.com>
 <1313766659-28360-4-git-send-email-balbi@ti.com>
 <20110825191509.GB8030@xanatos>
 <20110825203606.GA27161@legolas.emea.dhcp.ti.com>
 <F6C4814A9B336243ABC3D1FB44E08AE801D21CC66D@US01WXMBX1.internal.synopsys.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F6C4814A9B336243ABC3D1FB44E08AE801D21CC66D-uiPIUNf6hlr3OT/vyeh27fufCSb+aD3WLzEdoUbNIic@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Zimmerman <Paul.Zimmerman-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 25, 2011 at 01:48:09PM -0700, Paul Zimmerman wrote:
> > -----Original Message-----
> > From: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]
> > Sent: Thursday, August 25, 2011 1:36 PM
> > To: Sarah Sharp
> > Cc: Felipe Balbi; Greg KH; Linux USB Mailing List; Linux OMAP Mailing L=
ist; Paul Zimmerman
> > Subject: Re: [PATCH 3/4] usb: Introduce DesignWare USB3 DRD Driver
> >=20
> > Hi,
> >=20
> > On Thu, Aug 25, 2011 at 12:15:09PM -0700, Sarah Sharp wrote:
> > > On Fri, Aug 19, 2011 at 06:10:58PM +0300, Felipe Balbi wrote:
> > > > +enum dwc3_link_state {
> > > > +	/* In SuperSpeed */
> > > > +	DWC3_LINK_STATE_U0		=3D 0x00, /* in HS, means ON */
> > > > +	DWC3_LINK_STATE_U1		=3D 0x01,
> > > > +	DWC3_LINK_STATE_U2		=3D 0x02, /* in HS, means SLEEP */
> > > > +	DWC3_LINK_STATE_U3		=3D 0x03, /* in HS, means SUSPEND */
> > > > +	DWC3_LINK_STATE_SS_DIS		=3D 0x04,
> > > > +	DWC3_LINK_STATE_RX_DET		=3D 0x05, /* in HS, means Early Suspend */
> > > > +	DWC3_LINK_STATE_SS_INACT	=3D 0x06,
> > > > +	DWC3_LINK_STATE_POLL		=3D 0x07,
> > > > +	DWC3_LINK_STATE_RECOV		=3D 0x08,
> > > > +	DWC3_LINK_STATE_HRESET		=3D 0x09,
> > > > +	DWC3_LINK_STATE_CMPLY		=3D 0x0a,
> > > > +	DWC3_LINK_STATE_LPBK		=3D 0x0b,
> > > > +	DWC3_LINK_STATE_MASK		=3D 0x0f,
> > > > +};
> > >
> > > AFAICT, the link state values are exactly the same as the xHCI link
> > > state values in the Port Link State field in the PORTSC register.  Is
> > > the gadget side (xDCI side) meant to be somewhat compatible with the
> > > xHCI host controller spec?
> >=20
> > I guess Synopsys would be best to answer this question. Paul, do you
> > happen to know the answer ?
> >=20
> > > Would it make sense to share these link state macros (and any other
> > > similar #defines) with the xHCI driver?  We could move them into
> > > include/linux/ch11.h.
> >=20
> > I'm not sure it makes sense to make gadget side use ch11 definitions,
> > but we could move them to some other common header, maybe ?
>=20
> Our USB3 core is a dual-role device, and some of the logic is shared
> between xHCI mode and Device mode. So it's not a coincidence that the
> link state values are the same.
>=20
> However, in future the device mode will have additional states beyond
> those defined for xHCI. So a completely common header file is not
> possible, unless people don't mind having Synopsys-specific defines
> inside it.

Thanks for the reply Paul :-) I believe this is strong enough argument
to keep things as they are.

--=20
balbi

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOVritAAoJEAv8Txj19kN1ImkIAJ8DoW8ipWj6Zw096Jy5r410
GU4AHiDNJgVANLZp6cVjmdwApo6W9MPSYVMdtQzRs0mhY8pvowqwkvyWFr30vOdU
ZsH8VJhHaqlxx6t3rTEN6g+ZsqEDEpH05rs4XaAAyDsSSRpGMpd/wvlt/HB05RoV
Ifn+UfPdWSuk0SJqj9yNpRN6PceG6cGcAP3cd01P0hz7OtcDUxzJNbF2T+JG43h1
sYLdX29D85f9n/YeAGunLdxqc4QMNsOWOQVTsGbBVhLCL7oV3D/QYgi+CQwIwQfa
VeboVWenNeDjThxVu/WZe1gabIb6CWAOqTukV+nTqH984z+YpG1mOzSGeOofOc8=
=pTmN
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
