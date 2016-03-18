From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 08/15] genirq: Add runtime power management support for
 IRQ chips
Date: Fri, 18 Mar 2016 19:52:10 +0200
Message-ID: <56EC404A.9060001@ti.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-9-git-send-email-jonathanh@nvidia.com>
 <56EBE244.6070400@ti.com> <56EBF447.8070808@nvidia.com>
 <56EC0F7D.8050106@ti.com> <56EC1362.2000005@nvidia.com>
 <56EC1719.5020408@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56EC1719.5020408-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/18/2016 04:56 PM, Jon Hunter wrote:
> 
> On 18/03/16 14:40, Jon Hunter wrote:
>> On 18/03/16 14:23, Grygorii Strashko wrote:
>>> On 03/18/2016 02:27 PM, Jon Hunter wrote:
>>>>
>>>> On 18/03/16 11:11, Grygorii Strashko wrote:
> 
> [snip]
> 
>>> oh :( That will require updating of all drivers (and if it will be taken into account that
>>> wakeup can be configured from sysfs + devm_ - it will be painful).
>>
>> Will it? I know that there are a few gpio chips that have some hacked
>> ways to get around the PM issue, but I wonder how many drivers this
>> really impacts. What sysfs entries are you referring too?

echo enabled > /sys/devices/platform/44000000.ocp/48020000.serial/tty/ttyS2/power/wakeup

> 
> Thinking about this some more, yes I guess it would impact all drivers
> that use a gpio but don't use it for a wake-up. I could see that could
> be a few drivers indeed.

yep. I've just tested it
- gpio was requested through sysfs and configured as IRQ
- do suspend

the same is if GPIO is requested as IRQ only and not configured as wakeup source 

[  319.669760] PM: late suspend of devices complete after 0.213 msecs
[  319.671195] irq 191 has no wakeup set and has not been freed!
[  319.673453] PM: noirq suspend of devices complete after 2.258 msecs

this is very minimal configuration - the regular one is at ~30-50 devices
most of them will use IRQ and only ~10% are used as wakeup sources.


> 
>>>> but it would avoid every irqchip having to
>>>> handle this themselves and having a custom handler.
>>>
>>> irqchip like TI OMAP GPIO will need custom handling any way even if it's not expected
>>> to be Powered off during Suspend or deep CPUIdle states, simply because its state
>>> in suspend is unknown - PM state managed automatically (and depends on many factors)
>>> and wakeup can be handled by special HW in case if GPIO bank was really switched off.
>>>
>>>>> I propose do not touch common/generic suspend code now. Any common code can be always
>>>>> refactored later once there will be real drivers updated to use irqchip RPM
>>>>> and which will support Suspend.
>>>>
>>>> If this is strongly opposed, I would concede to making this a pr_debug()
>>>> as I think it could be useful.
>>>
>>> Probably yes, because most of the drivers now and IRQ PM core are not ready
>>> for this approach.
>>
>> May be this calls for a new flag to not WARN if non-wakeup IRQs are not
>> freed when entering suspend.
> 
> Flag or pr_debug()?
> 

Honestly, I don't know how to proceed - minimum is pr_debug.
My personal opinion is still the same - don't touch suspend core code now, within this series.


-- 
regards,
-grygorii
