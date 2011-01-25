From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP3EVM:FIX: Reset the SMSC911x Ethernet controller in
 board_init
Date: Tue, 25 Jan 2011 12:26:21 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD7BE255@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1295880108-15584-1-git-send-email-hvaibhav@ti.com>
 <AANLkTikcTqXS3vSSnmiS94SAHbAm-NPbT-_BTExDwvr-@mail.gmail.com>
 <19F8576C6E063C45BE387C64729E739404BD65F509@dbde02.ent.ti.com>
 <AANLkTikg=keTxGpYKR8K+F60Rjzv7xuNY56ocWxMC6pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55316 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab1AYG4a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 01:56:30 -0500
In-Reply-To: <AANLkTikg=keTxGpYKR8K+F60Rjzv7xuNY56ocWxMC6pw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Tuesday, January 25, 2011 12:20 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; Hilman, Kevin; tony@atomide.com
> Subject: Re: [PATCH] OMAP3EVM:FIX: Reset the SMSC911x Ethernet contro=
ller
> in board_init
>=20
> <<snip>>
>=20
> Missed this one in the previous threads.
>=20
> >> > +
> >> > =A0 =A0 =A0 =A0eth_cs =3D OMAP3EVM_SMSC911X_CS;
> >> >
> >> > =A0 =A0 =A0 =A0l3ck =3D clk_get(NULL, "l3_ck");
> >> > @@ -136,6 +141,22 @@ static inline void __init
> >> omap3evm_init_smsc911x(void)
> >> > =A0 =A0 =A0 =A0else
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rate =3D clk_get_rate(l3ck);
> >> >
> >> > + =A0 =A0 =A0 /* Configure ethernet controller reset gpio */
> >> > + =A0 =A0 =A0 if (cpu_is_omap3430()) {
> >>
> >> cpu_is_omap3430() is not required, as this board init would not be
> >> called otherwise.
> > [Hiremath, Vaibhav] That is not quite true, why do you say this?
>=20
> The board file init means that the cpu info is already identified.
> Do you think that omap3evm_init_smsc911x() would be called for
> other than OMAP3430?
>=20
[Hiremath, Vaibhav] Yes, for all processors version (OMAP35x, AM/DM37x)=
 which uses this EVM file.

Thanks,
Vaibhav
> >
> >>
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_request(eth_rst, "SMSC911=
x gpio") < 0) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(KERN_ERR "F=
ailed to request GPIO7 for
> >> smsc911x\n");
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(eth_rst, 1);
> >>
>=20
> <<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
