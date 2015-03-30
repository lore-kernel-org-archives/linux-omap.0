From: Roger Quadros <rogerq@ti.com>
Subject: Re: [GIT PULL] OMAP-GPMC driver updates for v4.1
Date: Mon, 30 Mar 2015 10:55:00 +0300
Message-ID: <55190154.6050905@ti.com>
References: <550FEBC6.3000902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34859 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbbC3Hzj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2015 03:55:39 -0400
In-Reply-To: <550FEBC6.3000902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Arnd, Olof,

On 23/03/15 12:32, Roger Quadros wrote:
> Hi Arnd, Hi Olof,
> 
> Based on Tony's request I will be sending you pull requests for OMAP-GPMC driver
> hence forth. I've sent this earlier on the 9th of March but had missed to copy Olof.
> 
> Please pull in these OMAP-GPMC driver fixes for v4.1.
> Patches have been tested for GPMC-NAND on dra7-evm and omap3-beagle.

Gentle reminder. Thanks.

cheers,
-roger

> 
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git@github.com:rogerq/linux.git tags/gpmc-omap-for-v4.1
> 
> for you to fetch changes up to 4b613e9b4bbe94545a588a100e09006d827a7ebe:
> 
>   ARM OMAP2+ GPMC: fix programming/showing reserved timing parameters (2015-03-06 12:55:32 +0200)
> 
> ----------------------------------------------------------------
> OMAP-GPMC driver fixes for v4.1
> 
> * Fixed WAITMONITORINGTIME programming to be based on
> GPMC_CLK instead of GPMC_FCLK. The GPMC clock divider
> programming is fixed for both synchronous and asynchronous
> modes.
> * Allow GPMC's children of default bus type to be populated in
> the device tree.
> * Improved DEBUG output data and format.
> * Prevent writing 1 into reserved bits of GPMC_CONFIG7.
> 
> ----------------------------------------------------------------
> Robert ABEL (8):
>       ARM OMAP2+ GPMC: don't undef DEBUG
>       ARM OMAP2+ GPMC: add bus children
>       ARM OMAP2+ GPMC: fix debug output alignment
>       ARM OMAP2+ GPMC: change get_gpmc_timing_reg output for DTS
>       ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
>       ARM OMAP2+ GPMC: calculate GPMCFCLKDIVIDER based on WAITMONITORINGTIME
>       ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider bug
>       ARM OMAP2+ GPMC: fix programming/showing reserved timing parameters
> 
> Semen Protsenko (2):
>       ARM: OMAP2+: gpmc: Fix writing in gpmc_cs_set_memconf
>       ARM: OMAP2+: gpmc: make gpmc_cs_get_name() static
> 
>  arch/arm/mach-omap2/gpmc-nand.c    |  18 +++++----
>  arch/arm/mach-omap2/gpmc-onenand.c |   4 +-
>  arch/arm/mach-omap2/usb-tusb6010.c |   4 +-
>  drivers/memory/omap-gpmc.c         | 358 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
>  include/linux/omap-gpmc.h          |   3 +-
>  5 files changed, 305 insertions(+), 82 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

