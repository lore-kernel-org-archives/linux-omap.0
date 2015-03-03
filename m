From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH RFC 6/6] ARM: dts: am335x-boneblack: Use new binding for
 HDMI
Date: Tue, 3 Mar 2015 10:35:15 +0200
Message-ID: <54F57243.9060202@ti.com>
References: <cover.1424961754.git.jsarha@ti.com> <6d6653416fd87c678a80df1d422420877261c4a5.1424961754.git.jsarha@ti.com> <54F45778.6050406@ti.com> <20150302160629.GB29584@n2100.arm.linux.org.uk> <54F49917.6070608@ti.com> <20150302174227.GC29584@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="8kM4mHirpQ99SOdiaIn9NgUAP7boFtkjB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53168 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755160AbbCCIfk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Mar 2015 03:35:40 -0500
In-Reply-To: <20150302174227.GC29584@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, detheridge@ti.com, moinejf@free.fr, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

--8kM4mHirpQ99SOdiaIn9NgUAP7boFtkjB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 02/03/15 19:42, Russell King - ARM Linux wrote:
> On Mon, Mar 02, 2015 at 07:08:39PM +0200, Tomi Valkeinen wrote:
>> On 02/03/15 18:06, Russell King - ARM Linux wrote:
>>
>>>> This is missing the output of tda998x. It should have two ports, inp=
ut
>>>> and output, output going to hdmi-connector.
>>>
>>> We don't have that kind of level of modelling in DRM right now - as f=
ar
>>> as DRM is concerned, the tda998x is both the encoder _and_ the connec=
tor
>>> since it supplies both functionalities.
>>
>> That's fine, but these are DT bindings which should reflect the
>> hardware, not the SW stack.
>=20
> I still don't buy your argument.  The principle is right, but I think
> you're taking it too far.

<snip>

> When we say "DT should follow the hardware" we're not talking about
> making DT be an alternative to the hardware's schematic.

I agree, and that's not what I'm suggesting. We should only model HW in
the DT when it makes sense, when it gives us something.

A HDMI connector can have (at least) two functionalities that the driver
for it may need to handle: HPD and +5V. On some SoCs/boards those are
handled by the HDMI encoder, but I have boards where they are not. So we
need to have the data somewhere, and a HDMI connector node at the end of
the video path is a logical choice.

The HDMI connector node is also a good place for a symbolic name which
can be shown to the user.

In this particular board, the HDMI encoder handles the HPD and the +5V
is always enabled, so there's no strict need to have the HDMI connector
node.

However, I still feel it's better to have the HDMI connector in .dts:

1) It's not said that a HDMI encoder always has a HDMI connector as the
next component. The next component could be a integrated panel, needing
a specific driver and there's no HDMI connector at all. Or there could
be something else, as is the case on some OMAP boards which have an ESD
protection chip (that requires controlling, i.e. a driver) between the
encoder and the connector.

2) I like that the beginning and the end of the video pipeline are
clearly defined. A video pipeline starts at a display controller, and
ends at a panel or a connector. This makes it easier to understand the
=2Edts as you know what to expect.

In the SW side these mean that every encoder (or whatever is doing this
stuff) should be able to handle any component after the encoder, be it a
connector, panel or something else.

If we allow leaving out the connector node, the code also needs to
handle the case when there's nothing after the encoder, which probably
means fabricating some connector data (at least if and when DRM can
handle arbitrary video pipelines).

But as I said earlier, we can do just fine without the HDMI connector
node on boards where the connector "just works". We can handle that in
the drivers with some extra code.

So if people think it's a big chore to add the connectors and don't see
the benefit in them (and they don't want the symbolic labels that could
be added there), I'm fine with having them optional.

 Tomi



--8kM4mHirpQ99SOdiaIn9NgUAP7boFtkjB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9XJDAAoJEPo9qoy8lh714zcP/0r4y+sfKYDp3Ot6XG/JR7jF
JrkWsblwMe25+g7ac5d4t1M7scFmqgLkvHn6sPdWZajXSwHycvzUBO2mQfhJjhhg
CFXn5QCPJAugy+E6IIuaQUaU14qc0BIadMttYwjd/jFAeF6Ig5sAWbfw69Yt3eJp
flaoQVgC0+EVmM+uovKZMQQnJYti/NvE/nnGWDPc/Cn/cJZUdSQeq/cOiSEUDMtF
+fdrtWUtx69xs7xB7IEMImmFCcKn3yka6AZSIuQop5FJ4dEhkHNCay2jOZUw3iFj
NnD8M87NswDg+EI+zjwKHRbhebI1kWAKMhQJEqRNy3RcPpMUcF2n+IVaiMjU7LCQ
pHCJu6Mb9aiXJV2rtISCmzLssEjpXqwfue2cDElknO3Axdzu0Q8oJNml+MtKsBEx
BgwXmJqOHiGHiWbyKflpO2hOl4CpbcWsTv4N7zpfX0TMHt7x9wDDq5slPipcQeq/
FNALvQM0+DDmKSaZtNsX5rFpC1loQzGAagqhmSpGdhZlIrbU0RDzUJ9ZmM8VAbD0
P0OgodTnA5ZJLpNkK8F1fHRDUBOxUR/SHzE7IboQgXmQoHvZqkapXlDspSDJ6AHG
A6huGw/LQJhBOnAscownahBM1it+wp2dGUIRYEonH7+ycvbaH0RusgjaDmW57Uyf
mEAptsierbKuf6ccaFhz
=u2j4
-----END PGP SIGNATURE-----

--8kM4mHirpQ99SOdiaIn9NgUAP7boFtkjB--
