From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v2 0/7] omap: dmtimer: Move driver out of plat-omap
Date: Wed, 8 Nov 2017 13:51:51 +0100
Message-ID: <20171108125151.li2mgxuxisan5f6c@lenoch>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 08, 2017 at 05:58:21PM +0530, Keerthy wrote:
> The series moves dmtimer out of plat-omap to drivers/clocksource.
> The series also does a bunch of changes to pwm-omap-dmtimer code
> to adapt to the driver migration and clean up plat specific
> pdata-quirks and use the dmtimer platform data.
> 
> Boot tested on DRA7-EVM and AM437X-GP-EVM.

Boot tested on IGEPv2 with DM3730 and OMAP3530
Tested-by: Ladislav Michl <ladis@linux-mips.org>

> More testing would be of great help. 
> 
> No code changes in this v2 version. Only enhanced patch
> statistics for renames.

Btw, what are these pathes against. Here's how it ends against 4.14-rc8:
Applying: clocksource: dmtimer: Remove all the exports
Applying: arm: omap: Move dmtimer.h out of plat-omap
Applying: arm: OMAP: Move dmtimer driver out of plat-omap to drivers under clocksource
error: patch failed: drivers/clocksource/Kconfig:46
error: drivers/clocksource/Kconfig: patch does not apply
Patch failed at 0003 arm: OMAP: Move dmtimer driver out of plat-omap to drivers under clocksource

Test above was using your first serie which I manually fixed to apply.
Given the fact there is no code change, I will not do this again :-)
(and I'm happy someone is cleaning dm timer code, thank you)

	ladis

> Keerthy (7):
>   clocksource: dmtimer: Remove all the exports
>   arm: omap: Move dmtimer.h out of plat-omap
>   arm: OMAP: Move dmtimer driver out of plat-omap to drivers under
>     clocksource
>   dmtimer: Add timer ops to the platform data structure
>   clocksource: dmtimer: Populate the timer ops to the pdata
>   pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops
>   arm: omap: pdata-quirks: Remove unused timer pdata
> 
>  arch/arm/mach-omap1/pm.c                           |  2 +-
>  arch/arm/mach-omap1/timer.c                        |  2 +-
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  2 +-
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  2 +-
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  2 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  2 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  2 +-
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  2 +-
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  2 +-
>  arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  2 +-
>  arch/arm/mach-omap2/pdata-quirks.c                 | 32 -------------
>  arch/arm/mach-omap2/timer.c                        |  2 +-
>  arch/arm/plat-omap/Kconfig                         |  6 ---
>  arch/arm/plat-omap/Makefile                        |  1 -
>  drivers/clocksource/Kconfig                        |  6 +++
>  drivers/clocksource/Makefile                       |  1 +
>  .../plat-omap => drivers/clocksource}/dmtimer.c    | 54 +++++++++++-----------
>  drivers/pwm/pwm-omap-dmtimer.c                     | 39 +++++++++-------
>  .../include/plat => include/clocksource}/dmtimer.h |  0
>  include/linux/platform_data/dmtimer-omap.h         | 38 +++++++++++++++
>  20 files changed, 104 insertions(+), 95 deletions(-)
>  rename {arch/arm/plat-omap => drivers/clocksource}/dmtimer.c (95%)
>  rename {arch/arm/plat-omap/include/plat => include/clocksource}/dmtimer.h (100%)
> 
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
