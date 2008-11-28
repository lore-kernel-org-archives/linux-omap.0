From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/3] musb: Remvoing twl4030 dependency for OMAP3EVM MUSB
Date: Fri, 28 Nov 2008 13:28:23 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E904EBCD@dbde02.ent.ti.com>
References: <1227850104-16166-1-git-send-email-mani.pillai@ti.com>
 <200811272302.43295.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40607 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbYK1H6e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 02:58:34 -0500
In-Reply-To: <200811272302.43295.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.=
kernel.org] On Behalf Of David
> Brownell
> Sent: Friday, November 28, 2008 12:33 PM
> To: Pillai, Manikandan
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 3/3] musb: Remvoing twl4030 dependency for OMAP3E=
VM MUSB
>=20
> On Thursday 27 November 2008, Manikandan Pillai wrote:
> > =A0#if defined(CONFIG_ARCH_OMAP2430)
> > =A0=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(AE5_2430_USB0HS_STP);
> > +=A0=A0=A0=A0=A0=A0=A0x =3D otg_get_transceiver();
> > +#elif defined(CONFIG_MACH_OMAP3EVM)
> > +=A0=A0=A0=A0=A0=A0=A0x =3D kzalloc(sizeof *x, GFP_KERNEL);
> > +=A0=A0=A0=A0=A0=A0=A0if (!x)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> > +=A0=A0=A0=A0=A0=A0=A0x->set_host =3D omap3_evm_otg_set_host;
> > +=A0=A0=A0=A0=A0=A0=A0x->set_peripheral =3D omap3_evm_otg_set_perip=
heral;
> > +=A0=A0=A0=A0=A0=A0=A0x->set_suspend =3D omap3_evm_otg_set_suspend;
> > +=A0=A0=A0=A0=A0=A0=A0otg_set_transceiver(x);
> > =A0#endif
>=20
> This is obviously wrong.  One does set_transceiver(),
> the other does get_transceiver() ...

=46or OMAP3EVM we don't need twl4030 support for musb and thus otg_set_=
transceiver() which was done
in twl4030-usb.c, is now done here itself for OMAP3EVM.
Whereas for SDP and Beagle twol4030-usb would be enabled and thus otg_s=
et_transceiver() would
have been done in twl4030-usb.c file itself.

>=20
> It seems that some boards need some kind of basic
> OTG transceiver stub.  The newish drivers/usb/otg
> directory is the place to keep such stuff.
>=20
> - Dave
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
