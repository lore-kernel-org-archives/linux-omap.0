From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/5] drivers: gpio: Add support for multiple IPs
Date: Mon, 31 Oct 2016 09:58:42 -0500
Message-ID: <94b12df1-d982-aff7-b86e-453c85db9655@ti.com>
References: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
 <1476855239-32730-3-git-send-email-j-keerthy@ti.com>
 <CACRpkdbsgM-yiWpiA5G35jQR8v3FO=Me+4rhe6TzE0qsWOJ8Ew@mail.gmail.com>
 <c5c95d86-2c89-3819-725c-ee0b86c37ec0@ti.com>
 <98447580-cbc4-152e-f2cb-7c4756545479@ti.com>
 <c047fb27-a8bb-c10d-2b16-a3e6bf45d88f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c047fb27-a8bb-c10d-2b16-a3e6bf45d88f-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 10/27/2016 03:07 AM, Keerthy wrote:
> 
> 
> On Thursday 27 October 2016 01:23 PM, Roger Quadros wrote:
>> Keerthy,
>>
>> On 27/10/16 06:42, Keerthy wrote:
>>>
>>>
>>> On Sunday 23 October 2016 04:02 PM, Linus Walleij wrote:
>>>> On Wed, Oct 19, 2016 at 7:33 AM, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> wrote:
>>>>
>>>>> From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
>>>>>
>>>>> Update GPIO driver to support Multiple GPIO IPs.
>>>>>
>>>>> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
>>>>> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>>>>
>>>> This commit message is not at all describing what the patch is doing.
>>>>
>>>> What it does is bumping the GPIO pin offset in the Linux global
>>>> GPIO number space with 32 for each new controller.
>>>>
>>>>> +       static int bank_base;
>>>>>
>>>>>         pdata = davinci_gpio_get_pdata(pdev);
>>>>>         if (!pdata) {
>>>>> @@ -226,7 +227,8 @@ static int davinci_gpio_probe(struct
>>>>> platform_device *pdev)
>>>>>                 chips[i].chip.direction_output =
>>>>> davinci_direction_out;
>>>>>                 chips[i].chip.set = davinci_gpio_set;
>>>>>
>>>>> -               chips[i].chip.base = base;
>>>>> +               chips[i].chip.base = bank_base;
>>>>> +               bank_base += 32;
>>>>
>>>> Why can you not rewrite the driver to pass -1 as base and
>>>> get a dynamic allocation of GPIO numbers instead? Then
>>>> you won't have this hairy problem.
>>>
>>> Ok i will try that.
>>>
>>> In case of k2g. There are 2 big GPIO modules GPIO0 and GPIO1.
>>> GPIO0 comprises of 144 GPIOs
>>> and GPIO1 has about 68 GPIOs. Wanted feedback from you on how this is
>>> being modeled.
>>>
>>> I am creating a controller for every 32 GPIOs under the big module
>>> each containing a gpio_chip. Each 32 GPIOs chip has 2 banks of 16
>>> GPIOs each.
>>> Each 16 GPIO bank has an interrupt.
>>>
>>> Is this modeling fine or do you think creating one chip with 144 pins
>>> and another with 68 pins is a better way?
>>
>> If GPIO0 has 144 GPIOs, why don't we model it as a gpiochip with 144
>> GPIOs?
>> What is the benefit of partitioning it into gpiochips of 32 GPIOs each?
> 
> 144 GPIOs where in 16 GPIOs form a bank. So about 9 banks with one
> interrupt each. So split it into gpiochips with 32 GPIOs each handling 2
> Interrupts.
> 
> Grygorii,
> 
> Any strong reason that you recollect of so as to why this modeling was
> chosen?
> 

I think, there was a restriction on max number of GPIOs supported by one gpiochip
(32) at time when this driver was introduced an updated for Keystone.
But, seems, this might work now since GPIO core was transformed to use gpio descriptors.

regards,
-grygorii

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
