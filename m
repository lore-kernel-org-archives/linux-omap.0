From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange platform devices
 for ASoC drivers
Date: Thu, 22 Nov 2012 14:52:50 +0200
Message-ID: <50AE2022.8080607@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com> <1353029819-21809-3-git-send-email-ricardo.neri@ti.com> <50A5F0A5.2010105@ti.com> <50A6805C.3050004@ti.com> <50AA2D01.5020302@ti.com> <20121120011526.GF4483@opensource.wolfsonmicro.com> <50AD6FB0.3050808@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEB732D08C1CF61468B2E5193"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43143 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788Ab2KVSeN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 13:34:13 -0500
In-Reply-To: <50AD6FB0.3050808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, tony@atomide.com, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

--------------enigEB732D08C1CF61468B2E5193
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-22 02:20, Ricardo Neri wrote:
> Hi Tomi, Mark,
>=20
> On 11/19/2012 07:15 PM, Mark Brown wrote:
>> On Mon, Nov 19, 2012 at 02:58:41PM +0200, Tomi Valkeinen wrote:
>>
>>> I still don't understand why the codec and machine drivers need to be=

>>> created in the board file. That just forces us to replicate the same
>>> code for all OMAP boards that have OMAP HDMI output. Why not create t=
he
>>> devices in some common code, for example arch/arm/mach-omap2/display.=
c?
>>
>> Yes, this would be more sensible if there's no board specifics involve=
d.
>=20
> I think they are truly board-specific. For instance, there could be som=
e

I don't =3D).

> board that does not have the OMAP HDMI IP wired to an external
> connector. We don't want the drivers to be probed in that case. If they=

> are in common code, the devices will be created even if a board does no=
t
> have HDMI output.

The HDMI devices are still there in the HW even if we don't have a HDMI
connector. I don't see any problem with probing the HDMI audio driver
even in that case.

But of course the user space shouldn't see a usable HDMI display/audio
if there's no connector. For display side this is managed so that the
HDMI IP driver is always loaded, but a HDMI panel driver is only there
if the board file tells that we have a connector.

I guess this could be optimized by having a "disabled" flag for HDMI IP
driver, so that it wouldn't even need to allocate any private data
structures of such. But the savings would be quite minimal.

>>> With DT this should be similar: OMAP's hdmi devices should be present=
ed
>>> in the omap4.dtsi file, not in each individual board dts. Although th=
e
>>> DT data should represent the hardware, and if the code and machine
>>> devices are not really there in the HW, then... I don't know =3D).
>>
>> Well, in a case like this where the sound card is essentially autoprob=
ed
>> based on the detection of the hardware at runtime the sound card
>> probably shouldn't appear in the device tree at all - you'll probably
>> want something to say there's a physical HDMI port it's worth looking =
at
>> there but everything else should be figured out at runtime.
>=20
> Yes, I was planning to rely on the DSS DT entries in the omap4.dtsi
> file. However, no HDMI audio support should be probed if the board does=

> not have an HDMI connector. Also, the TPD chip should appear on the
> Pandaboard/SDP4430 dts files. Only if both conditions are met, probe th=
e
> HDMI audio drivers, this conditions will be checked at run time by the
> ASoC HDMI machine driver.
>=20
> Something like this:
>=20
>     sound_hdmi {
>         compatible =3D "ti,omap-hdmi-card-audio";
>         ti,model =3D "OMAP4HDMI";
>=20
>         ti,hdmi_audio =3D <&hdmi>;
>         ti,level_shifter =3D <&tpd12s015>;
>     };
>=20
> The ASoC machine driver would create the platform device for the HDMI
> codec if the DT has the required nodes.

The TPD chip really shouldn't be here in. It's an external component,
not related to audio in any way. I think the HDMI audio driver should be
only concerned about the HDMI IP. The HDMI IP video driver shouldn't
care about TPD chip either, but for now we need to manage it somewhere,
and that's the easiest place for it.

So... I'm not sure how this should be managed, but I am 99% sure that
there's nothing board specific with HDMI audio, and thus it should be
managed in common .c files in arch code or dss code, or .dts files. If
we add the hdmi display in the .dts files, I think the audio should just
work.

Or is there something in ASoC that forces us to represent it in the
=2Edts? I don't think there's really anything related to HW to describe
there related to HDMI audio. If we have HDMI video output, we also have
the audio, as simple as that.

 Tomi



--------------enigEB732D08C1CF61468B2E5193
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQriAiAAoJEPo9qoy8lh71docP/1RC9mq9/Sd5mMty5+RHdg+G
BEB2UHHKt6hR3vBKtgK/DAwFirLkm7PegmGqXL8AG1YrRpEOG0ZI+0nhG61n4PiI
6u72NG9/Rqs5fxu1ecIslGp/+mWmsuj37Qgl/VMvrFzgTBf2qQTH5gcm5mU61lNW
UQE5xO0GvUYDp6/1Yk6MwPv6JqOO0ZGK14OvS51U2sozsAg9qlNTz4v1RO20RwtV
Qj67NmPfclB2FmR3STz+ij2eMcP6t37Oq/zSXtf5T39JEccCMqZ6GAEqcR4eeADa
wqknKmR1r/9kYvNyOzSZU4SFMmoOZwdDO9PSIsm54G5WH7k6IrAiOUqIIwjfgHw0
aSYp+lLvRYb0t6nTCfrtPGwsLRu5R/hCy9wOI5LFjsFXy1vW3NoMOnysyq5djPPP
AUnbb6zQsCZj4enWq2X6nFk7EqBMF38o9P8fxOQElGfR4h9OErXZOYBR/rgqGNB2
Yi8Ye0PESxd4mklW/4MLDgQ09WOk2Yd/Xi0WBmBXH/gg4VqaWBpVAYy9mpzon7do
j+uaOJ7YNHP7OH5VFS5BCoy/Vh6eRKHimk/P1Z1QQLYOKyOoUsMqbXo/+mtPWWno
xRD0kh/dymxLz8u5s1DREkIRg0GbNz4UT5VbsMmu+wGObkcpmfrOWXQKhWbbiIM0
qNlDk4Fqbqh6wIrpUacc
=WUbK
-----END PGP SIGNATURE-----

--------------enigEB732D08C1CF61468B2E5193--
