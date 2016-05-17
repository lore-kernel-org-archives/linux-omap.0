From: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: igep0020: Add SD card write-protect pin.
Date: Tue, 17 May 2016 10:06:22 +0200
Message-ID: <CAFqH_535Zd8etbAjrSq_fj73p9cJFzqOqbcbH3UcnpfjNy7efw@mail.gmail.com>
References: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com>
	<1462568554-7868-2-git-send-email-enric.balletbo@collabora.com>
	<20160513123718.GA2841@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160513123718.GA2841-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Ladislav,

2016-05-13 14:37 GMT+02:00 Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>:
> Hi Enric!
>
> On Fri, May 06, 2016 at 11:02:34PM +0200, Enric Balletbo i Serra wrote:
>> A host device that supports write protection should refuse to write to
>> an SD card that is designated read-only when write-protect is set. This
>> is an optional feature of the SD specification.
>
> Does it ever work on any IGEPv2? I have similar patch in my repo and there
> is no difference when enabling write protection on SD card. Also schemantics
> shows GPIO29 constantly pulled up with a resistor. Is there any board
> revision with working WP? I'm just curious as patch is of course correct.
>

Note that the microSD formats do not support a write protection
switch, a host device that supports write protection should refuse to
write to an SD card that is designated read-only in this way, which is
an optional feature of the SD specification. As far as I know there is
only a use case for the IGEPv2, the TP close to the SD card can be
used as a write-protection switch, this is not an usual use case and
of course, this needs some wiring, but it's a feature used by someone.

> Best regards,
>         ladis
>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/omap3-igep0020-common.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
>> index d6f839c..b697106 100644
>> --- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
>> +++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
>> @@ -194,6 +194,12 @@
>>                       OMAP3630_CORE2_IOPAD(0x25f8, PIN_OUTPUT | MUX_MODE4) /* etk_d14.gpio_28 */
>>               >;
>>       };
>> +
>> +     mmc1_wp_pins: pinmux_mmc1_cd_pins {
>> +             pinctrl-single,pins = <
>> +                     OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT | MUX_MODE4)   /* etk_d15.gpio_29 */
>> +             >;
>> +     };
>>  };
>>
>>  &i2c3 {
>> @@ -250,3 +256,8 @@
>>               };
>>       };
>>  };
>> +
>> +&mmc1 {
>> +     pinctrl-0 = <&mmc1_pins &mmc1_wp_pins>;
>> +     wp-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>; /* gpio_29 */
>> +};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
