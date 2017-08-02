From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Wed, 2 Aug 2017 14:54:52 +0300
Message-ID: <fe2d8e70-58f0-694f-0d95-7067970e8f62@ti.com>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
 <20170630123627.l2c46kprbyihkvyy@phenom.ffwll.local>
 <06d8cdc8-7449-9ac4-c791-1ed8f01c15b0@ti.com>
 <20170802101212.33zdmacx4olvwbgw@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="wOR8Xqi3smKGVQDxJoXNvrHoNlKuiv0cM"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802101212.33zdmacx4olvwbgw@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-omap@vger.kernel.org

--wOR8Xqi3smKGVQDxJoXNvrHoNlKuiv0cM
Content-Type: multipart/mixed; boundary="pOI5DBns0Qt8ba9GktbDmgdKnKw46N1PG";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Message-ID: <fe2d8e70-58f0-694f-0d95-7067970e8f62@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
 <20170630123627.l2c46kprbyihkvyy@phenom.ffwll.local>
 <06d8cdc8-7449-9ac4-c791-1ed8f01c15b0@ti.com>
 <20170802101212.33zdmacx4olvwbgw@phenom.ffwll.local>
In-Reply-To: <20170802101212.33zdmacx4olvwbgw@phenom.ffwll.local>

--pOI5DBns0Qt8ba9GktbDmgdKnKw46N1PG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02/08/17 13:12, Daniel Vetter wrote:
> On Mon, Jul 31, 2017 at 04:21:51PM +0300, Tomi Valkeinen wrote:
>> On 30/06/17 15:36, Daniel Vetter wrote:
>>
>>> I don't think registering before everything is loaded make sense. On =
the
>>> big desktop driver chips we have all the bridge/encoder/panel drivers=

>>> built into the driver. arm-soc loves to make everything a separate mo=
dule,
>>> but in the end if you decided to not compile half of the driver you n=
eed,
>>> then it's not going to work.
>>
>> I don't think that's quite the same. On the desktop you just have the
>> video card, and it's easy to enable that single component. On an
>> embedded device you have the SoC's display controller and then possibl=
y
>> multiple external encoders/panels on the board. Those external
>> components have to be separate modules, they can't be part of the SoC
>> driver. The desktop video card matches only to the SoC's display contr=
oller.
>=20
> Please take a look at the encoder drivers both nouveau and i915 have ha=
d
> (for older hw). In neither of these cases did we register an incomplete=

> driver.
>=20
>>> Imo the only thing we should support to be hotplugged in drm is stuff=
 you
>>> can physically hotplug (like atm connectors). Everything else just
>>> complicates the code for no good reason at all.
>>
>> "unplugging" components would not give much, I think, but allowing
>> adding new displays at runtime would be a very good thing.
>=20
> We do, just register another drm_device.

But a drm_device is the display controller ("graphics card") side of the
whole, isn't it? Well, that's not exactly true, it also contains the
output side, like panel, but it's the display controller that defines
how many drm_devices we have.

>> It's not only about mistakenly having the driver disabled in the kerne=
l
>> config, it could also be that some base driver failed to probe, which
>> then makes an encoder or a panel to defer probing as it can't get the
>> base resource. But HDMI or some other panel would work fine, but with
>> current architecture can't be used.
>>
>> And if you really want to optimize, one a phone-type device you could
>> have the LCD driver built-in, but HDMI drivers as modules, and only lo=
ad
>> the HDMI drivers if the user actually needs the HDMI.
>=20
> I don't see why we should support this as a valid use-case. E.g. if i91=
5
> fails to load a component (just because it's all in the same .ko doesn'=
t
> mean it's not multiple bits, same way you can have multiple drivers in =
the
> same .ko), we also fail the overall driver bind. Really not seeing any
> difference with arm-soc vs. desktop here.

I admit I'm not that familiar with the desktop side, but I don't follow.

=46rom the user's perspective, why would his board's HDMI not work, if th=
e
embedded panel fails, or the kernel doesn't have the driver for the
panel? As a user, at least I would very much like the HDMI to work even
if the other display doesn't.

If there's a clear error on the panel side, the DRM driver can handle
that and just leave the panel away. I think the real problems are the
deferred probing and loading as modules, as we don't know when, if ever,
the panel is ok.

At least for me there's a clear distinction between, say, i915 and, say,
boards with OMAP DSS hardware:

i915 is one whole component, and if parts of it don't load, it makes
sense that i915 as a whole doesn't load. And the i915 driver knows and
understand about everything that i915 contains. And i915 can be a single
=2Eko, splitting it into smaller .kos probably doesn't give much benefit.=


On an OMAP board, we have DSS in the SoC, which contains a bunch of
subcomponents. Everything I said above about i915 goes also for DSS
driver. Then we have external encoders and panels. Those have to be
separate drivers and modules, as there can be any number of those, used
in any combination, on any platform.

If I'm configuring the kernel for my OMAP board which has HDMI output
and a panel, and I want to use the HDMI output, it makes sense that I
enable DSS and whatever is needed on the HDMI path. It doesn't really
make sense that I also need to enable panel-foobar.

It's almost as if my board has a GPIO chip, and I would need to enable
and successfully load all the drivers for the devices using the GPIO
chip until any of the devices would work.

Now, I don't think this is a big issue, and I don't think normal users
would often encounter it, but it does feel confusing when you hit the
problem when debugging or doing new kernel configs.

 Tomi


--pOI5DBns0Qt8ba9GktbDmgdKnKw46N1PG--

--wOR8Xqi3smKGVQDxJoXNvrHoNlKuiv0cM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZgb2NAAoJEPo9qoy8lh71O8QP/2y5XTY2PpvkIbnFiFwh++/H
HrngOCSTyLEnQDBT7Y70IUG8gM+dnW6eSgG9laH9MBUArNS2UPABixhB0WY3hXvI
A7+UkeRuuLCPQAVQP9DFO6MXo+KrTc75aoNIMZKSdgx6cR/0Bgc/oLvBT/T/RRi3
wpkTihwhGhbFwQZYhqd9/dydrcW8Qp2K882VD20/GEX4Hh0W5yTgHsjMgVIPPd2W
5cduNdeq2DAGl9ICZpUDoTP22drqeGVKgbA6D6+F1IQpdHr6iv72efpbTJbpprqf
sj56uqAQJqdHBtWVSqR4z82tY62D0QetOhgucMesDnQSPXWWgeTevUCR0ooUYxQ8
Jl6f/CG3vbn7SCeAYZuM2vUGEeSj+A8RlpW5ZpA7e6xi3e4HkGkP/6M3WRYcGIRM
XX/P9hbR7a6/LWNfwA10VnP/0ApkfBTMjqzf9PiGr51d6TdqOBrMg2Ujf/IlC1ye
Sygb++n/q4kZ+KvBi+MqwR/jI6e1zJ3XTiCn+lLtYHkzHhKqZz/8HJmOFDo3tR+T
u7qAiSdykJSHpNrZIZ6iIvmTfdd18kkjVvq2Gm7sRli66L5WQuX2FEcZ+Ey3Wiep
WaqJqDzkuqA39NnxrWI58yx6QGDFGY3iVPj3Vf6BZV3xYsRqkUzR3ZtPwp9O9jLK
AttXHlau7hh5CEHMddK0
=kBiN
-----END PGP SIGNATURE-----

--wOR8Xqi3smKGVQDxJoXNvrHoNlKuiv0cM--
