From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/11] Prepare for OMAP2+ movement to Common Clk
Date: Wed, 27 Jun 2012 14:50:47 +0200
Message-ID: <1397795.nxQGnEDtVe@avalon>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:51503 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab2F0Muo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 08:50:44 -0400
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Rajendra,

On Friday 22 June 2012 19:17:59 Rajendra Nayak wrote:
> Hi,
> 
> This is a preparatory series for the OMAP Common Clk
> conversion. They mostly add clk_prepare/clk_unprepare
> in OMAP drivers and platform code. Also gets
> rid of omap_clk_get_by_name() and uses clk_get(), and
> removes all direct 'struct clk' dereferrencing and
> uses helpers similar to what is provided by Common
> Clk.

I think you've missed drivers/media/video/omap3isp/isp.c. Should I send a 
patch for that ? Do these changes depend on anything not yet in mainline that 
I should apply to my tree for testing ?

> Patches are boot tested on OMAP2430sdp, 3630 Beagle-Xm
> and 4460 Panda.
> 
> Some of these patches were earlier posted as part of
> OMAP2+ Common Clk conversion series [1] which is now
> split into a preparatory series and actual CCF conversion
> series.
> 
> Patches from this series can be found here
> git://github.com/rrnayak/linux.git prepare-common-clk-3.5-rc3
> 
> regards,
> Rajendra
> 
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70299.html
> 
> Rajendra Nayak (11):
>   ARM: omap: clk: add clk_prepare and clk_unprepare
>   mmc: omap: add clk_prepare and clk_unprepare
>   hwrng: omap: add clk_prepare and clk_unprepare
>   mfd: omap-usb: add clk_prepare and clk_unprepare
>   OMAPDSS: add clk_prepare and clk_unprepare
>   gpio/omap: add clk_prepare and clk_unprepare
>   w1: omap_hdq: add clk_prepare and clk_unprepare
>   crypto: omap: add clk_prepare and clk_unprepare
>   iommu: omap: add clk_prepare and clk_unprepare
>   ARM: omap: hwmod: get rid of all omap_clk_get_by_name usage
>   ARM: omap: clk: Remove all direct dereferencing of struct clk
> 
>  arch/arm/mach-omap2/board-apollon.c          |    4 +-
>  arch/arm/mach-omap2/board-h4.c               |    6 +-
>  arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
>  arch/arm/mach-omap2/clkt2xxx_apll.c          |    2 +-
>  arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    4 +-
>  arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |   18 +++---
>  arch/arm/mach-omap2/clkt_clksel.c            |   84 ++++++++++++++++-------
>  arch/arm/mach-omap2/clkt_dpll.c              |   24 ++++---
>  arch/arm/mach-omap2/clock.c                  |    9 ++-
>  arch/arm/mach-omap2/clock2420_data.c         |   17 +++++
>  arch/arm/mach-omap2/clock2430_data.c         |   21 +++++++
>  arch/arm/mach-omap2/clock3xxx.c              |    8 +-
>  arch/arm/mach-omap2/clock3xxx_data.c         |   24 +++++++
>  arch/arm/mach-omap2/clock44xx_data.c         |   17 +++++
>  arch/arm/mach-omap2/display.c                |    4 +-
>  arch/arm/mach-omap2/dpll3xxx.c               |   45 ++++++++------
>  arch/arm/mach-omap2/gpmc.c                   |    2 +-
>  arch/arm/mach-omap2/omap_hwmod.c             |   21 ++++---
>  arch/arm/mach-omap2/omap_phy_internal.c      |    3 +
>  arch/arm/mach-omap2/pm.c                     |    2 +-
>  arch/arm/mach-omap2/pm24xx.c                 |    2 +
>  arch/arm/mach-omap2/usb-fs.c                 |    4 +-
>  arch/arm/plat-omap/include/plat/clock.h      |    4 +
>  arch/arm/plat-omap/omap_device.c             |    6 +-
>  drivers/char/hw_random/omap-rng.c            |    6 +-
>  drivers/crypto/omap-aes.c                    |    2 +
>  drivers/crypto/omap-sham.c                   |    2 +
>  drivers/gpio/gpio-omap.c                     |    2 +
>  drivers/iommu/omap-iommu.c                   |    2 +
>  drivers/mfd/omap-usb-host.c                  |   20 ++++++
>  drivers/mmc/host/omap.c                      |    9 ++-
>  drivers/mmc/host/omap_hsmmc.c                |    6 +-
>  drivers/video/omap2/dss/dsi.c                |    5 +-
>  drivers/video/omap2/dss/hdmi.c               |    5 +-
>  drivers/video/omap2/dss/venc.c               |    5 +-
>  drivers/w1/masters/omap_hdq.c                |    8 +-
>  36 files changed, 292 insertions(+), 113 deletions(-)

-- 
Regards,

Laurent Pinchart

