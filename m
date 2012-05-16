From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/9] ARM: OMAP: DMTIMER clean-up in preparation for device-tree
Date: Wed, 16 May 2012 11:28:54 +0200
Message-ID: <4FB37356.9040001@ti.com>
References: <1337124914-19921-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40340 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965010Ab2EPJ25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 05:28:57 -0400
In-Reply-To: <1337124914-19921-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Jon,

On 5/16/2012 1:35 AM, Jon Hunter wrote:
> From: Jon Hunter<jon-hunter@ti.com>
>
> In order to migrate the dmtimer driver to support device-tree I found that it
> was first necessary to clean-up the timer platform data. The goal of this
> series is to simplify the timer platform data structure from ...
>
> struct dmtimer_platform_data {
> 	int (*set_timer_src)(struct platform_device *pdev, int source);
> 	int timer_ip_version;
> 	u32 needs_manual_reset:1;
> 	bool reserved;
> 	bool loses_context;
> 	int (*get_context_loss_count)(struct device *dev);
> };
>
> to ...
>
> struct dmtimer_platform_data {
> 	int (*set_timer_src)(struct platform_device *pdev, int source);

I guess that custom set_timer_src should not be there at all anymore. 
Well at least for OMAP2+.
We should just use the regular clock API to change the parent. I do not 
see why we should add that wrapper on top of the clock API and thus 
store some internal clock name inside the timer device init code.


Regards,
Benoit


> 	u32 timer_capability;
> };
>
> ... where timer_capability is a bit mask that indicates the timer features
> supported and uses the HWMOD timer capabilities flags described in
> plat/dmtimer.h. For OMAP2+ devices this allows us to read the timer
> capabilities from the HWMOD data and for OMAP1 devices the flags are simply
> populated by the timer initialisation code. Eventually, the aim is to read the
> timer capabilities from the device tree blob.
>
> This series includes some fixes as well as clean-up. If it is preferred to split
> the series into fixes and clean-up I can do that, but wanted to get some
> feedback on this approach.
>
> This series is based upon the current linux-omap master branch. I have built
> both omap1 and omap2plus configurations as well as booted the respective kernels
> on the omap5912 OSK (omap1), omap2430 SDP, OMAP3430 Beagle and OMAP4460 PANDA.
>
> Jon Hunter (9):
>    ARM: OMAP: Remove unnecessary clk structure
>    ARM: OMAP2+: Remove unused max number of timers definition
>    ARM: OMAP2+: Add dmtimer platform function to reserve systimers
>    ARM: OMAP: Represent timer features using HWMOD flags
>    ARM: OMAP2+: HWMOD: Correct timer device attributes
>    ARM: OMAP2+: Fix external clock support for dmtimers
>    ARM: OMAP: Remove loses_context variable from timer platform data
>    ARM: OMAP: Remove timer function pointer for context loss counter
>    ARM: OMAP: Add flag to indicate if a timer needs a manual reset
>
>   arch/arm/mach-omap1/timer.c                        |    3 +-
>   arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   24 ++++++----
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   10 +----
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 --
>   arch/arm/mach-omap2/timer.c                        |   22 ++-------
>   arch/arm/plat-omap/dmtimer.c                       |   49 ++++++++++++--------
>   arch/arm/plat-omap/include/plat/dmtimer.h          |   21 ++------
>   7 files changed, 57 insertions(+), 78 deletions(-)
>

