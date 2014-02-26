From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Wed, 26 Feb 2014 13:14:18 +0200
Message-ID: <530DCC8A.6060708@ti.com>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <20140225123921.GY27282@n2100.arm.linux.org.uk>
 <20140225134139.GA23898@earth.universe> <2364124.7r818M0xAj@avalon>
 <20140225205634.GZ27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6935275476016926794=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140225205634.GZ27282@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Reichel <sre@ring0.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Ash Charles <ash@gumstix.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>
List-Id: linux-omap@vger.kernel.org

--===============6935275476016926794==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hM1PmSRfJVGw8ePw6eIAEEfSvbi6hsQtM"

--hM1PmSRfJVGw8ePw6eIAEEfSvbi6hsQtM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 25/02/14 22:56, Russell King - ARM Linux wrote:
> On Tue, Feb 25, 2014 at 05:51:21PM +0100, Laurent Pinchart wrote:

First I want to summarize the omapdss DT bindings, even if it was
already more or less covered earlier:

We have a bunch of panels and encoders used on OMAP boards, and we have
separate, omapdss specific, drivers for those. My plan is to continue
improving those drivers until they can be platform independent. This
would be the Common Display Framework that's been discussed (or a
precursor to it).

We need DT bindings for OMAP display, and one option would've been
adding a compatible string of "ti,xxx" for every panel and encoder. That
would obviously be wrong DT representation. So I wanted to do proper DT
bindings, with proper compatible string.

This creates the problem that we don't have generic drivers for those
components yet. For this, I created a hack that, on OMAP, appends
"omapdss," to the display components at boot time. This way we can have
OMAP specific drivers for the time being, but others could still use the
same bindings for their platform and platform specific drivers with
similar trick.

Note that the above is not merged yet, but I'd really want to get it in
for the next merge window, so if that general concept is bad, please
nack it asap. And preferably give ideas for an alternative =3D).

>> I don't think all physical connectors require a DT binding per-se, but=
 they=20
>> need to be represented in DT as they're part of the hardware. We could=
 push=20
>> connector-related information to the nodes of all chips that have inte=
rfaces=20
>> wired directly to connectors, but that would result in more complex DT=
=20
>> bindings and core. I believe modeling connectors using separate DT nod=
es is be=20
>> best, and would allow easier support for more complex connectors that =
carry=20
>> multiple streams/signals in parallel (video, audio, DDC, ...).

There are things we need to represent for the connectors. For example, a
+5V going to the connector is not managed by any IP. In some cases
neither is a hotplug detect GPIO. The i2c lines for the DDC need to be
managed by someone (with DVI. HDMI DDC on OMAP is managed by by the HDMI
IP).

I guess one could argue that those are standard properties of HDMI or
DVI, and thus could well be managed by the HDMI or DVI encoder, even if
the encoder IP itself doesn't have anything to do with those. Maybe they
could, but I think modeling the connector separately is more correct,
and allows more freedom.

Say, the HDMI could as well be directly wired to a panel, without any
connector, although this is perhaps more common with eDP. In that case
the connector related things can be just left out.

Additionally, but perhaps not strictly needed, the connector represents
a "termination" for the display pipeline, so there's a distinct display
element at the end of the chain, sometimes a panel, sometimes a
connector, which marks the end. This makes the pipeline consistent in
the case where you've got an encoder, output of which goes on some
boards to a connector and on some boards to a panel (compared to some
boards having a panel after the encoder, and some having nothing).

> There is some sanity to representing physical connectors in DT, but it'=
s
> not for the reason you mention above.  If you consider that it's possib=
le
> on PCs to find out what connectors are on the motherboard and where the=
y
> are located, this is very useful information to be stored and presented=
=2E
>=20
> However, the idea that you combine streams at connectors is not a
> universal truth, and is certainly false for HDMI.  HDMI combines video
> and audio at the encoder stage, not at the connector stage, and many
> HDMI encoders will provide everything required for driving the connecto=
r.
>=20
> However, my major objection here is not really that: my major objection=

> is using something as generic as "hdmi-connector" as a compatible strin=
g.
> The reason is that we have to remember that DT is not just "a Linux thi=
ng".
> It's /supposed/ to be an OS independent representation of the hardware.=

>=20
> If we invent something generic called a "hdmi-connector" then we had
> better first do a thorough search to make sure we're not trampling on
> anything which is standardized or becoming a standard - if there is,
> we should work with them - and if that's not possible, then we need to
> distingush ourselves from them.

Yes, I agree that the connectors (DVI, analog-tv, and HDMI) are in a
sense much more generic than bindings for a single IP, and thus more
important to get right.

> What we can't do is go around inventing generic stuff without having ou=
r
> eyes wide open.
>=20
> So, here's a good question to probe how far this has been thought throu=
gh
> already: what has been done to discuss the creation of this generic
> "hdmi-connector" thing with the various parties who are interested in
> HDMI outputs under DRM using device tree?

They have been discussed, in the context of Common Display Framework
proposals, and in the context of OMAP DSS DT bindings. They've seen
multiple review rounds, but I agree that finding about the connectors
there may be rather difficult if one is not interested in OMAP DSS, or
one see CDF as nonsense.

Those OMAP bindings are used on both OMAP fbdev and DRM drivers, so at
least in that case they've been proven to work on both frameworks.

> If that hasn't happened, that's quite a failing - it means that we're
> on the road to having two _implementation specific_ DT representations
> for the same hardware - one for fbdev and one for DRM.  That really
> isn't on.

I hope not. Afais, the bindings are really about the HW. Not fbdev or DRM=
=2E

At the moment I do see that usually the existing fbdev and drm bindings
are, in my opinion, quite bad. They don't give proper and detailed
description of the hardware, in a way that should work on other
platforms with very different display pipelines.

The proposed bindings in my patches are the designed to be as generic as
we've (mostly me and Laurent) been able to make them, and very similar
ones have been used by Laurent on shmobile for his CDF patch series.

The HDMI connector in particular doesn't even define much anything at
all. At the moment, it only defines the connection to the previous item
in the display pipeline, usually the HDMI encoder. The +5V I plan to add
at some point, and it should be a clear addition, it's there by the
spec. The same for HPD and i2c, although those should be optional so
that an IP can handle those if the system is so designed.

So while I fully confess that I haven't looked at other platform's HDMI,
I don't see how the above could go badly wrong. The connector would
obviously be extended later to add any missing features.

> Yes, it then opens a pandora's box of problems about how we determine
> whether DRM or fbdev should bind to the DT nodes, but that should be
> an entirely separate issue (and, ideally of course, both should use
> the same sub-drivers for the components.)

Yes, this is what the common display framework tries to accomplish. But
as you say, it's a separate issue. The DT bindings should just model the
hardware so well that we're as confident as we can be that the current
boards can be described with those.

So how to go forward? It's very difficult to get feedback on complex DT
bindings. I recently posted only the DT documentation part for OMAP DSS
[1], in hopes to get some feedback for a smaller series, but nothing so
far. It might be easier to look at the whole series [2] to see how the
board dts files are changed, though.

Maybe the subject "OMAP DSS DT bindings documentation" is not quite
correct, as there's really nothing OMAP specific there except the SoC
bindings itself. Perhaps re-sending with subject of "Generic display
bindings" would catch more eyes.

 Tomi

[1]
http://mid.gmane.org/1392294752-18762-1-git-send-email-tomi.valkeinen@ti.=
com

[2]
http://mid.gmane.org/1390301833-24944-1-git-send-email-tomi.valkeinen@ti.=
com



--hM1PmSRfJVGw8ePw6eIAEEfSvbi6hsQtM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTDcyKAAoJEPo9qoy8lh71j/kP/0a0jO8u6bIVZCm2c9WUXha8
aRlsS05UrSJqVvKsE0bMIjxKtkxj66YOHYDS7pWhXBoZR/2BEgvGGe9hb8N0YfzR
c8PkUinEURiAzECKOO0XE90TlxEbo7QKvvIr5wGIL9ms1TiH8iKLUH4WnWrriwbK
VEDJeC0ZJ3oXXGw83qOwJ8lIZetkqHUZXExl3oeL28tYXWgC7SOFEXgo4dHcwT0R
Fow/c77vps3NLhck0Jr4j8rBl/TRDzuUo4W9CrugHzdFwK3tO/i9oMR25sDJyZwv
k31tBu1Vg7PgBdl054b3bg4WTS3oGih480ScKz+7fnM75fXAHBYpOpe3b7IVaSfg
WMIE+LyESQqQuVQ/h8ilijfRhPwO5bGD0XK1HUVbCxLZN0fSzpkk66+4yMQ8Kav1
QwGOdHWMhudguSDEmCi9dm1NfX38RpMeu1zkiB7YHL5K/KBbYrAm573Uh5UCdX7Q
LhABL3rHIbjfde5j/8lNBwZn6R3ya0NIEyFO+CdufBA7bL4Yn1ZPH/wk0Jo72jwa
v8JvncmXpvo8W7w+eH3S2CMlpByEoPjUQuybK+Mzym3dfX11NYiF+DCLMZ0dx7iD
LW3r9FDh+/LOgy3FlF1SJhX8gl/j01lmwpLbNV3DHD26y7pw0RD2nUaUSDaVE2h3
OrsuN2Vf9XEpaxoorZvy
=MHYg
-----END PGP SIGNATURE-----

--hM1PmSRfJVGw8ePw6eIAEEfSvbi6hsQtM--


--===============6935275476016926794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6935275476016926794==--
