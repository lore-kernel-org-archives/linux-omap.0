From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 0/6] OMAP: McSPI: Hwmod adaptation + runtime conversion
Date: Mon, 24 Jan 2011 14:26:45 -0800
Message-ID: <87lj2a5462.fsf@ti.com>
References: <1295614547-1920-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35279 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608Ab1AXW0t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 17:26:49 -0500
Received: by mail-iw0-f172.google.com with SMTP id 40so4938289iwn.31
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 14:26:49 -0800 (PST)
In-Reply-To: <1295614547-1920-1-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 21 Jan 2011 18:25:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Charulatha V <charu@ti.com>

Hi Govindraj,

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Changes invloves:
> ----------------
> 1) Addition of hwmod data for omap2/3/4.
> 2) McSPI driver hwmod adaptation with cleanup of base address
>    macros and using omap-device API's.
> 3) Runtime Conversion of McSPI driver.

I accidentally replied to the v4 series about the refresh, but this one
still needs ar refresh.

Specifically, this change from Gregory Clement touches some of the same
code as your patch:

commit 42ce7fd6319bed8ecb26d656c476365da46b29e9
Author: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date:   Wed Dec 29 11:52:53 2010 +0100

    spi/omap2_mcspi.c: Force CS to be in inactive state after off-mode transition
    

Kevin

>
> Changes from v4:
> ---------------
> 1) 4430 hwmod file alignment based on Benoit's comments.
>    http://www.spinics.net/lists/arm-kernel/msg111215.html
>    4430 Hwmod file now aligned based on:
>    http://gitorious.org/omap-pm/linux/blobs/pm-wip/
>    hwmods-omap4-full/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>
> Changes from v3:
> ---------------
> 1) Updated proper Author for all patches which was missed
>    in v2. 
> 2) Modified 4430 hwmod data file so that mcspi data gets
>    updated in proper alphabetical order.
> 3) Update omap2/3 hwmod dat files with SYSS_HAS_RESET_STATUS
>    flag.
>
> Changes from v2:
> ---------------
> 1) Fixing minor comments and adding ack from Grant Likely.
> 	https://patchwork.kernel.org/patch/371321/
> 	https://patchwork.kernel.org/patch/371331/
>
> Changes from v1:
> ---------------
> 1) Fixing patch 5/5 comments for hwmod+runtime
>   Split the patch 5/5 to hwmod adaptation
>   and then runtime conversion
>   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg33387.html
>
> Testing Updates:
> ----------------
> Was tested using data transfer test module available at:
> http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=blob;f=mcspi/test_code/
> utils/mcspi_modules/omap_mcspi_datatest.c;
> h=e42ec10c5c844abdde6a7175a268b379fbbdb655;
> hb=5d9a755d50e58de861c5e8991f2f607bc49b5dc3
> This test basically involves MISO <--> MOSI lines looped and data transfer test
> done using the above test module.
> System wide suspend and ret/off counts observation, ensured that no behavioral
> difference with and without this patch series.
>
> Benoit Cousson (1):
>   OMAP4: hwmod data: Add McSPI
>
> Charulatha V (4):
>   OMAP2420: hwmod data: Add McSPI
>   OMAP2430: hwmod data: Add McSPI
>   OMAP3: hwmod data: Add McSPI
>   OMAP: devices: Modify McSPI device to adapt to hwmod framework
>
> Govindraj.R (1):
>   OMAP: runtime: McSPI driver runtime conversion
>
>  arch/arm/mach-omap2/devices.c              |  187 ++++---------------
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  156 ++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |  219 ++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  280 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  267 ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/mcspi.h    |   11 +
>  drivers/spi/omap2_mcspi.c                  |  224 +++++++---------------
>  7 files changed, 1044 insertions(+), 300 deletions(-)
