From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8 v4] ARM OMAP2+ GPMC: fixes and bus children
Date: Thu, 5 Mar 2015 16:58:13 -0800
Message-ID: <20150306005813.GF13510@atomide.com>
References: <1425052615-29093-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery3.ore.mailhop.org ([54.191.214.36]:59821 "EHLO
	pmta1.delivery3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753983AbbCFBDh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 20:03:37 -0500
Content-Disposition: inline
In-Reply-To: <1425052615-29093-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Cc: balbi@ti.com, rogerq@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk

* Robert ABEL <rabel@cit-ec.uni-bielefeld.de> [150227 08:00]:
> These are the changes I proposed in these patch series: [1], [2], [3], [4]
> rebased to 3.19 as well as new changes for little bugs I noticed while
> preparing this patch series as well as changes introduced via comments.
> 
> 1. DEBUG was undefined in source code --> remove offending lines
> 2. add capability to have busses as children of the GPMC and multiple
>    devices on a bus. See [2] for an example DTS syntax.
> 3. debug output was unaligned --> align it
> 4. output for copy-pasting to DTS had erroneous timing outputs and
>    made it hard to copy-paste --> correct timing values, add comments
>    as DTS comments.
> 5. WAITMONITORINGTIME is expressed as GPMC_CLK cycles for all accesses.
>    GPMCFCLKDIVIDER is used as a divider, so it must always be programmed.
> 6. GPMCFCLKDIVIDER is calculated according to WAITMONITORINGTIME for
>    asynchronous accesses inside the driver --> asynchronous accesses now
>    completely decoupled from gpmc,sync-clk-ps.
> 7. WAITMONITORINGTIME was being programmed/shown in GPMC_FCLK cycles instead
>    of GPMC_CLK cycles --> add clock domain information where necessary.
> 8. Calculated values for WAITMONITORINGTIME and CLKACTIVATIONTIME that were
>    outside the defined range would not raise an error.
>    DEVICESIZE, ATTACHEDDEVICEPAGELENGTH, WAITMONITORINGTIME and
>    CLKACTIVATIONTIME would not be marked as incorrect on DTS output.
>    --> Fix all of these.

Thanks for fixing all these issues:

Acked-by: Tony Lindgren <tony@atomide.com>

 
> [1]: https://lkml.org/lkml/2015/2/12/495
> [2]: https://lkml.org/lkml/2015/2/16/337
> [3]: https://lkml.org/lkml/2015/2/24/609
> [4]: https://lkml.org/lkml/2015/2/26/387
> 
> Robert ABEL (9):
>   ARM OMAP2+ GPMC: don't undef DEBUG
>   ARM OMAP2+ GPMC: add bus children
>   ARM OMAP2+ GPMC: fix debug output alignment
>   ARM OMAP2+ GPMC: change get_gpmc_timing_reg output for DTS
>   ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
>   ARM OMAP2+ GPMC: calculate GPMCFCLKDIVIDER based on WAITMONITORINGTIME
>   ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider bug
>   ARM OMAP2+ GPMC: fix programming/showing reserved timing parameters
> 
>  arch/arm/mach-omap2/gpmc-nand.c    |  17 +-
>  arch/arm/mach-omap2/gpmc-onenand.c |   4 +-
>  arch/arm/mach-omap2/usb-tusb6010.c |   4 +-
>  drivers/memory/Makefile            |   2 +
>  drivers/memory/omap-gpmc.c         | 313 +++++++++++++++++++++++++++++--------
>  include/linux/omap-gpmc.h          |   2 +-
>  6 files changed, 265 insertions(+), 77 deletions(-)
> 
> -- 
> 2.3.0
> 
