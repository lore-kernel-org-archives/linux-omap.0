From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 1/2] ARM: dts: twl: Add GPADC data to device tree
Date: Fri, 19 Jul 2013 22:18:56 +0400
Message-ID: <51E98310.7020103@cogentembedded.com>
References: <1374226039-16943-1-git-send-email-oleksandr.kozaruk@ti.com> <1374226039-16943-2-git-send-email-oleksandr.kozaruk@ti.com> <51E94F97.40002@cogentembedded.com> <51E95DEB.7010702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51E95DEB.7010702-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, milo.kim-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 07/19/2013 07:40 PM, Grygorii Strashko wrote:

>>> GPADC is the general purpose ADC present on twl6030.
>>> The dt data is interrupt used to trigger end of ADC
>>> conversion.

>>> Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
>>> ---
>>>   arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
>>>   1 file changed, 6 insertions(+)

>>> diff --git a/arch/arm/boot/dts/twl6030.dtsi
>>> b/arch/arm/boot/dts/twl6030.dtsi
>>> index 2e3bd31..d7d4c28 100644
>>> --- a/arch/arm/boot/dts/twl6030.dtsi
>>> +++ b/arch/arm/boot/dts/twl6030.dtsi
>>> @@ -103,4 +103,10 @@
>>>           compatible = "ti,twl6030-pwmled";
>>>           #pwm-cells = <2>;
>>>       };
>>> +
>>> +    adc: gpadc {

>>     Read my lips: the node should be called just "adc", not "gpadc".
>        ^^^^^^^^^^^^ Are you sure?

    I didn't know how to express my disappointment from Oleksandr's inability 
to understand what I wanted to convey to him from 2 attempts... first, he 
changed the label instead of the node name, then he only dropped "twl6030_" 
prefix from the name. I should probably have been even more specific before.

> Why? The name was selected according to the documentation on device "General
> purpose analog-to-digital converter (GPADC)".

    Sigh, we simply don't care whether this ADC is general-purpose or not.
The main thing it is ADC.

> PS. Following your logic - "GPIO" need to renamed to "IO" everywhere ;P

    GPIO is well known and established abbreviation, contrasted to GPADC.
Moreover, ePAPR spec lists "gpio" as a generic node name.

WBR, Sergei
