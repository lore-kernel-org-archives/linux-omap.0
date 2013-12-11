From: Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: need help to configure IRQ on gpio 139 pandaboard using device
 tree
Date: Wed, 11 Dec 2013 17:25:42 +0100
Message-ID: <52A89206.8080605@st.com>
References: <52A8768C.5070103@st.com>
 <CAGo_u6p9D_rkzte_nxy9EsNyW1ouDPt2eP4zhrYBRjmd8+VHUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:46186 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751245Ab3LKQZr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Dec 2013 11:25:47 -0500
In-Reply-To: <CAGo_u6p9D_rkzte_nxy9EsNyW1ouDPt2eP4zhrYBRjmd8+VHUA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "menon.nishanth@gmail.com" <menon.nishanth@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Nishant,

Thank you very much for your suggestions! Now I understand how it 
works...(I hope) :D

BUT, now I've checked the client->irq in an i2c driver and the value is 
still 0...

What I have to check?
Thanks,
Denis



On 12/11/2013 04:39 PM, menon.nishanth@gmail.com wrote:
> On Wed, Dec 11, 2013 at 8:28 AM, Denis CIOCCA <denis.ciocca@st.com> wrote:
>> Hi everybody,
>>
>> I'm trying to configure an IRQ on pandaboard using device tree but I'm
>> not able to understand how I can do it.
>> I want to configure the the gpio_139 pin and without device tree my
>> command was:
>>
>> OMAP4_MUX(MCSPI1_SIMO, OMAP_MUX_MODE3 | OMAP_PIN_INPUT_PULLUP),
>>
>> I need to associate it to a i2c device, declared in this way:
> here is how you'd figure it out in dt world ;) - it might be a little
> simpler or harder depending on which end of the development world one
> is from... (gmail might be screwing up my formatting a little.. so
> apologies before hand.
>
> http://pastebin.mozilla.org/3755622 is a copy if you need one.. anyways,
> step 1: from trm, you get to know that the pin is part of "core"
> "SYSCTRL_PADCONF_CORE" as it states for register instance in the trm.
> step 2: you compute the offset
> step 3: you define the pinctrl dt node
> step 4: you'd provide the device using it reference - rather trivial ;)
>
> diff --git a/arch/arm/boot/dts/omap4-panda-es.dts
> b/arch/arm/boot/dts/omap4-panda-es.dts
> index 56c4354..8f8d36c 100644
> --- a/arch/arm/boot/dts/omap4-panda-es.dts
> +++ b/arch/arm/boot/dts/omap4-panda-es.dts
> @@ -41,6 +41,25 @@
>    0xb6 (PIN_OUTPUT | MUX_MODE3) /* gpio_110 */
>    >;
>    };
> +
> + lsm303d_pins: lsm303d_pins {
> + pinctrl-single,pins = <
> + /*
> + * Example for 4460 device:
> + * from arch/arm/boot/dts/omap4.dtsi:
> + * omap4_pmx_core: reg = <0x4a100040
> + * the base address -->     ^^
> + *
> + * Now, the offset is computed as following:
> + * Download TRM: http://www.ti.com/lit/ug/swpu235aa/swpu235aa.pdf
> + * Searching in TRM for MCSPI1_SIMO (page 4145), you see:
> + * 32 bit register 0x4a100134, it is on the higher 16 bits
> + *  0x4a100134(SOMI) + 2 (SIMO) = 0x4a100136
> + * offset hence is = 0x4a100136 - 0x4a100040 = 0xF6
> + */
> + 0xF6 (PIN_INPUT_PULLUP | MUX_MODE3) /* mcspi1_somi.gpio_139 */
> + >;
> + };
>   };
>
>   &led_wkgpio_pins {
> @@ -62,3 +81,16 @@
>    gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
>    };
>   };
> +&i2c4 {
> + pinctrl-names = "default";
> + pinctrl-0 = <&i2c4_pins>;
> +
> + clock-frequency = <400000>;
> +
> + lsm303d@03 {
> + pinctrl-names = "default";
> + pinctrl-0 = <&lsm303d_pins>;
> + compatible = "st,lsm303d";
> + reg = <0x03>;
> + };
> +};
