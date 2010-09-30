From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv3 0/17] OMAP dmtimer hwmod
Date: Thu, 30 Sep 2010 21:43:36 +0200
Message-ID: <4CA4E868.3030309@ti.com>
References: <1285059029-26291-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46988 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756518Ab0I3Tnj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 15:43:39 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8UJhcac027456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 14:43:38 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o8UJhcQ6005753
	for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 14:43:38 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o8UJhcC7013759
	for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 14:43:38 -0500 (CDT)
In-Reply-To: <1285059029-26291-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tarun,

On 9/21/2010 10:50 AM, Tarun Kanti DebBarma wrote:
> This patch series implements dmtimer hwmod.

Maybe the description should be a little bit more detailed:
Something like "Adapt dmtimer code to platform_driver using omap_device 
/ omap_hwmod abstraction"

Benoit

>
> Version 3
> *********
> (1) multi-line comment error correction
>
> (2) provision to allow any of the available dmtimers as early timers
> instead of restricting them to millisecond timers only.
>
> (3) in 'struct omap_dmtimer{}' is_initialized flag is redundant and
> so must be removed. if the element is found in the list it is already
> initialized.
>
> (4) remove 'found' flag in omap_dm_timer_request() and
> omap_dm_timer_request_specific() functions.
> this is not needed with alternate implementation.
>
> (5) use .init_name to initialize device names so that it can be identified
> during early boot as well. This is to avoid duplicate functions for clock
> manipulations during early boot and later.
>
> (6) remove redundant functions from mach-omap2 which are created just to
> call pm functions like: pm_runtime_get_sync(),pm_runtime_put_sync(),..
> and instead call them directly from plat-omap function api's.
>
> (7) timer clock source names made part of hwmod database. source_clock[]
> of type 'struct clk' is made part of platform data.
>
> (8) clockactivity field initialized in hwmod database to preserve fclk
> during idle. code which manipulate OCP config removed since they are
> already taken care by hwmod framework.
>
> (9) omap2_dm_timer_set_src() is optimized. Clock enable/disbale routines
> moved to plat-omap layer and simplfied to the level so as not to sacrifice
> intended functionality.
>
> NOTE: During early boot clock management was requested to be placed upon
> client drivers responsibility. this has not been done keeping in mind
> that it would entail (i) multiple modifications of client drivers (ii) it
> would violate the purpose of having a framework (open to debate).
>
> (10) dmtimer register maps moved to hwmod database
>
> Baseline
> ********
> origin/pm-core
>
> Test info
> *********
> OMAP4430SDP
> OMAP3630SDP
> OMAP3430SDP
> OMAP2430SDP
> OMAP1710SDP(Bootup)
>
>
> Tarun Kanti DebBarma (17):
>    OMAP2/3/4:dmtimer:add device names to flck nodes
>    dmtimer: infrastructure to support hwmod
>    dmtimer: add omap2420 hwmod database
>    dmtimer: add omap2430 hwmod database
>    dmtimer: add omap3xxx hwmod database
>    dmtimer: add omap44xx hwmod database
>    dmtimer: use list instead of static array
>    dmtimer: register mappings moved to hwmod database
>    OMAP: dmtimer platform driver
>    OMAP1: dmtimer conversion to platform devices
>    dmtimer: early boot infrastructure
>    OMAP2/3/4: dmtimers: convert to platform devices
>    dmtimer: switch-over to platform device driver with hwmod
>    dmtimer pm_runtime support
>    dmtimer: OMAP4 specific change in plat-omap
>    dmtimer: clean redundant code
>    dmtimer: remove OCP config code from plat-omap
>
>   arch/arm/mach-omap1/Makefile               |    2 +-
>   arch/arm/mach-omap1/dmtimer.c              |  174 ++++++
>   arch/arm/mach-omap2/Makefile               |    2 +-
>   arch/arm/mach-omap2/clock2420_data.c       |   24 +-
>   arch/arm/mach-omap2/clock2430_data.c       |   24 +-
>   arch/arm/mach-omap2/clock3xxx_data.c       |   24 +-
>   arch/arm/mach-omap2/clock44xx_data.c       |   22 +-
>   arch/arm/mach-omap2/dmtimer.c              |  288 ++++++++++
>   arch/arm/mach-omap2/dmtimer.h              |   25 +
>   arch/arm/mach-omap2/io.c                   |    2 +
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |  739 +++++++++++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |  737 +++++++++++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  815 ++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  796 +++++++++++++++++++++++++++
>   arch/arm/mach-omap2/timer-gp.c             |    1 -
>   arch/arm/plat-omap/dmtimer.c               |  679 +++++++++++------------
>   arch/arm/plat-omap/include/plat/dmtimer.h  |   80 +++
>   17 files changed, 4030 insertions(+), 404 deletions(-)
>   create mode 100644 arch/arm/mach-omap1/dmtimer.c
>   create mode 100644 arch/arm/mach-omap2/dmtimer.c
>   create mode 100644 arch/arm/mach-omap2/dmtimer.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

