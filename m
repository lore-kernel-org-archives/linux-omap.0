From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep0020: Add SMSC911x LAN chip support
Date: Mon, 27 May 2013 10:41:40 +0200
Message-ID: <51A31C44.4030600@ti.com>
References: <1366216329-10677-1-git-send-email-javier.martinez@collabora.co.uk> <CAAwP0s2M7WOva27-viWjZq9CrjsZStn6cJZ8KhJVWTxHkKdP7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42385 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757124Ab3E0Ilu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 May 2013 04:41:50 -0400
In-Reply-To: <CAAwP0s2M7WOva27-viWjZq9CrjsZStn6cJZ8KhJVWTxHkKdP7A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Jon Hunter <jgchunter@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-omap <linux-omap@vger.kernel.org>

+ new Jon's email address.

Hi Javier,

Sorry for the delay.

On 05/09/2013 12:37 AM, Javier Martinez Canillas wrote:
> On Wed, Apr 17, 2013 at 6:32 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> The IGEPv2 board has an SMSC LAN9221i ethernet chip connected to
>> the OMAP3 processor though the General-Purpose Memory Controller.
>>
>> This patch adds a device node for the ethernet chip as a GPMC child
>> and all its dependencies (regulators, GPIO and pin muxs).
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  arch/arm/boot/dts/omap3-igep.dtsi    |    6 ++++
>>  arch/arm/boot/dts/omap3-igep0020.dts |   53 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 59 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
>> index f8fe3b7..d5cd504 100644
>> --- a/arch/arm/boot/dts/omap3-igep.dtsi
>> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
>> @@ -62,6 +62,12 @@
>>                         0x126 0x0100    /* sdmmc1_dat7.sdmmc1_dat7 INPUT | MODE 0 */
>>                 >;
>>         };
>> +
>> +       smsc911x_pins: pinmux_smsc911x_pins {
>> +               pinctrl-single,pins = <
>> +                        0x1a2 0x0104    /* mcspi1_cs2.gpio_176 INPUT | MODE4 */
>> +               >;
>> +       };
>>  };
>>
>>  &i2c1 {
>> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
>> index e2b9849..4bac32e 100644
>> --- a/arch/arm/boot/dts/omap3-igep0020.dts
>> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
>> @@ -40,6 +40,18 @@
>>                         gpios = <&twl_gpio 19 1>;
>>                 };
>>         };
>> +
>> +       vddvario: regulator-vddvario {
>> +                 compatible = "regulator-fixed";
>> +                 regulator-name = "vddvario";
>> +                 regulator-always-on;
>> +       };
>> +
>> +       vdd33a: regulator-vdd33a {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vdd33a";
>> +               regulator-always-on;
>> +       };
>>  };
>>
>>  &i2c3 {
>> @@ -54,3 +66,44 @@
>>                 reg = <0x50>;
>>         };
>>  };
>> +
>> +&gpmc {
>> +       ranges = <5 0 0x2c000000 0x1000000>;
>> +       ethernet@5,0 {
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&smsc911x_pins>;
>> +               compatible = "smsc,lan9221", "smsc,lan9115";
>> +               reg = <5 0 0xff>;
>> +               bank-width = <2>;
>> +
>> +               gpmc,mux-add-data;
>> +               gpmc,cs-on-ns = <0>;
>> +               gpmc,cs-rd-off-ns = <186>;
>> +               gpmc,cs-wr-off-ns = <186>;
>> +               gpmc,adv-on-ns = <12>;
>> +               gpmc,adv-rd-off-ns = <48>;
>> +               gpmc,adv-wr-off-ns = <48>;
>> +               gpmc,oe-on-ns = <54>;
>> +               gpmc,oe-off-ns = <168>;
>> +               gpmc,we-on-ns = <54>;
>> +               gpmc,we-off-ns = <168>;
>> +               gpmc,rd-cycle-ns = <186>;
>> +               gpmc,wr-cycle-ns = <186>;
>> +               gpmc,access-ns = <114>;
>> +               gpmc,page-burst-access-ns = <6>;
>> +               gpmc,bus-turnaround-ns = <12>;
>> +               gpmc,cycle2cycle-delay-ns = <18>;
>> +               gpmc,wr-data-mux-bus-ns = <90>;
>> +               gpmc,wr-access-ns = <186>;
>> +               gpmc,cycle2cycle-samecsen;
>> +               gpmc,cycle2cycle-diffcsen;
>> +
>> +               interrupt-parent = <&gpio6>;
>> +               interrupts = <16 8>;
>> +               vmmc-supply = <&vddvario>;
>> +               vmmc_aux-supply = <&vdd33a>;
>> +               reg-io-width = <4>;
>> +
>> +               smsc,save-mac-address;
>> +       };
>> +};
>> --
>> 1.7.7.6
>>
>> --
> 
> Hi Benoit,
> 
> Any comments on this patch?

Nope, it looks good to me. I've just applied it.

Thanks,
Benoit


