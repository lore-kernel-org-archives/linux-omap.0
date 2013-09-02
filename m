From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 00/22] OMAPDSS: DT support
Date: Mon, 2 Sep 2013 11:00:15 +0300
Message-ID: <5224458F.9070401@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com> <2305295.bk1TpuGLMv@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9SxPsphtUbaGcS1LFSUcaNxajsGSitjeK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37450 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755522Ab3IBIAW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Sep 2013 04:00:22 -0400
In-Reply-To: <2305295.bk1TpuGLMv@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

--9SxPsphtUbaGcS1LFSUcaNxajsGSitjeK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 22/08/13 00:07, Laurent Pinchart wrote:

Thanks for the comments!

>> The exception to the above are DSI and DBI. DSI and DBI are combined c=
ontrol
>> and video busses, but the use of the busses for control purposes is no=
t
>> independent of the video stream. Also, the the busses are, in practice=
,
>> one-to-one links. And last, DSI and DBI display entities are often als=
o
>> controllable via, say, i2c. For these reasons there is no real Linux b=
us
>> for DSI and DBI and thus the DSI and DBI devices are either platform
>> devices or i2c devices.
>=20
> That's something I'm less convinced about, but I don't have a too stron=
g=20
> feeling. The best implementation should get to mainline, I won't nack t=
his=20
> architecture just for theoretical reasons.

Ok. I posted a response to your DBI bus patch about the issues I see.

>> DSI Module ID
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> On OMAP4 we have two DSI modules. To configure the clock routing and p=
in
>> muxing, we need to know the hardware module ID for the DSI device, i.e=
=2E is
>> this Linux platform device DSI1 or DSI2. The same issue exists with ot=
her
>> SoCs with multiple outputs of the same kind.
>>
>> With non-DT case, we used the platform device's ID directly. With DT, =
that
>> doesn't work. I don't currently have a good solution for this, so as a=

>> temporary solution the DSI driver contains a table, from which it can =
find
>> the HW module ID by using the device's base address.
>=20
> You could add two output ports to the DSS, one for each DSI, and link t=
he DSI=20
> modules to the DSS output ports in DT. That would represent the hardwar=
e=20
> topology, and would allow the DSI driver to know its ID based on the DS=
S=20
> output port it's connected to. It's still a bit hackish in the sense th=
at the=20
> DSI driver will use information provided by the DSS (the output port nu=
mber),=20
> but not more than the current method.

Hmm, yep. That's kind of the same as having an explicit 'module-id'
property in the DSI node. I had implemented that solution at some point,
but considered it too ugly. But I agree that deducing the module-id from
the DSS output port is a bit cleaner, as it doesn't need any special
properties. And it's maybe also better than the address table I have
now, as the address table requires special code for each SoC.

I have to try the V4L2 ports to understand fully how to use them.

In the end, I hope to get rid of the module-id totally. It's really not
a DSI-thing at all. The DSI hardware does not use the module-id for
anything, it's more about how the DSI module is glued in the DSS/SoC.

>> I have some ideas how to deduce the DSS version by poking to certain D=
SS
>> registers, but it is not yet tested so I don't know if it will work.
>=20
> That might be a stupid question, but can't you just encode the version =
in the=20
> compatible string of the DSS DT node (the one currently compatible with=
=20
> "ti,omap[34]-dss") ?

That would require having separate DT files for each revision. For
example, we have Beagle boards with different OMAP reversions.

It's fine to have the version encoded in the compatible string for major
versions, but having all minor revisions encoded there could result in a
mess.

> Version information might also need to be split/duplicated in several o=
f the=20
> DSS DT nodes. A quick grep through the driver source code shows that th=
e=20
> version is used by the submodules to infer SoC glue information. For in=
stance=20
> dsi_get_channel() uses the version to find the DSI module channel ID. T=
hat=20
> information could possibly be retrieved from the links between the DSS =
DT=20
> nodes.

Hmm, yes. Well. The DISPC has multiple output channels: LCD, LCD2, LCD3,
TV (depending on the SoC). These outputs go to encoders, and the routing
can be configured. If we consider only DSI encoders on OMAP4, the LCD2
output can be configured to go to DSI1 or DSI2 modules. LCD1 output can
be configured to go to DSI1 (but not to DSI2).

Because the routing has restrictions like mentioned above, it's somewhat
difficult to allocate the DISPC output channels during runtime in a
totally dynamic manner. Say, if we happened to allocate LCD2 for DSI1,
and later we'd want to use DSI2, there would be no DISPC output to use.

That's why we currently have them hardcoded in the driver, and it works
ok in all the use cases we have now. However, some board could need to
setup the channels in some other way for some particular use case.

So, I'm not totally comfortable with hardcoding the DISPC output - DSS
encoder connections in the DT data. While it'd work for most cases, it
doesn't work for all.

Then again, if the connections in the DT data would be considered more
like a default set of connections, and they could be changed later from
the kernel/userspace, then it'd be fine.

>> Some of the DSS modules are actually a combination of multiple smaller=

>> modules. For example, the DSI module contains DSI protocol, DSI PHY an=
d DSI
>> PLL modules, each in their own address space. These could perhaps be
>> presented as separate DT nodes and Linux devices, but I am not sure if=
 that
>> is a good approach or not.
>=20
> What are the chances that one of those block will be upgraded and/or re=
placed=20
> independently of the others in the future (I know it's a tricky questio=
n) ? It=20
> might not be worth it going to a too fine-grained approach at the momen=
t, but=20
> we need to make sure that the DT bindings will allow an easy path forwa=
rd if=20
> needed.

For DSI, I believe the chances are quite small. But for HDMI, we already
have this case for OMAP4 and OMAP5, and we're currently working on
splitting the HDMI core, PHY and PLL properly. I think it makes sense to
do the same for DSI also at the same time, especially as the PLL for DSI
and HDMI is the same (afaik).

>> If we shouldn't add the bindings as unstable, when should the bindings=
 be
>> added? Wait until CDF is in the mainline, and use that?
>=20
> What about using the CDF bindings, without waiting for CDF to be in mai=
nline ?=20
> I believe the bindings should be upstreamed as unstable to start with a=
nyway.

Yes, I think that makes sense. And that's what I've been aiming at. I'm
just missing the ports-stuff.

Then again, I see opinions that the old bindings should be supported
(e.g. the mails with Tony in this same thread). If so, using CDF
bindings without CDF being in the mainline is a bit risky, as the
bindings could well change.

 Tomi



--9SxPsphtUbaGcS1LFSUcaNxajsGSitjeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSJEWPAAoJEPo9qoy8lh71s14P/jKmIgwtW631FveWcMztPVQw
DSIRQDS13YsdZPhmUr3VRk4GkkHMucetHyqaCZeW61jKxQaBpqLfHDyW2/m03N4q
Ll/9dQm6ZO2IrxSyJW+m26IEsDjYTBnUkj0tgv561V/lMynhrYya/Z6zotrL6/0Q
MLmZevItNp9S/b+M80QR4oxppZ3QiYGNg3cEUFBvVmb39fcTJfB10KG/n5GYEdq3
5ds/7AvW0tSUQjhOuyEwHxriT3Flly9f+oBroxLh0zDqdJj8ESg12mh3/XXrfb0b
SNnYMC78HGMvOVpGhqoPk/ydGdU53OuGQ8SWN1GXnaloQafTGWjw/XhzzcJSPYe5
kCMqrIYQS5qk7FLXUaZDyhIwLJHGXSb5MwYU7xIjF/+CSSNCr2wB2ghtQWZdSE3O
WG9SVpgH17paIql0mEdGafB2qM56zwXhXRaKfCCJxe+vvihLmVgOgaYWEggg28hH
pgj6/8dWX/rgPY/Yof0NzZj1+8FHBKvodqtjyzl9Mg5KfttBI8MZki89UD5eM7fa
QVV289zWQV0h8MP+dfHbeevp+u3Hpbm9lBOAEQbS8c56rG06HPDGMixeDmhLiaK5
mmZn1c3g93h5bxsS8Q0pnhtFTr54ArrwCiwr09ddNMxzfIWKH0p0MllSZX2iTpTs
AGVGIhz1Dj6Kho1uIHK/
=n5jY
-----END PGP SIGNATURE-----

--9SxPsphtUbaGcS1LFSUcaNxajsGSitjeK--
