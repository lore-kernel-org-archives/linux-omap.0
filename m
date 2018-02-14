From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v7 3/9] arm: omap: Move dmtimer.h out of plat-omap
Date: Wed, 14 Feb 2018 09:41:23 +0530
Message-ID: <2f94e782-7925-e42d-d0e1-dbad92f69a83@ti.com>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-4-git-send-email-j-keerthy@ti.com>
 <1c9f5c72-f589-d7c7-399f-ef55ecb828a0@ti.com>
 <20180213150900.GD6364@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20180213150900.GD6364@atomide.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>, "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>, "narmstrong@baylibre.com" <narmstrong@baylibre.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "ladis@linux-mips.org" <ladis@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "sebastian.reichel@collabora.co.uk" <sebastian.reichel@collabora.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, "Strashko, Grygorii" <grygorii.strashko@ti.c>
List-Id: linux-omap@vger.kernel.org



On Tuesday 13 February 2018 08:39 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [180213 02:07]:
>> On 01/09/2018 12:23 AM, J, KEERTHY wrote:
>>> The header file is currently under plat-omap directory
>>> under arch/omap. Move this out to an accessible place.
>>> @@ -18,7 +18,7 @@
>>>   #include <linux/platform_data/hsmmc-omap.h>
>>>   #include <linux/platform_data/spi-omap2-mcspi.h>
>>>   #include <linux/omap-dma.h>
>>> -#include <plat/dmtimer.h>
>>> +#include <clocksource/dmtimer.h>
>>
>> These headers are actually not needed in the first-place since we no
>> longer create any non-DT timer devices. I have submitted a series to
>> cleanup the presence of this header file, as part of a larger hwmod data
>> cleanup series.
> 
> OK great. Keerthy, care to take a look? Seems like it
> simplifies things a bit.

Sure Tony. I will look into this.

> 
> Regards,
> 
> Tony
> 
