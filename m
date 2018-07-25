From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH 09/32] ARM: dts: omap3-gta04: make NAND partitions compatible with recent U-Boot
Date: Wed, 25 Jul 2018 10:25:53 +0200
Message-ID: <D53ED583-D242-4BD9-BF84-80D4CB427ABB@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com> <8dcf3efd3270451314a663c125841ca87ed2b387.1532501910.git.hns@goldelico.com> <20180725080735.GA7467@lenoch> <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Cc: Ladislav Michl <ladis@linux-mips.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


> Am 25.07.2018 um 10:18 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
>=20
>> Am 25.07.2018 um 10:07 schrieb Ladislav Michl <ladis@linux-mips.org>:
>>=20
>> On Wed, Jul 25, 2018 at 08:58:41AM +0200, H. Nikolaus Schaller wrote:
>>> Vendor defined U-Boot has changed the partition scheme a while ago:
>>>=20
>>> * kernel partition 6MB
>>> * file system partition uses the remainder up to end of the NAND
>>> * increased size of the environment partition (to get an OneNAND =
compatible base address)
>>> * shrink the U-Boot partition
>>>=20
>>> Let's be compatible (e.g. Debian kernel built from upstream).
>>=20
>> That, in fact, is breaking compatibility.
>=20
> With what? Nobody is using the old u-boot partition scheme any more
> (it is >5 years old).
>=20
>> So once you are touching this
>> what about relying on partitioning provided by bootloader just to =
prevent
>> something like this happening again?
>=20
> Well, we define what compatible means here (since we are the vendor).
> And people complain with us. We simply recommend them to upgrade the
> boot-loader.

I should also mention that a modern and fully configured kernel binary =
is
already too big for a 4MB kernel partition.
>=20
>=20
>>=20
>> 	ladis
>>=20
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> arch/arm/boot/dts/omap3-gta04.dtsi | 12 ++++++------
>>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
>>> index 65f77a0b5dd4..03fe404cbf56 100644
>>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>>> @@ -645,22 +645,22 @@
>>>=20
>>> 		bootloaders@80000 {
>>> 			label =3D "U-Boot";
>>> -			reg =3D <0x80000 0x1e0000>;
>>> +			reg =3D <0x80000 0x1c0000>;
>>> 		};
>>>=20
>>> -		bootloaders_env@260000 {
>>> +		bootloaders_env@240000 {
>>> 			label =3D "U-Boot Env";
>>> -			reg =3D <0x260000 0x20000>;
>>> +			reg =3D <0x240000 0x40000>;
>>> 		};
>>>=20
>>> 		kernel@280000 {
>>> 			label =3D "Kernel";
>>> -			reg =3D <0x280000 0x400000>;
>>> +			reg =3D <0x280000 0x600000>;
>>> 		};
>>>=20
>>> -		filesystem@680000 {
>>> +		filesystem@880000 {
>>> 			label =3D "File System";
>>> -			reg =3D <0x680000 0xf980000>;
>>> +			reg =3D <0x880000 0>;	/* 0 =3D =
MTDPART_SIZ_FULL */
>>> 		};
>>> 	};
>>> };
>>> --=20
>>> 2.12.2
>>>=20
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe =
linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel
