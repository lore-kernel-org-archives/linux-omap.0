From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v6 00/10] omap: dmtimer: Move driver out of plat-omap
Date: Sun, 7 Jan 2018 21:29:03 +0530
Message-ID: <02e1ff29-aa50-0e04-e5ab-fa0b5fc80206@ti.com>
References: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: ladis@linux-mips.org, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On 1/2/2018 3:39 PM, Keerthy wrote:
> The series moves dmtimer out of plat-omap to drivers/clocksource.
> The series also does a bunch of changes to pwm-omap-dmtimer code
> to adapt to the driver migration and clean up plat specific
> pdata-quirks and use the dmtimer platform data.
> 
> Boot tested on DRA7-EVM and AM437X-GP-EVM.
> Compile tested omap1_defconfig.
> 
> This is based on top of linux-next branch.
> 
> This is tested on on IGEPv2 (OMAP3430 based) by Ladis.

Daniel/Theirry,

Let me know if you have any comments on this migration series.
Patch 10/10 from Ladis can be dropped as he plans to rework on that.

Regards,
Keerthy

> 
> Changes from V5:
> 
>    * Added couple of fixes from Ladis for  pwm-dmtimer.
> 
> Changes from v4:
> 
>    * Made OMAP_DM_TIMER config option silent.
>    * Changed the driver name to timer-dm.c
> 
> Changes from v3:
> 
>    * Reverted to v2 approach of using dev_get_platdata to fetch dmtimer ops.
> 
> Changes from V2:
> 
>    * Wrapped the inline functions in header file under OMAP2PLUS
>    * Added a new of helper function to fetch plat_data from of node.
> 
> Keerthy (8):
>    clocksource: dmtimer: Remove all the exports
>    arm: omap: timer: Wrap the inline functions under OMAP2PLUS define
>    arm: omap: Move dmtimer.h out of plat-omap
>    arm: OMAP: Move dmtimer driver out of plat-omap to drivers under
>      clocksource
>    dmtimer: Add timer ops to the platform data structure
>    clocksource: dmtimer: Populate the timer ops to the pdata
>    pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops
>    arm: omap: pdata-quirks: Remove unused timer pdata
> 
> Ladislav Michl (2):
>    clocksource: timer-dm: Hook device platform data if not already
>      assigned
>    clocksource: timer-dm: Check prescaler value
> 
>   arch/arm/mach-omap1/pm.c                           |  2 +-
>   arch/arm/mach-omap1/timer.c                        |  2 +-
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  2 +-
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  2 +-
>   arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  2 +-
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  2 +-
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  2 +-
>   arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  2 +-
>   arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  2 +-
>   arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  2 +-
>   arch/arm/mach-omap2/pdata-quirks.c                 | 32 -----------
>   arch/arm/mach-omap2/timer.c                        |  2 +-
>   arch/arm/plat-omap/Kconfig                         |  6 --
>   arch/arm/plat-omap/Makefile                        |  1 -
>   drivers/clocksource/Kconfig                        |  3 +
>   drivers/clocksource/Makefile                       |  1 +
>   .../dmtimer.c => drivers/clocksource/timer-dm.c    | 67 +++++++++++-----------
>   drivers/pwm/pwm-omap-dmtimer.c                     | 39 +++++++------
>   .../include/plat => include/clocksource}/dmtimer.h |  8 ++-
>   include/linux/platform_data/dmtimer-omap.h         | 38 ++++++++++++
>   20 files changed, 117 insertions(+), 100 deletions(-)
>   rename arch/arm/plat-omap/dmtimer.c => drivers/clocksource/timer-dm.c (94%)
>   rename {arch/arm/plat-omap/include/plat => include/clocksource}/dmtimer.h (97%)
> 
