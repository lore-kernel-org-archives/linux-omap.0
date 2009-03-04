From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [RFC 0/5] Sensor drivers for OMAP3430SDP and LDP camera
Date: Wed, 4 Mar 2009 17:52:19 -0600
Message-ID: <A24693684029E5489D1D202277BE89442E296F97@dlee02.ent.ti.com>
References: <200903031556.22034.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <200903031556.22034.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>, MiaoStanley <stanleymiao@hotmail.com>, "Nagalla, Hari" <hnagalla@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Menon, Nishanth" <nm@ti.com>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Tuesday, March 03, 2009 5:56 PM
> To: Aguirre Rodriguez, Sergio Alberto
> Cc: linux-media@vger.kernel.org; linux-omap@vger.kernel.org; Sakari A=
ilus;
> Tuukka.O Toivonen; Hiroshi DOYU; DongSoo(Nathaniel) Kim; MiaoStanley;
> Nagalla, Hari; Hiremath, Vaibhav; Lakhani, Amish; Menon, Nishanth
> Subject: Re: [RFC 0/5] Sensor drivers for OMAP3430SDP and LDP camera
>=20
> On Tuesday 03 March 2009, Aguirre Rodriguez, Sergio Alberto wrote:
> >
> > > This patch series depends on the following patches:
> > >
> > > =A0- "Add TWL4030 registers", posted by Tuukka Toivonen on March =
2nd.
> >
> > http://marc.info/?l=3Dlinux-omap&m=3D123597520231668&w=3D2
>=20
> I'd much rather see these drivers just use the regulator
> framework to switch any sensor power rails on/off.

Hi,

Sounds interesting.

Is there any documentation on how to use this?

>=20
> As with the V4L2 interface changes, the twl4030 regulator
> support will be in mainline for the 2.6.30 kernels.
>=20
> - Dave
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
