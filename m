From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 0/5] mfd: tps65218: Clean ups
Date: Fri, 16 Sep 2016 17:12:38 +0530
Message-ID: <ab94aff0-8470-57e5-2039-12f09bb0ca33@ti.com>
References: <1470833641-29546-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470833641-29546-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, russ.dill-l0cyMroinI0@public.gmane.org, d-gerlach-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 10 August 2016 06:24 PM, Keerthy wrote:
> The series cleans up mainly the regulator driver and implements
> the device tree parsing using the regulator framework. Removes
> all the redundant compatibles for the individual regulators.
> Adds platform_device_id table for the gpio and power button modules.
>
> One of the patch removes redundant read wrapper and makes
> use of regmap_read wherever necessary.

Mark,

Should i repost this series? I do not see this series in linux-next yet.

Regards,
Keerthy
>
> The series is checked for all the regulator registrations on
> am437x-gp-evm.
>
> Boot log: http://pastebin.ubuntu.com/22905402/
>
> The series is based on linux-next on top of series titled:
> [PATCH v3 0/2] regulator: Enable suspend configuration
>
> Do not have the link of the above series available at the moment.
>
> Changes in v7:
>
> Rebasing to latest next branch. GPIO patch of this series
> pushed to linux-next by Linus. Hence posting the remaining
> patches with respective Acks from the domain Maintainers.
>
> Changes in v6:
>
> Rebased regulator/mfd clean up patches against linux-next +
> https://lkml.org/lkml/2016/6/24/122 series.
>
> Changes in v5:
>
> Rebased regulator clean up patch against linux-next.
>
> Changes in v4:
>
> For gpio-tps65218 reatined the compatible table.
> Fixed missing ';' in the power button patch.
> Fixed comments on the Documentation patch.
> Split the Device Tree patches to a separate series.
>
> Changes in v3:
>
> Missed making corresponding changes in the power button and gpio
> drivers. Added couple of patches to fix them to use mfd_cell way
> of parsing.
>
> Keerthy (5):
>   mfd: tps65218: Remove redundant read wrapper
>   Documentation: regulator: tps65218: Update examples
>   input: tps65218-pwrbutton: Add platform_device_id table
>   mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
>   regulator: tps65218: Remove all the compatibles
>
>  .../devicetree/bindings/regulator/tps65218.txt     |  87 +++++++++---
>  drivers/gpio/gpio-tps65218.c                       |   3 +-
>  drivers/input/misc/tps65218-pwrbutton.c            |  10 +-
>  drivers/mfd/tps65218.c                             |  34 ++---
>  drivers/regulator/tps65218-regulator.c             | 153 ++++++++-------------
>  include/linux/mfd/tps65218.h                       |   3 +-
>  6 files changed, 158 insertions(+), 132 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
