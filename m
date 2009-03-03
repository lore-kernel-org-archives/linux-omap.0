From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 0/5] Sensor drivers for OMAP3430SDP and LDP camera
Date: Tue, 3 Mar 2009 15:56:21 -0800
Message-ID: <200903031556.22034.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE89442E1D92A4@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n30.bullet.mail.mud.yahoo.com ([68.142.207.49]:42499 "HELO
	n30.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754156AbZCCX40 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 18:56:26 -0500
In-Reply-To: <A24693684029E5489D1D202277BE89442E1D92A4@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>, MiaoStanley <stanleymiao@hotmail.com>, "Nagalla, Hari" <hnagalla@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Menon, Nishanth" <nm@ti.com>

On Tuesday 03 March 2009, Aguirre Rodriguez, Sergio Alberto wrote:
>=20
> > This patch series depends on the following patches:
> >=20
> > =A0- "Add TWL4030 registers", posted by Tuukka Toivonen on March 2n=
d.
>=20
> http://marc.info/?l=3Dlinux-omap&m=3D123597520231668&w=3D2

I'd much rather see these drivers just use the regulator
framework to switch any sensor power rails on/off.

As with the V4L2 interface changes, the twl4030 regulator
support will be in mainline for the 2.6.30 kernels.

- Dave
=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
