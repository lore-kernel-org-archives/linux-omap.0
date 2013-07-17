From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v5 1/2] ARM: dts: twl: Add GPADC data to device tree
Date: Wed, 17 Jul 2013 16:48:34 +0200
Message-ID: <51E6AEC2.3050308@metafoo.de>
References: <1374059564-6872-1-git-send-email-oleksandr.kozaruk@ti.com> <1374059564-6872-2-git-send-email-oleksandr.kozaruk@ti.com> <51E6AB54.103@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51E6AB54.103-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, milo.kim-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/17/2013 04:33 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 17-07-2013 15:12, Oleksandr Kozaruk wrote:
> 
>> GPADC is the general purpose ADC present on twl6030.
>> The dt data is interrupt used to trigger end of ADC
>> conversion.
> 
>> Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
>> index 2e3bd31..322aa8e 100644
>> --- a/arch/arm/boot/dts/twl6030.dtsi
>> +++ b/arch/arm/boot/dts/twl6030.dtsi
>> @@ -103,4 +103,10 @@
>>           compatible = "ti,twl6030-pwmled";
>>           #pwm-cells = <2>;
>>       };
>> +
>> +    adc: twl6030_gpadc {
> 
>    I was talking about the device name, not label. The "twl6030_gpadc" part.

The compatible property should also be: 'twl6030-gpadc' instead of
'twl6030_gpadc' and you need to add documentation for it.

- Lars
