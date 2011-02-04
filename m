From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 00/13] OMAP: McBSP: hwmod adaptation  and runtime conversion
Date: Fri, 04 Feb 2011 13:42:18 -0800
Message-ID: <87ei7no4sk.fsf@ti.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:39539 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752981Ab1BDVmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 16:42:25 -0500
Received: by gwaa12 with SMTP id a12so1213053gwa.20
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 13:42:24 -0800 (PST)
In-Reply-To: <1296485437-12806-1-git-send-email-kishon@ti.com> (Kishon Vijay
	Abraham, I's message of "Mon, 31 Jan 2011 20:20:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, p-basak2@ti.com

Kishon Vijay Abraham I <kishon@ti.com> writes:

> Modify OMAP McBSP driver to use omap hwmod framework and pm runtime  APIs.
>
> Created on top of linux OMAP master (linux-omap-2.6 :master)
> Did digital loopback testing on OMAP4430, OMAP3430 and OMAP2430 SDP boards.
> Verified that this patch series does not break the OMAP1 build.

Can you also do some basic PM testing with audio?  e.g. does audio still
work after suspend/resume  what about with CPUidle when retention and/or
off are hit during idle?

Kevin

> Patch series modifies audio layer and hence would appreciate the help of
> some audio guy to test this series.
>
> Patch series requires the following patch to be present
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51132
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51133
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51134
>
> V2:
> * Added omap_hwmod_lookup() in the callback to omap_hwmod_for_each_by_class()
>  to obtain hwmod data for sidetone. Previously this nesting of hwmod APIs was
>  prevented by the use of mutex.
>
> * Added a revision member in hwmod database inorder to facilitate the driver
>  to differentiate between different OMAP.
>
> * Created APIs to pass DMA params from McBSP driver to client drivers
>
> * Cleaned up sound soc by removing the use of macros to obtain base address
>  and DMA channel number and instead use APIs exposed by the driver.
>
> * Removed macros defined in mcbsp driver for data that is obtained from
>  hwmod database
>
> V1:
> * McBSP is designed to use multiple hwmods for a single device when the McBSP
>  device has sidetone feature.
>
> * To avoid funcionality break of OMAP1 McBSP in between the series
>  and to keep the patches readable, implementation was done in two steps:
>   - First modify mcbsp driver to use platform_get* APIs
>   - then convert it to use hwmod framework for OMAP2+.
>
> * API's like omap_device_noidle() and omap_device_default_idle() is used to
>  change the SYCONFIG register bits. This change is done to align with the
>  discussion on [2]
>
> * Use '.rev' of omap_hwmod class to identify OMAP3 specific settings
>
> * Use *ST_* macros for idlest_idle bit
>
> * Incorporate other general review comments provided for hwmod adpatation
>  of other OMAP driver's (eg., do pdata free after a omap_device_build())
>
> * Retain fclk even after pm_runtime adaptation to facilitate switching of
>  functional clock from one source to another
>
> * Add member 'name' to omap_hwmod_addr_space struct so that the driver need
>  not rely on the order to get the proper resource [3].
>
> Discussions related to the first RFC patch can be found at [1]
>
> [1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36743.html
> [2]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39615.html
> [3]: https://patchwork.kernel.org/patch/233211/
>
> Benoit Cousson (1):
>   OMAP4: hwmod data: Add McBSP
>
> Charulatha V (3):
>   OMAP2420: hwmod data: Add McBSP
>   OMAP2430: hwmod data: Add McBSP
>   OMAP3: hwmod data: Add McBSP
>
> Kishon Vijay Abraham I (9):
>   OMAP: hwmod: Add member 'name' to omap_hwmod_addr_space struct
>   OMAP: McBSP: Convert McBSP to platform device model
>   OMAP3: hwmod: add dev_attr for McBSP sidetone
>   OMAP2+: McBSP: hwmod adaptation for McBSP
>   OMAP: McBSP: use omap_device APIs to modify SYSCONFIG
>   OMAP: McBSP: Add pm runtime support
>   OMAP: McBSP: APIs to pass DMA params from McBSP driver to client
>     drivers
>   ASoC: McBSP: get hw params from McBSP driver
>   OMAP: hwmod: Removal of macros for data that is obtained from hwmod
>     database
>
>  arch/arm/mach-omap1/mcbsp.c                  |  383 +++++++++++++++----
>  arch/arm/mach-omap2/mcbsp.c                  |  228 +++---------
>  arch/arm/mach-omap2/omap_hwmod.c             |    1 +
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c   |  167 ++++++++
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c   |  417 ++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  544 ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  321 +++++++++++++++
>  arch/arm/mach-omap2/prcm-common.h            |    4 +
>  arch/arm/plat-omap/devices.c                 |   10 +-
>  arch/arm/plat-omap/include/plat/mcbsp.h      |   69 +---
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +-
>  arch/arm/plat-omap/mcbsp.c                   |  207 +++++++---
>  sound/soc/omap/omap-mcbsp.c                  |  126 +------
>  13 files changed, 2006 insertions(+), 475 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
