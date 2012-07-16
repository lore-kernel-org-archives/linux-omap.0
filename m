From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH RFT 1/2] regulator: twl: Fix the formula to calculate
 vsel and voltage for twl6030ldo
Date: Mon, 16 Jul 2012 18:20:30 +0800
Message-ID: <1342434030.4717.2.camel@phoenix>
References: <1341804151.14367.1.camel@phoenix>
	 <1341831686.4343.7.camel@phoenix> <5003DAAA.2070301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56812 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab2GPKUk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jul 2012 06:20:40 -0400
In-Reply-To: <5003DAAA.2070301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, loml <linux-omap@vger.kernel.org>


> On Monday 09 July 2012 04:31 PM, Axel Lin wrote:
> > =E6=96=BC =E4=B8=80=EF=BC=8C2012-07-09 =E6=96=BC 11:22 +0800=EF=BC=8C=
Axel Lin =E6=8F=90=E5=88=B0=EF=BC=9A
> >> In twl6030ldo_set_voltage, current code use below formula to calcu=
late vsel:
> >>          vsel =3D (min_uV/1000 - 1000)/100 + 1;
> >> This is worng because when min_uV is 1000000 uV, vsel is 1.
> >> It should be 0 in this case.
>=20
> Why? Do you know of any documentation which states this?

I double check with the datasheet again now.
You are right in this. So we cannot use linear mapping for
twl6030ldo_ops here.
I'm going to send a patch to fix it, I'd appreciate if someone can
review and test it.


> > I found a problem that before commit 3e3d3be79c, the voltage tables=
 were
> > not linear mapping. So why we can convert these voltage mapping tab=
le to
> > Voltage(in mV) =3D 1000mv + 100mv * (vsel - 1)?
> >
> > Did I miss something?
>=20
> All voltage tables before commit '3e3d3be79c' for twl6030 regulators
> were clearly wrong. They assumed similarity with twl4030 regulators
> which was not right.

Good to know that.=20
Thanks,
Axel
>=20
> regards,
> Rajendra
>=20
> >
> > Regards,
> > Axel
> >
> >
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
