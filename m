From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 08/15] genirq: Add runtime power management support for
 IRQ chips
Date: Mon, 21 Mar 2016 10:09:12 +0000
Message-ID: <56EFC848.6030301@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-9-git-send-email-jonathanh@nvidia.com>
 <56EBE244.6070400@ti.com> <56EBF447.8070808@nvidia.com>
 <56EC0F7D.8050106@ti.com> <56EC1362.2000005@nvidia.com>
 <56EC1719.5020408@nvidia.com> <56EC404A.9060001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56EC404A.9060001@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 18/03/16 17:52, Grygorii Strashko wrote:
> On 03/18/2016 04:56 PM, Jon Hunter wrote:
>>
>> On 18/03/16 14:40, Jon Hunter wrote:
>>> On 18/03/16 14:23, Grygorii Strashko wrote:
>>>> On 03/18/2016 02:27 PM, Jon Hunter wrote:
>>>>>
>>>>> On 18/03/16 11:11, Grygorii Strashko wrote:
>>
>> [snip]
>>
>>>> oh :( That will require updating of all drivers (and if it will be taken into account that
>>>> wakeup can be configured from sysfs + devm_ - it will be painful).
>>>
>>> Will it? I know that there are a few gpio chips that have some hacked
>>> ways to get around the PM issue, but I wonder how many drivers this
>>> really impacts. What sysfs entries are you referring too?
> 
> echo enabled > /sys/devices/platform/44000000.ocp/48020000.serial/tty/ttyS2/power/wakeup
> 
>>
>> Thinking about this some more, yes I guess it would impact all drivers
>> that use a gpio but don't use it for a wake-up. I could see that could
>> be a few drivers indeed.
> 
> yep. I've just tested it
> - gpio was requested through sysfs and configured as IRQ
> - do suspend
> 
> the same is if GPIO is requested as IRQ only and not configured as wakeup source 
> 
> [  319.669760] PM: late suspend of devices complete after 0.213 msecs
> [  319.671195] irq 191 has no wakeup set and has not been freed!
> [  319.673453] PM: noirq suspend of devices complete after 2.258 msecs
> 
> this is very minimal configuration - the regular one is at ~30-50 devices
> most of them will use IRQ and only ~10% are used as wakeup sources.

Then it is working as intended :-)

However, if this is too verbose for some irqchips, then as I mentioned
we can have a flag to avoid these messages.

Cheers
Jon
