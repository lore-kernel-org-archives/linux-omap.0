From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCHv2 3/3] arm: dts: add bandgap entry for OMAP4460 devices
Date: Fri, 31 May 2013 17:24:05 +0200
Message-ID: <20130531152405.GH23653@game.jcrosoft.org>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
 <1368629928-6723-4-git-send-email-eduardo.valentin@ti.com>
 <5193A875.1020000@ti.com>
 <5193B9AA.7020507@ti.com>
 <20130515165726.GK22508@game.jcrosoft.org>
 <5194D123.4060403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:36324 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756196Ab3EaP2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 11:28:13 -0400
Received: from mail609.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id D60FBFFB80D
	for <linux-omap@vger.kernel.org>; Fri, 31 May 2013 17:28:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5194D123.4060403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08:29 Thu 16 May     , Eduardo Valentin wrote:
> On 15-05-2013 12:57, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 12:36 Wed 15 May     , Eduardo Valentin wrote:
> >> On 15-05-2013 11:23, Benoit Cousson wrote:
> >>> Hi Eduardo,
> >>>
> >>> On 05/15/2013 04:58 PM, Eduardo Valentin wrote:
> >>>> Include bandgap devices for OMAP4460 devices.
> >>>>
> >>>> Cc: "Beno=EEt Cousson" <b-cousson@ti.com>
> >>>> Cc: Tony Lindgren <tony@atomide.com>
> >>>> Cc: Russell King <linux@arm.linux.org.uk>
> >>>> Cc: linux-omap@vger.kernel.org
> >>>> Cc: devicetree-discuss@lists.ozlabs.org
> >>>> Cc: linux-arm-kernel@lists.infradead.org
> >>>> Cc: linux-kernel@vger.kernel.org
> >>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> >>>> ---
> >>>>  arch/arm/boot/dts/omap4460.dtsi | 9 +++++++++
> >>>>  1 file changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts=
/omap4460.dtsi
> >>>> index 2cf227c..e5bfbfe 100644
> >>>> --- a/arch/arm/boot/dts/omap4460.dtsi
> >>>> +++ b/arch/arm/boot/dts/omap4460.dtsi
> >>>> @@ -29,4 +29,13 @@
> >>>>  			     <0 55 0x4>;
> >>>>  		ti,hwmods =3D "debugss";
> >>>>  	};
> >>>> +
> >>>> +	bandgap {
> >>>> +		reg =3D <0x4a002260 0x4
> >>>> +			0x4a00232C 0x4
> >>>> +			0x4a002378 0x18>;
> >>>> +		compatible =3D "ti,omap4460-bandgap";
> >>>> +		interrupts =3D <0 126 4>; /* talert */
> >>>> +		ti,tshut-gpio =3D <86>;
> >>
> >>
> >>
> >>>
> >>> Why do you need a custom attribute for GPIO? Cannot you use the s=
tandard
> >>> one?
> >>
> >> I believe it was by your suggestion :-), during the first attempts=
 to
> >> send this driver. But could not find the thread link :-( sorry.
> >>
> >>
> >> I guess the reasoning to mark it as a ti specific is because it wi=
ll be
> >> used as IRQ line to treat thermal shutdown (in SW).
> > so use interrup-parent
>=20
>=20
> Jean-Christophe,
>=20
> That will change the controller and break the configuration for the
> other IRQ line, coming from GIC.

put this on hold I'm preparing a fix for this
I've discuss with Grant already.

This way for me is buggy

Best Regards,
J.
>=20
> >>
> >>>
> >>> Where is the gpio controller phandle?
> >>>
> >>> Usually it looks like this:
> >>>
> >>> 	gpios =3D <&gpio1 8 0>;
> >>>
> >>>
> >>> Regards,
> >>> Benoit
> >>>
> >>>
> >>>
> >>
> >>
> >=20
> >=20
> >=20
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >=20
> >=20
> >=20
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
