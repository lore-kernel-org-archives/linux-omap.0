From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Wed, 11 Mar 2015 10:43:17 -0700
Message-ID: <20150311174316.GD5264@atomide.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
 <20150311164442.GA5264@atomide.com>
 <F7BA143D-5CF9-42E3-AFA8-B83B149EF77E@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:36584 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbbCKRsX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2015 13:48:23 -0400
Content-Disposition: inline
In-Reply-To: <F7BA143D-5CF9-42E3-AFA8-B83B149EF77E@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Marek Belisko <marek@goldelico.com>, Benoit Cousson <bcousson@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

* Dr. H. Nikolaus Schaller <hns@goldelico.com> [150311 10:13]:
> Am 11.03.2015 um 17:44 schrieb Tony Lindgren <tony@atomide.com>:
> > * Dr. H. Nikolaus Schaller <hns@goldelico.com> [150311 09:17]:
> >> Am 11.03.2015 um 16:24 schrieb Tony Lindgren <tony@atomide.com>:
> >>>=20
> >>> Rather than just making platform_data into device tree properties=
=2E.
> >>>=20
> >>> Can't you hide the these custom properties behind the compatible =
flag?
> >>>=20
> >>> You can initialize that data in the driver based on the compatibl=
e
> >>> flag and the match data.
> >>>=20
> >>> This makes sense if you can group things to similar configuration=
s.
> >>=20
> >> Maybe I have not completely understood your proposal.
> >>=20
> >> Do you mean to go back to have big parameter tables for each devic=
e/battery
> >> combination in the driver code and the compatible flag (e.g. compa=
tible =3D =E2=80=9Cboard17=E2=80=9D)
> >> chooses the right data set for the charging map and channels?
> >=20
> > If you can somehow group them, then yes.
>=20
> I don=E2=80=99t see how to group them. Could you make a proposal?

Sorry no idea about that :) I though you may have some ideas based on
dealing with the driver.
=20
> >> I thought this is what the DT was introduced for - to have the sam=
e driver=20
> >> code but adapt to different boards depending on hardware variation=
s.
> >=20
> > Yeah but you also need to consider the issues related to introducin=
g
> > new device tree properties. The device tree properties introduced
> > should be generic where possible.
>=20
> Yes, that was discussed for a while for this driver=E2=80=99s binding=
s leading to v4.
>=20
> Which ones do you think are not generic enough?

It seems maps is the only one then, assuming the cpacity-uah can be mad=
e
Linux generic.=20

> >> And batteries have very different characteristics and vary between=
 devices=E2=80=A6
> >=20
> > Right. Maybe that has been already agreed on to use capacity-uah fo=
r
> > batteries in general?
>=20
> Ah, do you mean with generic/not generic the distinction between a =E2=
=80=9Cti,=E2=80=9D prefix
> and no prefix?
>=20
> Well, I don=E2=80=99t know if there is such an agreement and I would =
have no argument
> against calling it =E2=80=9Cti,capacity-uah=E2=80=9D.

No no, "capacity-uah" is what we should use, but you need an ack from
the battery and device tree people that this is OK. Let's not add
"ti,capacity-uah=E2=80=9D as that can obviously be a generic property.
=20
> > In that case I have not problem with that as
> > it=E2=80=99s a generic property :)
>=20
> Well, many batteries and systems have a fuel gauge chip (e.g. bq27000=
). This
> chip =E2=80=9Cknows=E2=80=9D the capacity. But therefore it is not ne=
eded to specify
> it anywhere because it can be read out (usually in uAh).
>=20
> This driver is to solve the issue that there is no such factory-progr=
ammed
> battery or fuel gauge chip connected to a twl4030 driver. Nobody can =
program
> that capacity value - except someone matching the device tree with re=
al hardware.
>=20
> And, by doing and averaging some charge-discharge cycles the fuel gau=
ge
> mapping is calibrated.

OK=20
=20
> >> The charging maps are depending on the battery type connected to t=
he twl4030
> >> and which madc channel is which value is also a little hardware de=
pendent
> >> (although the twl4030 doesn=E2=80=99t give much choice).
> >=20
> > Just to consider alternatives before introducing driver specific
> > property for the maps.. Maybe here you could have few different typ=
e
> > of maps and select something safe by default? Of course it could be=
 this
> > is higly board specific, I think some devices may be able to run be=
low
> > 3.3V for example..
>=20
> Every battery setup has a different map (which also might depend on t=
he
> series resistance of the battery and the wiring).
>=20
> >=20
> >> And moving this information into the driver for each board that us=
es it
> >> would blow up the code.
> >=20
> > Right, I'm not saying we should build databases into the kernel dri=
vers.
> > Just trying to avoid introducing driver specific properties unless
> > really needed :)
>=20
> They are not really driver specific, they are battery specific. They
> describe properties of the battery:
>=20
> * capacity - depends on battery
> * voltage depending on current charging level - depends on battery (a=
nd differs between charging and discharging)
> * wiring of MADC inputs to the twl4030 is board dependent.
>=20
> So all these properties are not driver specific, but describe hardwar=
e.
> And therefore they had been introduced exactly this way into the old
> platform_data driver.
>=20
> So if you want to see a =E2=80=9Cti," prefix to the capacity property=
 I would be
> fine.

Oh if they are battery spicific, then ideally we'd have generic batery
voltage to capacity maps property rather than a custom ti specific
property.

To avoid extra hassles later on, maybe you could submit a generic
binding patch only documenting it to the battery people and the device
tree people? That will make it easier to maintain this driver in the
long run.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
