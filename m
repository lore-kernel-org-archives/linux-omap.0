From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] mfd: tps65217: remove duplicated interrupt resources.
Date: Tue, 13 Jun 2017 18:05:32 -0500
Message-ID: <d223e106-3718-e34e-da3f-d664985f7b59@ti.com>
References: <20170612212412.22719-1-enric.balletbo@collabora.com>
 <20170612212412.22719-3-enric.balletbo@collabora.com>
 <bddc09a1-53d7-e7ed-5c04-a9ecf5310dde@ti.com>
 <CAFqH_51wYc-xXU9fAF=1KNJ4wC69oZToMXjVP==yCgrMVfwn+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFqH_51wYc-xXU9fAF=1KNJ4wC69oZToMXjVP==yCgrMVfwn+g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 06/13/2017 03:18 AM, Enric Balletbo Serra wrote:
> Hi Grygorii,
> 
> 2017-06-13 0:41 GMT+02:00 Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>:
>>
>>
>> On 06/12/2017 04:24 PM, Enric Balletbo i Serra wrote:
>>> I don't think it makes sense to have the interrupt resources for charger
>>> and power button in two different places, the driver and the DT binding.
>>> That's confusing so remove the ones from the mfd driver in favour of
>>> having the interrupt resources only described in the DT. Having the
>>> resources in DT may help if there is or will be a similar pmic with
>>> different resource allocation.
>>
>> Wouldn't this break DT compatibility? Old DTs do not contain IRQ resources
>> and so they work only because of IRQ definitions in code.
>>
> 
> I don't think so, the DT binding [1] and [2] says that the interrupts
> proprieties are required, so the bindings that that doesn't have these
> proprieties are wrong. Also I suspect that the binding that doesn't
> define the interrupts expect the hw block disabled as the status =
> "disabled" was defined, so I don't think was his intention have i.e
> the charger active.
> 
> [1] https://www.kernel.org/doc/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> [2] https://www.kernel.org/doc/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt

Ok. fair enough.

Anyway, personally I would prefer to remove irqs from DT, but as both 
points are valid - its up to maintainers to decide.

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
