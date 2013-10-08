From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RESEND PATCH v3 03/11] ASoC: davinci-mcasp: Add DMA register
 locations to DT
Date: Tue, 8 Oct 2013 13:07:05 +0300
Message-ID: <5253D949.2040008@ti.com>
References: <cover.1379590035.git.jsarha@ti.com> <66bdda0c0b75d737d649260b9ec10f9f870c20cd.1379590036.git.jsarha@ti.com> <20131007214718.GA2976@kartoffel> <5253CCD7.2080606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54307 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015Ab3JHKHF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Oct 2013 06:07:05 -0400
In-Reply-To: <5253CCD7.2080606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, Mark Rutland <mark.rutland@arm.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "joelf@ti.com" <joelf@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>, Daniel Mack <zonque@gmail.com>

Hi,

On 10/08/2013 12:13 PM, Jyri Sarha wrote:
>> I have some questions however. I took a look at the McASP (TMS320C60=
00)=20
>> reference guide, and the registers appeared to all be in one contigu=
ous
>> bank, and "mpu" and "dma" don't appear to be names of particular
>> registers or names of banks of particular registers. Am I looking in=
 the
>> wrong place? Is there up-to-date documentation I can look at?
>>=20
>> Why are these split across two reg entries, and which particular
>> registers do they actually cover?
>=20
> The need for two different register properties does not come from McA=
SP
> IP, but from SoC design. On AM33XX the McASP registers are mapped for=
 MPU
> through L4 bus, which is no accessible to the DMA controller. The McA=
SP
> data port registers are mapped trough L3 buss to a different address =
for
> DMA controller. Maybe the second register property could be called to=
 "dat"
> instead of "dma" since only data port registers are mapped trough tha=
t
> address.

We have discussed this with Jyri and we are going to use 'dat' for the =
data
port address. The driver can configure the IP via the 'mpu' area but it=
 is
preferred to use the 'dat' or data port of McASP when it comes to data.=
 It is
possible to use the transmit/receive buffer registers in the 'mpu' area=
 but it
get's complicated when more than one serializer is used.

>>> - op-mode : I2S/DIT ops mode.
>>=20
>> What type is this?
>=20
> That property selects whether McASP is working in I2S mode or in
> Integrated Digital audio interface Transmitter (DIT) mode for S/PDIF,
> IEC60958-1, AES-3 formats.

Not sure but we might be able to handle this via standard ASoC way, via=
 the
da_fmt so the machine driver will tell the mcasp driver what is the for=
mat it
needs to send the data. Adding SND_SOC_DAIFMT_SPDIF/IEC60958/AES3 to co=
re will
be needed.

>=20
>>=20
>> What are valid values?
>=20
> 0 and 1. I'll document those. Thanks.
>=20
>>> - tdm-slots : Slots for TDM operation.
>>=20
>> Here too. This description is completely opaque.
>>=20
>=20
> I am not absolutely sure here. I'll check the details and try to come=
 up
> with a better description.

Not sure about this either, my interpretation of what it means:
number of channels to be sent via one serializer.
as an example:
We have 3 stereo codecs in the design
all of them are connected to the same McASP instance but to be fed via
different serializer:
AXR0 - codec0
AXR1 - codec1
AXR2 - codec2

Since the codecs are stereo -> tdm-slots =3D <2>; two channels/serializ=
er

If the stream is stereo we only ouput to codec0 via AXR0.
If the stream is 4 channel, the first 2 channels will be via AXR0 to co=
dec0
the next 2 channles will be sent to codec1 via AXR1. and so on.

I think it would be possible to extract this information from the seria=
l-dir
property + machine driver configured DAI_FMT and from the coming stream=
=2E I2S,
L/R justified is stereo, in DSP modes we can have more channels. In the
serial-dir array we could count the AXR directions. Basically all the
information which is needed to make this redundant are there.
But we have the legacy davinci users at the same time and we do not wan=
t to
break eisting users.

I think Daniel Mack (CCd) can clarify my understanding of the tdm-slots=
=2E

>> It looks like some pins can be used as GPIO -- is there not a need f=
or=20
>> something like pinctrl for configuring this?
>>=20
>=20
> That is true, but since driver does not support it and there is no ex=
ample
> of GPIO usage, no guess work has been done about the required DT
> properties.

This is kind of complicated issue. Any of the McASP pins (CLK, FS, AXR,=
 etc)
can be configured to be used as McASP pins or GPIO pins. This configura=
tion is
McASP IP specific, need to be done within McASP.
pinctrl is overkill for this IMHO but we would need a gpio driver for M=
cASP.
If some driver requests a gpio in McASP we can just switch that pin to =
GPIO
mode, however this brings up quite a bit of questions:
- embedd the gpio driver into the dai driver?
 - if the system does not have audio -> no GPIO driver for the rest?
- separate driver for gpio functionality?
 - Sanity cheks all over the place on which pin is GPIO or McASP.

and so forth.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
