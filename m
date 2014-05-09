From: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am335x-bone-common: Add i2c2 definition
Date: Fri, 9 May 2014 09:24:46 -0700
Message-ID: <CAKzfze-ijg1GTJzNvhEVN5ULm9q0gQhScLpwC-CLNa90Whf1sg@mail.gmail.com>
References: <1399614983-552-1-git-send-email-mranostay@gmail.com>
	<536CD0D1.4080903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <536CD0D1.4080903-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 9, 2014 at 5:57 AM, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> wrote:
> On Fri 09 May 2014 12:56:23 AM CDT, Matt Ranostay wrote:
>> Add missing i2c2 bus define to access various cape and
>> prototype/breakout board devices.
>>
>> Signed-off-by: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/am335x-bone-common.dtsi | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
>> index 2e7d932..2aedfee 100644
>> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
>> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
>> @@ -84,6 +84,13 @@
>>               >;
>>       };
>>
>> +     i2c2_pins: pinmux_i2c2_pins {
>> +             pinctrl-single,pins = <
>> +                     0x178 (PIN_INPUT_PULLUP | MUX_MODE3)    /* i2c2_sda.uart1_ctsn */
>> +                     0x17c (PIN_INPUT_PULLUP | MUX_MODE3)    /* i2c2_scl.uart1_rtsn */
>
> I dont understand the comment -> i2c2_sda is being muxed to uart1_cstsn?
>
Good catch I mixed up the ordering of the comment.

>> +             >;
>> +     };
>> +
>>       uart0_pins: pinmux_uart0_pins {
>>               pinctrl-single,pins = <
>>                       0x170 (PIN_INPUT_PULLUP | MUX_MODE0)    /* uart0_rxd.uart0_rxd */
>> @@ -222,6 +229,15 @@
>>
>>  };
>>
>> +
>> +&i2c2 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&i2c2_pins>;
>> +
>> +     status = "okay";
>> +     clock-frequency = <400000>;
>
> How did we decide on 400KHz -> do all all i2c2 devices on ALL capes
> work in full speed? OR should we consider a conservative 100KHz?
>

Probably a better plan.
Will submit v2 this weekend.

>> +};
>> +
>>  /include/ "tps65217.dtsi"
>>
>>  &tps {
>
>
> --
> Regards,
> Nishanth Menon
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
