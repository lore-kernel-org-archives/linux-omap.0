From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: some PRCM cleanup patches for v3.16
Date: Fri, 16 May 2014 14:24:26 -0700
Message-ID: <20140516212426.GJ12881@atomide.com>
References: <alpine.DEB.2.02.1405160445440.29738@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51729 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774AbaEPVYa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 17:24:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1405160445440.29738@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140515 21:48]:
> Hi Tony
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git for-v3.16/prcm-cleanup-a
> 
> for you to fetch changes up to 70fcebf1965b66d73bd8ae7955bd663ab8012c56:
> 
>   ARM: OMAP4: PRCM: remove references to cm-regbits-44xx.h from PRCM core files (2014-05-15 22:35:10 -0600)
> 
> ----------------------------------------------------------------
> Some OMAP PRCM cleanup patches.  These help prepare to convert the PRCM
> code into drivers.
> 
> Basic build, boot, and PM test results are available here:
> 
> http://www.pwsan.com/omap/testlogs/prcm-cleanup-v3.16/20140515213244/

Thanks pulling into omap-for-v3.16/prcm.

Tony
 
> ----------------------------------------------------------------
> Tero Kristo (10):
>       ARM: OMAP3: CM: remove a few OMAP34XX_CM_REGADDR defines
>       ARM: OMAP2+: prcm: add omap_test_timeout to prcm-common.h
>       ARM: OMAP2/3: CM: remove some external dependencies
>       ARM: OMAP4: CM: use cm_base* in register address calculations
>       ARM: OMAP2+: PRCM: cleanup some header includes
>       ARM: OMAP2+: PRM: remove unnecessary cpu_is_XXX calls from prm_init / exit
>       ARM: OMAP3/4: PRM: provide io chain reconfig function through irq setup
>       ARM: OMAP3/OMAP4: PRM: add prm_features flags and add IO wakeup under it
>       ARM: OMAP3/4: PRM: add support of late_init call to prm_ll_ops
>       ARM: OMAP4: PRCM: remove references to cm-regbits-44xx.h from PRCM core files
> 
>  arch/arm/mach-omap2/clockdomain.h                  |  3 ++-
>  arch/arm/mach-omap2/cm2xxx.c                       | 15 ++-----------
>  arch/arm/mach-omap2/cm33xx.h                       |  3 ---
>  arch/arm/mach-omap2/cm3xxx.c                       | 25 ++++++++--------------
>  arch/arm/mach-omap2/cm3xxx.h                       |  5 ++---
>  arch/arm/mach-omap2/cm44xx.c                       | 11 ++++------
>  arch/arm/mach-omap2/cm_common.c                    |  2 +-
>  arch/arm/mach-omap2/cminst44xx.c                   | 10 ++++++---
>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  1 +
>  arch/arm/mach-omap2/powerdomain-common.c           |  1 -
>  arch/arm/mach-omap2/powerdomain.c                  |  1 +
>  arch/arm/mach-omap2/powerdomain.h                  |  3 +--
>  arch/arm/mach-omap2/prcm-common.h                  | 24 +++++++++++++++++++++
>  arch/arm/mach-omap2/prcm_mpu44xx.h                 |  1 -
>  arch/arm/mach-omap2/prm.h                          | 10 +++++++++
>  arch/arm/mach-omap2/prm2xxx.c                      | 13 +----------
>  arch/arm/mach-omap2/prm2xxx_3xxx.c                 |  1 -
>  arch/arm/mach-omap2/prm33xx.c                      |  1 -
>  arch/arm/mach-omap2/prm3xxx.c                      | 20 ++++++++---------
>  arch/arm/mach-omap2/prm44xx.c                      | 18 +++++++---------
>  arch/arm/mach-omap2/prm_common.c                   | 17 +++++++++------
>  21 files changed, 93 insertions(+), 92 deletions(-)
