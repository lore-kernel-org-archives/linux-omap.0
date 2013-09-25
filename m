From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Wed, 25 Sep 2013 16:57:11 +0300
Message-ID: <5242EBB7.2090006@ti.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com> <52427ECA.1080500@ti.com> <CAAfyv37sSa=7x=p1wgX+Rhdxh=WMB4DhmC9ZQMpxB_rb30Aurw@mail.gmail.com> <3A4BA9B4-262C-4F0A-95B7-D243065D01BA@goldelico.com> <52429F06.6030609@ti.com> <307BD8A2-738A-4A66-8FD5-98C37AD4BCA3@goldelico.com> <5242BFEA.1090200@ti.com> <9172D29D-118B-4B6F-A454-BD359C5D97D4@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="2jUmoqVDGTENKQo4DVghKaviMpJkf8JQP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42945 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612Ab3IYN5S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Sep 2013 09:57:18 -0400
In-Reply-To: <9172D29D-118B-4B6F-A454-BD359C5D97D4@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-omap@vger.kernel.org, Belisko Marek <marek.belisko@gmail.com>

--2jUmoqVDGTENKQo4DVghKaviMpJkf8JQP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/09/13 15:26, Dr. H. Nikolaus Schaller wrote:

>> Sure, but the gpio is not related to the connector, it's related to
>> another component.
>=20
> I would see it as a part of the interface.

I don't know what you mean here with "interface".

> But why should we hesitate to solve an existing problem because there c=
ould
> arrive a not-yet existing one of low likelihood?

Even if a solution works, but is clearly not correct in design-sense, I
don't want to merge it. Why? In the future, if and when the wrong
solution creates problems, somebody needs to fix it. Who'll it be? Yes,
me, the maintainer of the software. And so I want to avoid merging
anything that I know might cause problems in the future.

>> And I disagree that it's a simple problem =3D). Making generic, reusab=
le
>> drivers is not simple.
>> Making a hack to make it work on your particular
>> platform and board is simple, though.
>=20
> But could be a good starting point until someone else has a real need f=
or
> a different solution :)

Well, see my comment above about who'll need to fix it =3D). Even if we
don't find a good solution, and merge the hack, I want first to try to
find a good solution.

> Anyways the connector-analog-tv is really new in the kernel and we are =
probably
> the first ones who try to use it in real life.

Possibly. I did try it with Beagle, if I recall right, but I guess it's
maybe the simplest possible hardware setup.

>>> Could we just add a "enable_ac" and "enable_bypass"  to struct connec=
tor_atv_platform_data,
>>> that sets/resets these flags in the DEVCONF1 register each time the t=
vout is enabled?
>>
>> No, those are properties of the SoC, as far as I understand, nothing t=
o
>> do with the connector.
>=20
> Hm. I again get the impression that we have a different view on what a =
"connector" is.

"Connector" here means the physical component that is the
S-video/composite connector, to which the cable is connected. In this
case it doesn't really do much at all, but we have a driver for it
because the display device model requires it. We need a kind of
"terminator" at the end of the video pipeline, and that is either a
panel driver or a connector driver.

Let me describe how DVI works on Beagle/Panda, to give a better example.
We have the following components, arrows showing the dataflow:

DPI -> TFP410 -> DVI connector

DPI is the DPI encoder in the SoC's DSS. TFP410 takes DPI input, and
outputs DVI. And DVI connector represents the physical connector on the
board.

We have drivers for each of those components, and they handle things
related only to that particular component:

- DPI driver handles programming the DPI registers on the SoC, and any
regulators required to power the DPI encoder.

- TFP410 driver handles power-down GPIO to enable/disable TFP410, and
regulators related to it.

- DVI connector driver uses i2c to read the EDID from the monitor, and
also supplies the required +5V to the DVI connector. It could also
handle hotplug detection.

Each driver should only be concerned about things related to that
particular component. For example, you could change the SoC, you could
change the TFP410, but DVI connector would still be the same.

> For me "the connector" that should be seen in kernel code are the analo=
g video
> outputs of the SoC (i.e. TVOUT1, TV_VFB1, TV_OU2, TV_VFB2). Not the phy=
sical
> one going to some TV screen or other video signal consumer outside the =
board.
>=20
> Like with UARTs. They are not drivers for a 9 or 25 pin socket. And the=
re may be
> a level shifetr chip in between that the software does not see.

Right. For UART, it works. For display, we have so complex video
pipelines that such a simple model does not work.

Of course, if the video pipeline has so trivial components that require
no control and no regulators, well, I don't see a need to have drivers
for those.

>> Although I have to say I have no idea what "TV AC
>> coupled load enable" or "Active high enable AVDAC TV out bypass" do.
>>
>> I guess I need to refresh my memory on the VENC, although if I recall
>> right, it wasn't explained very well in the TRM.
>=20
> There is a post-amplifier stage right after the Video DAC on the DM3730=
 chip
> and these bits we discuss control some electrical properties of that po=
st-amplifier.
>=20
> I.e. bypass means that it is turned off and the VDAC signal is directly=
 fed to the
> output pin.
>=20
> Section 7.2.3 and 7-58 to 7-61 depict this.

Yep, I see it, but I don't understand it =3D). As I said, I'm not familia=
r
with analog TV signal, and I'm a SW guy.

Let me put it this way: In your case, there's the following video pipelin=
e:

VENC -> OPA -> Connector

Here VENC is part of the SoC's DSS, and OPA and connector are external
components on the board.

VENC outputs a video signal, and obviously any register changes required
which affect the signal need to be done directly or indirectly by the
VENC driver.

If OPA requires an inverted signal, it's between VENC and OPA to handle
that. Connector is not involved.

The question here is how to handle the above. Should OPA driver request
VENC driver to invert the signal? Or should VENC driver just be passed
parameters from the board code making it invert the signal? This is
something I don't have an answer, and I've been wondering about this
design question for other video interfaces also.

In both cases the VENC driver needs somehow get the DEVCONF1 register to
be changed. For that we need some support from the core platform code,
probably a function pointer in the DSS platform data, similar to, say
"dsi_enable_pads".

Or alternatively (but not so nicely), if there's no need to change the
DEVCONF1 bits during normal operation, the DEVCONF1 could be configured
once at boot time (although I don't know how to do that with DT boot),
and it would be considered as a fixed setting.

Sometimes the latter approach is ok, but I dislike hardcoding things
like that, as more often than not, it is a problem at some point in the
future. Here, with analog TV out, I presume nobody will be using it in
the future so perhaps it's not a problem =3D).

>> Also, note that drivers cannot touch DEVCONF1 register. That can only =
be
>> touched by the OMAP's platform code.
>=20
> Ah, I see.
>=20
> That may be one of the reasons why it did end up in our 2.6.32 board fi=
le,
> because there we know that it is an OMAP3 and can directly read/write r=
egisters.
>=20
> But I wonder how drivers access the DISPC to modify e.g. sync polarity =
or
> the video timing?

DISPC is handled by the DISPC driver (i.e. omapdss driver).

> Is this also an API exposed by the OMAP core driver or is it part of th=
e DSS
> drivers? So somewhere in the complex thing someone must know the
> register address and be able to write to it.

DEVCONF1 is part of the CONTROL block, which is a core part of OMAP.
DISPC is part of DSS block, which is not considered to be part of OMAP
core. The idea here is that, in theory, the same DSS could be used in
some other SoC, which has different methods to manage the things
DEVCONF1 does.

So the DSS driver can just touch the DSS registers. Changing DEVCONF1
must happen indirectly in a platform independent way.


I think the rest of the comments in your email were more about our
different understanding of what connector here means and of the display
driver model in general. If there's something unclear, and I didn't
answer to it, just ask again.

> Hm. Indeed diffiicult for an apparently simple problem and I hadn't exp=
ected
> that it gets so a long discussion :) But really good solutions need tha=
t before.

Well, video is complex. People always think video is simple =3D). And the=

case here is even of the simpler ones. Just think about DSI bus with
encoders with multiple inputs or outputs, and the complexity goes
through the roof...

 Tomi



--2jUmoqVDGTENKQo4DVghKaviMpJkf8JQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQuu3AAoJEPo9qoy8lh71so0P/jOsCP+lx0huw5tm0He+sEwu
NQogBNRFPOwhL90NrlUVzH9pHhdITq60FNegsAI51lW4UA5Woe+DsQaY23WXU4fH
r2eD/zSWw8ENwY1aV63o1VJ+gHlw0J+e+HyeK8iLHge7uOBKB/iiSRnawtfDrli6
R4MbKgbPtnTnn7zIhMG6xZ299tJxfHq9Mwd6k7GskF3mE0/KqzjcTiRj7BZNf0xM
AHVIAriUg0/nnk761oXLbsBkgcVhlm6d9fydx5E5gZJ1xAnco2xklyLPuLphv/qv
Rq4tOWxXldwkXxgwB3bebIMfkj5jqCxCxbYdMg6im7TOIX3FB1bxOqjczHItprIL
p8E5EXXN2KAk6p+GyxMqWZHSWt9Qpxm/JYR1X9OBnS+bzXW4OuD5eUgl0xcFEP7g
pPdCuh2iOLl41HWrJRxkJlSdTS/MjCCXB2AUDHMoZwAUIHk2IZ5w2IgcqHIhW+EJ
I41hMuLT1AbxLfUi9g55hFHI+PR1LZ4OjDnN0e7f5D0eMWijayx3sw+qHkb84VhE
41w80OGaG/ifccbsSETzNa5vjB+FLgPx93yw6l6/v+ooV0+cE2rn2eXp0g/oODis
qwOylUe82v62LYnQdrsGSFFCjUKSf31pksL0X1zWxBnQlqSJEQU82RxJiHNbcWNO
Y7VTqbezPDDjfZ80BiJs
=JOq9
-----END PGP SIGNATURE-----

--2jUmoqVDGTENKQo4DVghKaviMpJkf8JQP--
