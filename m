From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/3] omap clean-up for v3.20
Date: Wed, 21 Jan 2015 16:50:45 -0800
Message-ID: <20150122005045.GE29014@quad.lixom.net>
References: <pull-1421450357-648499>
 <54b99dd2.d0bc420a.57d0.ffffc9f5SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57810 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbbAVAuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2015 19:50:46 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so56397509pab.5
        for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2015 16:50:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54b99dd2.d0bc420a.57d0.ffffc9f5SMTPIN_ADDED_BROKEN@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 16, 2015 at 03:21:21PM -0800, Tony Lindgren wrote:
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/cleanup-pt1
> 
> for you to fetch changes up to ca662ee7b8a85c54c1cb9ef34b7c6b4f67933a7e:
> 
>   ARM: OMAP2+: Remove unused ti81xx platform init code (2015-01-14 17:21:00 -0800)
> 
> ----------------------------------------------------------------
> Clean-up for omaps to remove dead code found with cppcheck after
> we've made several SoCs to boot in device tree only mode.
> 
> ----------------------------------------------------------------
> Rickard Strandqvist (10):
>       ARM: OMAP2+: clkt2xxx_apll.c: Remove some unused functions
>       ARM: OMAP2+: cm33xx.c: Remove some unused functions
>       ARM: OMAP2+: dpll44xx.c: Remove unused function
>       ARM: OMAP2+: omap_hwmod.c: Remove some unused functions
>       ARM: OMAP2+: powerdomain.c: Remove some unused functions
>       ARM: OMAP2+: voltage: Remove some unused functions
>       ARM: OMAP2+: omap-pm-noop.c: Remove some unused functions
>       ARM: OMAP1: irq.c: Remove unused function
>       ARM: OMAP1: timer32k.c: Remove unused function
>       ARM: OMAP: dma.c: Remove unused function
> 
> Tero Kristo (3):
>       ARM: OMAP2: clock: remove unused apll code
>       ARM: OMAP2: CM: remove unused PLL functions
>       ARM: OMAP3+: PRM: remove prm_get_reset_sources declaration from headers
> 
> Tony Lindgren (1):
>       ARM: OMAP2+: Remove unused ti81xx platform init code
> 
>  arch/arm/mach-omap1/irq.c               |   5 -
>  arch/arm/mach-omap1/timer32k.c          |   5 -
>  arch/arm/mach-omap2/Makefile            |   1 -
>  arch/arm/mach-omap2/cclock3xxx_data.c   |   6 +-
>  arch/arm/mach-omap2/clkt2xxx_apll.c     | 142 -------------------
>  arch/arm/mach-omap2/clock.h             |   1 -
>  arch/arm/mach-omap2/clock2xxx.h         |  11 --
>  arch/arm/mach-omap2/cm2xxx.c            |  10 --
>  arch/arm/mach-omap2/cm2xxx.h            |   2 -
>  arch/arm/mach-omap2/cm33xx.c            |  21 ---
>  arch/arm/mach-omap2/dpll44xx.c          |  20 ---
>  arch/arm/mach-omap2/omap-pm-noop.c      | 196 ---------------------------
>  arch/arm/mach-omap2/omap-pm.h           | 192 --------------------------
>  arch/arm/mach-omap2/omap_hwmod.c        | 232 --------------------------------
>  arch/arm/mach-omap2/omap_hwmod.h        |  16 ---
>  arch/arm/mach-omap2/omap_phy_internal.c |  35 -----
>  arch/arm/mach-omap2/powerdomain.c       |  82 -----------
>  arch/arm/mach-omap2/powerdomain.h       |   5 -
>  arch/arm/mach-omap2/prm3xxx.h           |   1 -
>  arch/arm/mach-omap2/prm44xx_54xx.h      |   1 -
>  arch/arm/mach-omap2/usb-musb.c          |  12 +-
>  arch/arm/mach-omap2/usb.h               |   2 -
>  arch/arm/mach-omap2/voltage.c           | 110 ---------------
>  arch/arm/mach-omap2/voltage.h           |  13 --
>  arch/arm/plat-omap/dma.c                |   8 --
>  25 files changed, 3 insertions(+), 1126 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/clkt2xxx_apll.c

Nice diffstat. Merged.

-Olof
