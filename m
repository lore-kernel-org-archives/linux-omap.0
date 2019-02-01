From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH v3 2/2] arm: dts: gta04: add gps support
Date: Fri, 1 Feb 2019 21:09:15 +0100
Message-ID: <24F5EECA-86E0-4462-AC9F-1BD986EAD7F4@goldelico.com>
References: <20190131180640.14480-1-andreas@kemnade.info> <20190131180640.14480-3-andreas@kemnade.info> <20190201100416.GD3691@localhost> <20190201200630.2efc9eef@kemnade.info>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201200630.2efc9eef@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi Andreas,

> Am 01.02.2019 um 20:06 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Fri, 1 Feb 2019 11:04:16 +0100
> Johan Hovold <johan@kernel.org> wrote:
>=20
>> On Thu, Jan 31, 2019 at 07:06:40PM +0100, Andreas Kemnade wrote:
>>> The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
>>> which one is mounted so use the compatibility entry for w2sg0004
>>> for all which will work for both.
>>>=20
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>> Changes in v3:
>>> - converted to a patchset
>>> - added vcc-supply
>>>=20
>>> Changes in v2:
>>> - some s/gps/gnss/
>>> - not added vcc-supply because the regulator is not modelled
>>>  in dts at all
>>>=20
>>> w2sg0004 bindings are in next-20190129
>>>=20
>>> arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
>>> 1 file changed, 14 insertions(+)
>>>=20
>>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
>>> index 02d8274a2f47..4ea0f7dc37c6 100644
>>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>>> @@ -320,6 +320,12 @@ =20
>>> 		>; =20
>>>        };
>>>=20
>>> +	gps_pins: pinmux_gps_pins { =20
>>=20
>> s/gps/gnss/ would be more consistent, but whatever.
>>=20
> well, gps is already in the file at another place. So it is a bit
> inconsistent in any case, without further cleanup. If someone comes
> up with a strong opinion here I would of course change it.

For me the highest priority is that it works. And that does not depend
on the specific node name. The pinmux node is only referenced through a =
phandle,
which is translated into a pure numeric code by DTC.

Another argument could be that the w2sg0004 chip was introduced ca. 2007
when GPS was (AFAIR) the only GNSS system widely available and the only =
one
supported by the chip. So this would be an argument for "gps" since it
is a "GPS only" receiver chip.

Since the DT should describe specific hardware, it maybe should somehow
codify that the chip is GPS only and is not a generic gnss chip =
(although
the driver knows that as well).

BR,
Nikolaus
