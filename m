From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 4/8] arm: OMAP: Move dmtimer driver out of plat-omap to
 drivers under clocksource
Date: Fri, 8 Dec 2017 18:50:32 +0100
Message-ID: <a2f06a16-2468-6b09-171a-ad96e39af3eb@linaro.org>
References: <1512105397-2544-1-git-send-email-j-keerthy@ti.com>
 <1512105397-2544-5-git-send-email-j-keerthy@ti.com>
 <e71f4c7b-e5c7-6305-dc1c-274da6fbf07d@linaro.org>
 <20171208172031.GA4146@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20171208172031.GA4146@lenoch>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Keerthy <j-keerthy@ti.com>, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, t-kristo@ti.com, linux@armlinux.org.uk, grygorii.strashko@ti.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/12/2017 18:20, Ladislav Michl wrote:
> Daniel,
> 
> On Thu, Dec 07, 2017 at 11:54:27AM +0100, Daniel Lezcano wrote:
>> On 01/12/2017 06:16, Keerthy wrote:
>>> Move the dmtimer driver out of plat-omap to clocksource.
>>> So that non-omap devices also could use this.
>>>
>>> No Code changes done to the driver file.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>> ---
>>>
>>> Changes in v3:
>>>
>>>   * Added Sebastian's Reviewed-by.
>>>
>>> Changes in v2:
>>>
>>>   * No code changes in this v2 version. Only enhanced patch
>>>     statistics for renames.
>>>
>>>  arch/arm/plat-omap/Kconfig                            | 6 ------
>>>  arch/arm/plat-omap/Makefile                           | 1 -
>>>  drivers/clocksource/Kconfig                           | 6 ++++++
>>>  drivers/clocksource/Makefile                          | 1 +
>>>  {arch/arm/plat-omap => drivers/clocksource}/dmtimer.c | 0
>>>  5 files changed, 7 insertions(+), 7 deletions(-)
>>>  rename {arch/arm/plat-omap => drivers/clocksource}/dmtimer.c (100%)
>>
>> Take the opportunity to rename it timer-dm.c
> 
> seems the drivers/clocksource subdirectory contains what its name state.

Yes, clocksource, clockevent.

> However OMAP dual mode timers have also event capture capability, which
> I'd like to use to measure pulse/space width and pass measured values
> to IR protocol decoders.
> Do you have any idea how to split code, so that event capture capability
> could be used by other drivers?
Not 100% sure but could be drivers/pwm, using the capture API.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
