From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 10/32] ARM: dts: omap3-gta04: update gpmc NAND setup
Date: Wed, 25 Jul 2018 11:08:38 +0200
Message-ID: <D3257490-7688-4F4E-896F-1ADD1B3A3DD8@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com> <effe8969751cde3a3cd7993aa66c839493af9dd1.1532501910.git.hns@goldelico.com> <20180725081058.GB7467@lenoch> <1E7B727D-1AED-4B00-AD2C-CF9FC562E53D@goldelico.com> <20180725082810.GA8303@lenoch>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725082810.GA8303@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Marek Belisko <marek@goldelico.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org


> Am 25.07.2018 um 10:28 schrieb Ladislav Michl <ladis@linux-mips.org>:
>=20
> On Wed, Jul 25, 2018 at 10:16:28AM +0200, H. Nikolaus Schaller wrote:
>> Hi,
>>=20
>>> Am 25.07.2018 um 10:10 schrieb Ladislav Michl =
<ladis@linux-mips.org>:
>>>=20
>>> On Wed, Jul 25, 2018 at 08:58:42AM +0200, H. Nikolaus Schaller =
wrote:
>>>> to better match omap3-beagle.dts (which was the basis
>>>> of designing the GTA04).
>>>>=20
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>> ---
>>>> arch/arm/boot/dts/omap3-gta04.dtsi | 14 +++++++-------
>>>> 1 file changed, 7 insertions(+), 7 deletions(-)
>>>>=20
>>>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
>>>> index 03fe404cbf56..9568e0c4d4bf 100644
>>>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>>>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>>>> @@ -616,27 +616,27 @@
>>>> 		interrupt-parent =3D <&gpmc>;
>>>> 		interrupts =3D <0 IRQ_TYPE_NONE>, /* fifoevent */
>>>> 			     <1 IRQ_TYPE_NONE>;	/* termcount */
>>>> +		ti,nand-ecc-opt =3D "ham1";
>>>> +		rb-gpios =3D <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 =
*/
>>>> 		nand-bus-width =3D <16>;
>>>> -		ti,nand-ecc-opt =3D "bch8";
>>>=20
>>> You are using weeker ECC scheme just to be compatible with another =
machine?
>>=20
>> No not another machine. The GTA04 uses the same SoC and NAND chip as =
the BeagleBoard,
>> so you can imagine GTA04 being a BeagleBoard + a lot of other things.
>>=20
>> The key reason is to change the ecc scheme is to be compatible with =
the U-Boot used.
>>=20
>> BootROM can only handle ham1 for the MLO. And there is no =
nand-ecc-opt
>> for each partition. So we either can't mix ECC schemes if we want to =
be able
>> to read/write MLO as the first partition from kernel.
>>=20
>>> So now you cannot boot already deployed filesystem...
>>=20
>> No. We always used ham1 and bch8 wasn't working at all here. =
Therefore nobody
>> did use upstream kernel for NAND yet...
>>=20
>>> Also is it enough for
>>> NAND chip used?
>>=20
>> Well, the chip is recommended to use bch8 but BootROM imposes above =
mentioned limits.
>=20
> Then common way to handle such a situation is to use 1bit hamming for =
MLO and BCH8 for
> the rest. You will end with corrupted filesystem with ham1 which I'd =
consider very
> unfortunate.
>=20
> (I know there were endless discussions how to handle this situation. =
It is already
> solved in U-Boot and for updating MLO from Linux I'm using writeloader =
tool)

Never heard of this tool, but we haven't followed this discussion for =
years since
we never had problems with "ham1-everywhere". What I am not completely =
sure is if
ubifs is using its own ECC scheme or not. If it is (like I assume), the =
user-space
partition is independent of this setting and we just have discussion for =
MLO/U-Boot
and kernel partitions.

So I think it boils down to the question if
a) upstream should do a suboptimal thing, but be compatible to the =
current vendor kernel and u-boot
b) upstream should do the right thing, but stay incompatible

Result of b) would e.g. a stock Debian kernel will not be able to read =
or write the partitions of a device
created with vendor kernel.

And even worse, it is not clear if users will want to erase and reflash =
the NAND to match what kernel.org defines if they have a running system.

This makes me believe that a) is still better for practical reasons, =
even if technically worse.

BR,
Nikolaus

>=20
> 	ladis
>=20
>> BR,
>> Nikolaus
>>=20
>>>=20
>>> 	ladis
>>>=20
>>>> +		#address-cells =3D <1>;
>>>> +		#size-cells =3D <1>;
>>>>=20
>>>> -		gpmc,sync-clk-ps =3D <0>;
>>>> +		gpmc,device-width =3D <2>;
>>>> 		gpmc,cs-on-ns =3D <0>;
>>>> 		gpmc,cs-rd-off-ns =3D <44>;
>>>> 		gpmc,cs-wr-off-ns =3D <44>;
>>>> 		gpmc,adv-on-ns =3D <6>;
>>>> 		gpmc,adv-rd-off-ns =3D <34>;
>>>> 		gpmc,adv-wr-off-ns =3D <44>;
>>>> -		gpmc,we-off-ns =3D <40>;
>>>> 		gpmc,oe-off-ns =3D <54>;
>>>> +		gpmc,we-off-ns =3D <40>;
>>>> 		gpmc,access-ns =3D <64>;
>>>> 		gpmc,rd-cycle-ns =3D <82>;
>>>> 		gpmc,wr-cycle-ns =3D <82>;
>>>> 		gpmc,wr-access-ns =3D <40>;
>>>> 		gpmc,wr-data-mux-bus-ns =3D <0>;
>>>> -		gpmc,device-width =3D <2>;
>>>> -
>>>> -		#address-cells =3D <1>;
>>>> -		#size-cells =3D <1>;
>>>> +		gpmc,sync-clk-ps =3D <0>;
>>>>=20
>>>> 		x-loader@0 {
>>>> 			label =3D "X-Loader";
>>>> --=20
>>>> 2.12.2
>>>>=20
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe =
linux-omap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
