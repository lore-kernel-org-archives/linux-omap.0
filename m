From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: DSS2 and power supplies
Date: Thu, 10 Dec 2009 18:53:55 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940437210B71@dbde02.ent.ti.com>
References: <6ed0b2680912040253m3b25950fuf49e6ec75ad13067@mail.gmail.com>
	 <1260175482.2342.49.camel@tubuntu.research.nokia.com>
 <6ed0b2680912070227x3bcb9613x88ebdb0b0a7f3f18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42436 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758898AbZLJNX4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 08:23:56 -0500
In-Reply-To: <6ed0b2680912070227x3bcb9613x88ebdb0b0a7f3f18@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Grazvydas Ignotas
> Sent: Monday, December 07, 2009 3:57 PM
> To: Tomi Valkeinen
> Cc: linux-omap@vger.kernel.org
> Subject: Re: DSS2 and power supplies
>=20
> On Mon, Dec 7, 2009 at 10:44 AM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:
> > Hi,
> >
> > On Fri, 2009-12-04 at 11:53 +0100, ext Grazvydas Ignotas wrote:
> >> hi,
> >>
> >> it seems DSS block in OMAP needs SDI/DSI supplies to operate
> properly
> >> even with parallel displays, or else it doesn't drive some data
> lines
> >> resulting in missing/wrong colors. Take a look at figure 15-1 on
> OMAP3
> >> TRM (page 2119 on spruf98d), some dss_data lines are going out of
> >> SDI/DSI blocks, which are fed by vdds_sdi and vdds_dsi supplies
> >> (vdss_sdi in fig 15-1 seems to be a typo). Those 2 are typically
> >> connected to VPLL2 on TWL4030/TPS65950 (see fig. 25-2 on p3482),
> so
> >> that regulator needs to be activated for proper operation (if you
> have
> >> a parallel display and a board with TWL4030 you can reproduce
> this by
> >> not enabling VPLL2 in bootloader and kernel; mainline u-boot
> enables
> >> it).
> >
> > Hmm, this would explain the color errors. Have you seen this on
> some
> > other board than TI's SDP?
> >
> > To me the fig 15-1 does not tell that the powers are needed. The
> > DSS_DATA[] pins do not come from SDI/DSI blocks, but from the main
> DSS
> > block. And the pin muxing component is outside also. This of
> course
> > doesn't really prove anything. =3D)
>=20
> True, but apparently vdds_dsi and/or vdds_sdi are also used to drive
> some data lines then (not supplying them produces blue-ish display
> with some parts missing). I'm working with pandora board, and I'm
> sure
> VPLL2 is not connected to anything else.
>=20
[Hiremath, Vaibhav] No, I think the "vdds_dsi" doesn't drive any data i=
n parallel mode of operation.
I have also observed similar issue with OMAP3EVM, when you switch the o=
utput to DVI interface, you will get bluish image.=20

The issue came out as VPLL2_DEV_GRP (Bits 7-5) register configuration. =
When you are working with LCD panel (in my case sharp-ls037v7dw01.c), t=
his file calls regulator_get and regulator_enable functions which confi=
gures VPLL2_DEV_GRP to 0x2 [Owns to P1 device group].
But when you switch the output to DVI, it doesn't do any regulator_get/=
enable call so the VPLL2_DEV_GRP register becomes 0 [Owns to no device =
group] leading to color loss.

I am not regulator framework expert, so could not comment on what is th=
e relation of VPLL2_DEV_GRP with this issue.

So what is required here is, panel_generic.c also should enable regulat=
or for "vdvi"

I have a patch (tested on OMAP3EVM) which I submit once DSS2 goes in.

Thanks,
Vaibhav

> >
> >> Right now DSS2 requests vdds_dsi in DSI driver only, any plans to
> >> request vdds_dsi/vdds_sdi for parallel displays too?
> >
> > I didn't have any plans, but if what you said is true, it sure
> needs to
> > be added.
>=20
> Yeah that would be nice.
>=20
> >
> > =A0Tomi
> >
> > Ps. Adding l-o, as others may be interested also.
> >
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
