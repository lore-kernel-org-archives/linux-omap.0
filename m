From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Wed, 25 Sep 2013 13:50:18 +0300
Message-ID: <5242BFEA.1090200@ti.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com> <52427ECA.1080500@ti.com> <CAAfyv37sSa=7x=p1wgX+Rhdxh=WMB4DhmC9ZQMpxB_rb30Aurw@mail.gmail.com> <3A4BA9B4-262C-4F0A-95B7-D243065D01BA@goldelico.com> <52429F06.6030609@ti.com> <307BD8A2-738A-4A66-8FD5-98C37AD4BCA3@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="833s4FSO13X126SprA9lLGGIeFn681iM8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54640 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab3IYKuY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Sep 2013 06:50:24 -0400
In-Reply-To: <307BD8A2-738A-4A66-8FD5-98C37AD4BCA3@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-omap@vger.kernel.org, Belisko Marek <marek.belisko@gmail.com>

--833s4FSO13X126SprA9lLGGIeFn681iM8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/09/13 12:00, Dr. H. Nikolaus Schaller wrote:

>> Well, OPA is a distinct hardware block in the video path, I see no iss=
ue
>> in having an OPA encoder driver, that sits in between VENC and the
>> connector.
>>
>> The driver should handle things described in the OPA datasheet. With a=

>> quick glance, there seems to be one GPIO and one power line to OPA.
>=20
> Hm. Why need a driver for a specific piece of hardware? For software it=
 is just an
> analog TV out with additional control options.

I'm not sure I follow. Linux device drivers are drivers for specific
pieces of hardware. If the hardware needs to be controlled somehow, like
setting gpios, enabling regulators, then we need a driver for that piece
of hardware.

> And, it must not be the OPA362 - it could be something completely diffe=
rent.

Right. If it's something completely different, then you need a driver
for the completely different piece of hardware. At the board code, or
board's device tree data, you specify which pieces of hardware you have
on your board, and the respective drivers are then used.

>> So, is the GPIO the one that goes to OPA?
>=20
> Yes. Like the enable_gpio in struct panel_dpi_platform_data.
>=20
> So I now think we would be happy if the connector-analog-tv would have =
a gpio
> in its platform data that can handle such an enable/disable.

Sure, but the gpio is not related to the connector, it's related to
another component. And say, if we added the enable gpio to the
connector. What if the next board uses another version of OPA that
requires two gpios. Should we then add another gpio to the connector?
Maybe third also? How about a bunch of regulators? Where does it end?

>> The DEVCONF1 register is problematic. For that we need some kind of
>> platform hooks. We have some already for PM and DSI pins, so we could
>> add a new one for TV-out. However, the DSI pins (hopefully) could be
>> handled by the pinmuxing framework. Maybe that would be applicable her=
e
>> also.
>=20
> Hm. Looks like a complex solution for a simple problem and isn't relate=
d to
> pinmuxing (IMHO).

Right, I only suggested pinmuxing as that's why we need the callback for
DSI. I don't remember the details about DEVCONF1 and tv-out.

And I disagree that it's a simple problem =3D). Making generic, reusable
drivers is not simple. Making a hack to make it work on your particular
platform and board is simple, though.

> Could we just add a "enable_ac" and "enable_bypass"  to struct connecto=
r_atv_platform_data,
> that sets/resets these flags in the DEVCONF1 register each time the tvo=
ut is enabled?

No, those are properties of the SoC, as far as I understand, nothing to
do with the connector. Although I have to say I have no idea what "TV AC
coupled load enable" or "Active high enable AVDAC TV out bypass" do.

I guess I need to refresh my memory on the VENC, although if I recall
right, it wasn't explained very well in the TRM.

Also, note that drivers cannot touch DEVCONF1 register. That can only be
touched by the OMAP's platform code. So there has to be some kind of
callback or API to do that. And while the display drivers for OMAP are
currently OMAP specific, they will be made generic at some point, and
actually are already designed to be so. So they may not contain any
OMAP'isms.

> I think this would be very similar to the "invert_polarity" property.

I have to say that I don't quite remember what the invert_polarity is
used for, but I think invert_polarity might be misplaced also. Is the
analog video signal that goes out from the connector inverted? I don't
think so. Does the connector require an inverted signal? No, as the
connector is really nothing else than a pass-though connector.

Correct me if I'm wrong, but I think the invert_polarity is required if
there's something on the board that requires the signal to be inverted
(OPA?), and it'll be re-inverterted before the signal goes to the analog
connector.

> Then, the platform data has more control over the shape of the signals =
created by
> the VENC (independently of that we use an OPA362).
>=20
> IMHO this topic is very similar to controlling the polarity and timing =
of the
> HSYNC/VSYNC of a LCD (.flags in struct display_timing), i.e. shaping th=
e
> interface signals so that they are accepted by the hardware connected t=
o
> the DM3730.

Well, I was never too well into the analog TV-out side, so please argue
if I say something silly here. But generally speaking, there are two
different kinds of properties here.

Consider DPI output from the SoC, and a DPI panel. Let's say the DPI
panel requires horizontal sync signal to be active high. It's a property
of the panel, and it makes sense (at least to me) to think that the DPI
panel asks the DPI encoder to provide a signal with hsync active high.
Also, it doesn't matter what kind of DPI encoder there is, the hsync
active high is a "universal" property.

Then, let's say the board has some electrical issues and requires the
DPI signals to be of slightly higher voltage than normally. I think OMAP
at least has bits to driver some pins with higher voltage. This property
is not about panel. There could be lots of different kinds of tweaks for
different SoCs, and they are SoC (or DPI encoder) specific things. Here
is makes no sense to have a property for the panel.

To me, enable_ac and enable_bypass sound like the latter kind.

 Tomi



--833s4FSO13X126SprA9lLGGIeFn681iM8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQr/qAAoJEPo9qoy8lh71x6cP+wfvG5m3NqUqml89terwcEil
3znefIhEuxOG4i6XHvvVQ5vIzwBo8XDf4sZHCrRuEO7lLjBAS8ZmnmkW36GEvaBk
C8tGK9XZWAX6LicmvzA94Jt0mPd4lTt3MwcKkD8WLHi2Md5uCLzdD2YyiKnF+PYS
gEiN5bI3SZk+SbZASwFos9hJmtQa8/TJoUzGgqSbnrTC98+k8JO1j9NLTJXMgcEI
qh5/3BaCLQI7S3h/cXmx7vguQ7k2JES4QTcjY6/6EUL1wbOVyXWtHARyHP0/ZY+5
80QYi6GspgaIw0wCXz9f2EafEaKbE+EaS4zM4R5WCdAj6NcsC5bAv4S5Ry9ljEp+
jj9qX2W5kpUUSIJc1PSz5l5GLGSkJj/mzMoa+2ZymfJA68p8LOKtkbBCDL8xZRdS
T4FHFT8HR6OkNgrtQvha5oBu5B2qAkbHKbe/XylUPPXVbUdKX4PhBctbnp4pSLuQ
SCw6mdlnA+YiehgULdsxTjyFZiTZLbCq4pnep6cpV2lKJTR+2Q/71INkTWs9OqdI
u4PV5Z4CYZiwEOA01NJvbjwWFp/JYV4X1w2AmXDp5MSv44i4K9coFyno1Mqdn8uz
m6lM9AT/8eiuLbOVuKkNVcw0qo4p0uUlqwrT7L7ai4Qeat2qqxBC6oO/RzzNJ3sb
SgRHHe872Tba0auOh2yG
=SMUI
-----END PGP SIGNATURE-----

--833s4FSO13X126SprA9lLGGIeFn681iM8--
