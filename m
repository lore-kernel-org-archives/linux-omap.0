From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Mon, 31 Jul 2017 16:21:51 +0300
Message-ID: <06d8cdc8-7449-9ac4-c791-1ed8f01c15b0@ti.com>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
 <20170630123627.l2c46kprbyihkvyy@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="cQDJaBm6wahswCBuacPGSCBncnpvH6O8j"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170630123627.l2c46kprbyihkvyy@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--cQDJaBm6wahswCBuacPGSCBncnpvH6O8j
Content-Type: multipart/mixed; boundary="88Is9c2GRiBCK2RUU4MAdDuvtbv0G95k4";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Message-ID: <06d8cdc8-7449-9ac4-c791-1ed8f01c15b0@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
 <20170630123627.l2c46kprbyihkvyy@phenom.ffwll.local>
In-Reply-To: <20170630123627.l2c46kprbyihkvyy@phenom.ffwll.local>

--88Is9c2GRiBCK2RUU4MAdDuvtbv0G95k4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30/06/17 15:36, Daniel Vetter wrote:

> I don't think registering before everything is loaded make sense. On th=
e
> big desktop driver chips we have all the bridge/encoder/panel drivers
> built into the driver. arm-soc loves to make everything a separate modu=
le,
> but in the end if you decided to not compile half of the driver you nee=
d,
> then it's not going to work.

I don't think that's quite the same. On the desktop you just have the
video card, and it's easy to enable that single component. On an
embedded device you have the SoC's display controller and then possibly
multiple external encoders/panels on the board. Those external
components have to be separate modules, they can't be part of the SoC
driver. The desktop video card matches only to the SoC's display controll=
er.

> Imo the only thing we should support to be hotplugged in drm is stuff y=
ou
> can physically hotplug (like atm connectors). Everything else just
> complicates the code for no good reason at all.

"unplugging" components would not give much, I think, but allowing
adding new displays at runtime would be a very good thing.

It's not only about mistakenly having the driver disabled in the kernel
config, it could also be that some base driver failed to probe, which
then makes an encoder or a panel to defer probing as it can't get the
base resource. But HDMI or some other panel would work fine, but with
current architecture can't be used.

And if you really want to optimize, one a phone-type device you could
have the LCD driver built-in, but HDMI drivers as modules, and only load
the HDMI drivers if the user actually needs the HDMI.

 Tomi


--88Is9c2GRiBCK2RUU4MAdDuvtbv0G95k4--

--cQDJaBm6wahswCBuacPGSCBncnpvH6O8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZfy7vAAoJEPo9qoy8lh71lZgP/1donoG0kW2uKkbh2loN0G0k
GMnyj1uWmkHbxTu5i62U1WxRetqMslzt3gXuz4ltZohYSGZWzVmmKszHPhlS1V6O
uewqFX2zx72osn1SKl9M7+lwq47H8n9HrNMkxO1WF0h9LHn/E6p6s8NWWyesVesm
r+iIwYSLHdDFAkiFiiE1xbCzHu+gOy1CXeg7K5uikjVOD+hHbAvC3kn4NcYz4XxM
moBQn+YlL8BTMShT+cKMVmSu+frKrkUwrbM3RP9xgi6YsVLOWFdzCaoYCSY0Pz+A
8p47d6sYgMZNh2fP4E90dmP9zWRSbm1l4wNkwi26y/lI1WohnaWdOdXuRVrJ6PB+
lO/a293DkY51G6hfXeGvGfQgO4qXWW8nBeMG3MHKcG/wpU5phBYPhN2yZFA4XY4b
ct/+rA5uzXeUn6MvUmTbuwSg8VTfIojT9tl7CfIBhhAAvKtIYw34j/bqScwWWVnW
JMkha/4l6chxmpKH3Jwf3+8QaHeVRNKiqt7/CC2u1ak5IM1icpMAQ1YMTq4DKR/w
C5DaGqircuurz6tb8FhS+tgr/RWOu3nvLQ9C5dCLUXvwf7OsfQ9j90a6DdS/T23z
xqDnWQTEfzHWRmuqMlnQsYZsRZxS0bwsMGVGZ/2AtsNz518AIfd4Bersyk3DKR/k
ubi3Qp3E63UhVTjMO5M5
=oISS
-----END PGP SIGNATURE-----

--cQDJaBm6wahswCBuacPGSCBncnpvH6O8j--
