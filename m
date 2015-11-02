From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 13/14] ARM: DTS: am33xx: Use the new DT bindings for
 the eDMA3
Date: Mon, 2 Nov 2015 12:19:49 +0200
Message-ID: <563738C5.4030309@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
 <1444979892-31626-14-git-send-email-peter.ujfalusi@ti.com>
 <CAOesGMg0KsHnbF8hEYPZ8bY8wz9fC0_m7-KS4A6kB__nUi9kAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOesGMg0KsHnbF8hEYPZ8bY8wz9fC0_m7-KS4A6kB__nUi9kAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Sekhar Nori <nsekhar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Robert Schwebel <r.schwebel@pengutronix.de>, "arm@kernel.org" <arm@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Olof,

On 11/02/2015 11:21 AM, Olof Johansson wrote:
> Hi,
>=20
> 1) This seems to have broken BBB in -next for me, bisected down to th=
is patch.
>=20
> For bootlog:
> http://arm-soc.lixom.net/bootlogs/next/next-20151102/bbb-arm-omap2plu=
s_defconfig.html

Aargh, I had the patch which should have been included to the series (j=
ust
sent it):
https://www.mail-archive.com/linux-omap@vger.kernel.org/msg121134.html

It was mixed with the patches I collected for 4.5, I don't know how thi=
s
happened, but this is the reason I have not seen the issue you are seei=
ng.

>=20
> 2) Please avoid merging DT/platform code in your driver tree, Vinod,
> at least without an ack from the platform maintainer. It can be a a
> huge mess if they end up causing conflicts, so we always ask to merge
> the DT changes through the platform maintainer (Tony in this case) by
> default.
>=20
>=20
> Thanks,
>=20
> -Olof
>=20
> On Fri, Oct 16, 2015 at 12:18 AM, Peter Ujfalusi <peter.ujfalusi@ti.c=
om> wrote:
>> Switch to use the ti,edma3-tpcc and ti,edma3-tptc binding for the eD=
MA3 and
>> enable the DMA even crossbar with ti,am335x-edma-crossbar.
>> With the new bindings boards can customize and tweak the DMA channel
>> priority to match their needs. With the new binding the memcpy is sa=
fe
>> to be used since with the old binding it was not possible for a driv=
er
>> to know which channel is allowed to be used as non HW triggered chan=
nel.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  arch/arm/boot/dts/am335x-evm.dts    |  9 +---
>>  arch/arm/boot/dts/am335x-pepper.dts | 11 +----
>>  arch/arm/boot/dts/am33xx.dtsi       | 96 ++++++++++++++++++++++++++=
-----------
>>  3 files changed, 73 insertions(+), 43 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am=
335x-evm.dts
>> index 1942a5c8132d..507980672c32 100644
>> --- a/arch/arm/boot/dts/am335x-evm.dts
>> +++ b/arch/arm/boot/dts/am335x-evm.dts
>> @@ -743,8 +743,8 @@
>>  &mmc3 {
>>         /* these are on the crossbar and are outlined in the
>>            xbar-event-map element */
>> -       dmas =3D <&edma 12
>> -               &edma 13>;
>> +       dmas =3D <&edma_xbar 12 0 1
>> +               &edma_xbar 13 0 2>;
>>         dma-names =3D "tx", "rx";
>>         status =3D "okay";
>>         vmmc-supply =3D <&wlan_en_reg>;
>> @@ -766,11 +766,6 @@
>>         };
>>  };
>>
>> -&edma {
>> -       ti,edma-xbar-event-map =3D /bits/ 16 <1 12
>> -                                           2 13>;
>> -};
>> -
>>  &sham {
>>         status =3D "okay";
>>  };
>> diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts=
/am335x-pepper.dts
>> index 7106114c7464..39073b921664 100644
>> --- a/arch/arm/boot/dts/am335x-pepper.dts
>> +++ b/arch/arm/boot/dts/am335x-pepper.dts
>> @@ -339,13 +339,6 @@
>>         ti,non-removable;
>>  };
>>
>> -&edma {
>> -       /* Map eDMA MMC2 Events from Crossbar */
>> -       ti,edma-xbar-event-map =3D /bits/ 16 <1 12
>> -                                            2 13>;
>> -};
>> -
>> -
>>  &mmc3 {
>>         /* Wifi & Bluetooth on MMC #3 */
>>         status =3D "okay";
>> @@ -354,8 +347,8 @@
>>         vmmmc-supply =3D <&v3v3c_reg>;
>>         bus-width =3D <4>;
>>         ti,non-removable;
>> -       dmas =3D <&edma 12
>> -               &edma 13>;
>> +       dmas =3D <&edma_xbar 12 0 1
>> +               &edma_xbar 13 0 2>;
>>         dma-names =3D "tx", "rx";
>>  };
>>
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33x=
x.dtsi
>> index d23e2524d694..6053e75c6e99 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -174,12 +174,54 @@
>>                 };
>>
>>                 edma: edma@49000000 {
>> -                       compatible =3D "ti,edma3";
>> -                       ti,hwmods =3D "tpcc", "tptc0", "tptc1", "tpt=
c2";
>> -                       reg =3D   <0x49000000 0x10000>,
>> -                               <0x44e10f90 0x40>;
>> +                       compatible =3D "ti,edma3-tpcc";
>> +                       ti,hwmods =3D "tpcc";
>> +                       reg =3D   <0x49000000 0x10000>;
>> +                       reg-names =3D "edma3_cc";
>>                         interrupts =3D <12 13 14>;
>> -                       #dma-cells =3D <1>;
>> +                       interrupt-names =3D "edma3_ccint", "emda3_mp=
err",
>> +                                         "edma3_ccerrint";
>> +                       dma-requests =3D <64>;
>> +                       #dma-cells =3D <2>;
>> +
>> +                       ti,tptcs =3D <&edma_tptc0 7>, <&edma_tptc1 5=
>,
>> +                                  <&edma_tptc2 0>;
>> +
>> +                       ti,edma-memcpy-channels =3D /bits/ 16 <20 21=
>;
>> +               };
>> +
>> +               edma_tptc0: tptc@49800000 {
>> +                       compatible =3D "ti,edma3-tptc";
>> +                       ti,hwmods =3D "tptc0";
>> +                       reg =3D   <0x49800000 0x100000>;
>> +                       interrupts =3D <112>;
>> +                       interrupt-names =3D "edma3_tcerrint";
>> +               };
>> +
>> +               edma_tptc1: tptc@49900000 {
>> +                       compatible =3D "ti,edma3-tptc";
>> +                       ti,hwmods =3D "tptc1";
>> +                       reg =3D   <0x49900000 0x100000>;
>> +                       interrupts =3D <113>;
>> +                       interrupt-names =3D "edma3_tcerrint";
>> +               };
>> +
>> +               edma_tptc2: tptc@49a00000 {
>> +                       compatible =3D "ti,edma3-tptc";
>> +                       ti,hwmods =3D "tptc2";
>> +                       reg =3D   <0x49a00000 0x100000>;
>> +                       interrupts =3D <114>;
>> +                       interrupt-names =3D "edma3_tcerrint";
>> +               };
>> +
>> +               edma_xbar: dma-router@44e10f90 {
>> +                       compatible =3D "ti,am335x-edma-crossbar";
>> +                       reg =3D <0x44e10f90 0x40>;
>> +
>> +                       #dma-cells =3D <3>;
>> +                       dma-requests =3D <32>;
>> +
>> +                       dma-masters =3D <&edma>;
>>                 };
>>
>>                 gpio0: gpio@44e07000 {
>> @@ -233,7 +275,7 @@
>>                         reg =3D <0x44e09000 0x2000>;
>>                         interrupts =3D <72>;
>>                         status =3D "disabled";
>> -                       dmas =3D <&edma 26>, <&edma 27>;
>> +                       dmas =3D <&edma 26 0>, <&edma 27 0>;
>>                         dma-names =3D "tx", "rx";
>>                 };
>>
>> @@ -244,7 +286,7 @@
>>                         reg =3D <0x48022000 0x2000>;
>>                         interrupts =3D <73>;
>>                         status =3D "disabled";
>> -                       dmas =3D <&edma 28>, <&edma 29>;
>> +                       dmas =3D <&edma 28 0>, <&edma 29 0>;
>>                         dma-names =3D "tx", "rx";
>>                 };
>>
>> @@ -255,7 +297,7 @@
>>                         reg =3D <0x48024000 0x2000>;
>>                         interrupts =3D <74>;
>>                         status =3D "disabled";
>> -                       dmas =3D <&edma 30>, <&edma 31>;
>> +                       dmas =3D <&edma 30 0>, <&edma 31 0>;
>>                         dma-names =3D "tx", "rx";
>>                 };
>>
>> @@ -322,8 +364,8 @@
>>                         ti,dual-volt;
>>                         ti,needs-special-reset;
>>                         ti,needs-special-hs-handling;
>> -                       dmas =3D <&edma 24
>> -                               &edma 25>;
>> +                       dmas =3D <&edma_xbar 24 0 0
>> +                               &edma_xbar 25 0 0>;
>>                         dma-names =3D "tx", "rx";
>>                         interrupts =3D <64>;
>>                         interrupt-parent =3D <&intc>;
>> @@ -335,8 +377,8 @@
>>                         compatible =3D "ti,omap4-hsmmc";
>>                         ti,hwmods =3D "mmc2";
>>                         ti,needs-special-reset;
>> -                       dmas =3D <&edma 2
>> -                               &edma 3>;
>> +                       dmas =3D <&edma 2 0
>> +                               &edma 3 0>;
>>                         dma-names =3D "tx", "rx";
>>                         interrupts =3D <28>;
>>                         interrupt-parent =3D <&intc>;
>> @@ -474,10 +516,10 @@
>>                         interrupts =3D <65>;
>>                         ti,spi-num-cs =3D <2>;
>>                         ti,hwmods =3D "spi0";
>> -                       dmas =3D <&edma 16
>> -                               &edma 17
>> -                               &edma 18
>> -                               &edma 19>;
>> +                       dmas =3D <&edma 16 0
>> +                               &edma 17 0
>> +                               &edma 18 0
>> +                               &edma 19 0>;
>>                         dma-names =3D "tx0", "rx0", "tx1", "rx1";
>>                         status =3D "disabled";
>>                 };
>> @@ -490,10 +532,10 @@
>>                         interrupts =3D <125>;
>>                         ti,spi-num-cs =3D <2>;
>>                         ti,hwmods =3D "spi1";
>> -                       dmas =3D <&edma 42
>> -                               &edma 43
>> -                               &edma 44
>> -                               &edma 45>;
>> +                       dmas =3D <&edma 42 0
>> +                               &edma 43 0
>> +                               &edma 44 0
>> +                               &edma 45 0>;
>>                         dma-names =3D "tx0", "rx0", "tx1", "rx1";
>>                         status =3D "disabled";
>>                 };
>> @@ -831,7 +873,7 @@
>>                         ti,hwmods =3D "sham";
>>                         reg =3D <0x53100000 0x200>;
>>                         interrupts =3D <109>;
>> -                       dmas =3D <&edma 36>;
>> +                       dmas =3D <&edma 36 0>;
>>                         dma-names =3D "rx";
>>                 };
>>
>> @@ -840,8 +882,8 @@
>>                         ti,hwmods =3D "aes";
>>                         reg =3D <0x53500000 0xa0>;
>>                         interrupts =3D <103>;
>> -                       dmas =3D <&edma 6>,
>> -                              <&edma 5>;
>> +                       dmas =3D <&edma 6 0>,
>> +                              <&edma 5 0>;
>>                         dma-names =3D "tx", "rx";
>>                 };
>>
>> @@ -854,8 +896,8 @@
>>                         interrupts =3D <80>, <81>;
>>                         interrupt-names =3D "tx", "rx";
>>                         status =3D "disabled";
>> -                       dmas =3D <&edma 8>,
>> -                               <&edma 9>;
>> +                       dmas =3D <&edma 8 2>,
>> +                               <&edma 9 2>;
>>                         dma-names =3D "tx", "rx";
>>                 };
>>
>> @@ -868,8 +910,8 @@
>>                         interrupts =3D <82>, <83>;
>>                         interrupt-names =3D "tx", "rx";
>>                         status =3D "disabled";
>> -                       dmas =3D <&edma 10>,
>> -                               <&edma 11>;
>> +                       dmas =3D <&edma 10 2>,
>> +                               <&edma 11 2>;
>>                         dma-names =3D "tx", "rx";
>>                 };
>>
>> --
>> 2.6.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/


--=20
P=C3=A9ter
