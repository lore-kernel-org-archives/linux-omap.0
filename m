From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/mmc][PATCH 00/10] OMAP MMC Hwmod & Runtime patches
Date: Thu, 26 Aug 2010 16:17:29 -0700
Message-ID: <87hbihvu9i.fsf@deeprootsystems.com>
References: <16071.10.24.255.18.1282335017.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53430 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282Ab0HZXRc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 19:17:32 -0400
Received: by pwi7 with SMTP id 7so911767pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 16:17:32 -0700 (PDT)
In-Reply-To: <16071.10.24.255.18.1282335017.squirrel@dbdmail.itg.ti.com>
	(kishore kadiyala's message of "Sat, 21 Aug 2010 01:40:17 +0530
	(IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com

"kishore kadiyala" <kishore.kadiyala@ti.com> writes:

> Hi,
>
> 1) The patch series has dependency on Tony's patches
>    http://www.spinics.net/lists/linux-omap/msg34835.html
>    http://www.spinics.net/lists/linux-omap/msg34834.html
>
> 2) The patch series has some updations of hwmod data
>    for MMC controller's on MMC2/3.
> 3) Also adds & updates hwmod data for mmc and uart for OMAP4.
>    Adding UART for OMAP4 helps to validate MMC cards from console
> 4) Also the series includes couple of fixes
>    a) runtime crash seen currently on tree. Validated on OMAP3430.
>    b) crash on OMAP4430 when CONFIG_MMC_OMAP_HS is not set.
>
> The entire series has been tested on OMAP4430 SDP with omap3_defconfig
> Currently working on runtime for MMC and will update later.

This needs testing on OMAP2 as well.

Please take over responsibility of the pm-wip/mmc branch and feel free
to combine those patches with yours.  They are there just to get
started, but you are free to take them and do what you like with them.

For the next rev, just include/merge the patches from pm-wip/mmc with
yours and post them against my pm-core branch (a.k.a. pm-wip/hwmods-omap4)

> Kishore Kadiyala (7):
>   [PM-WIP-MMC] OMAP2 HWMOD: Updating MMC Controller data
>   [PM-WIP-MMC] OMAP3 HWMOD: Updating MMC controller data
>   [PM-WIP-MMC] OMAP2/OMAP3: Updating hwmod name for MMC controller
>   [PM-WIP-MMC] OMAP4 hwmod: Updating hwmod data for MMC controllers

Some minor nits on naming:  let's use the prefix:

     <soc>: hwmod data: <shortlog>

e.g. OMAP3: hwmod data: add MMC controllers

Kevin

>   [PM-WIP-MMC] OMAP MMC: Remove MMC controller reset
>   [PM-WIP-MMC] OMAP MMC: Register offset handling
>   [PM-WIP-MMC] OMAP MMC : Fix crash with CONFIG_PM_RUNTIME
>
> Benoit Cousson (3):
>   [PM-WIP-MMC] OMAP4 hwmod: Adding hwmod data for MMC controller
>   [PM-WIP-UART] OMAP4 hwmod : Adding hwmod data for UART
>   [PM-WIP-MMC] omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is not
>     set
>
>  arch/arm/mach-omap2/board-4430sdp.c        |    7 +-
>  arch/arm/mach-omap2/devices.c              |  106 +-----
>  arch/arm/mach-omap2/hsmmc.c                |    6 +
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    9 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   11 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  567 +++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/mmc.h      |   76 ++++
>  drivers/mmc/host/omap_hsmmc.c              |  256 ++++++-------
>  8 files changed, 785 insertions(+), 253 deletions(-)
