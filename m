From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: DSS hwmod/reset fixes for 3.2
Date: Fri, 4 Nov 2011 17:35:50 -0700
Message-ID: <20111105003550.GM31337@atomide.com>
References: <alpine.DEB.2.00.1110061806150.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52708 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab1KEAfx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 20:35:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1110061806150.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Paul Walmsley <paul@pwsan.com> [111006 16:33]:
> Hi Tony,
> 
> The following changes since commit be73246058737beec52ae232bcab7776332a9e06:
> 
>   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 hwmod_dss_fixes_3.2

Looks like you should take a look at the merge conflicts with
this one, maybe rebase it on 994c0e992522c123298b4a91b72f5e67ba2d1123.

Regards,

Tony
 
> Archit Taneja (1):
>       ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is enabled in bootloader
> 
> Tomi Valkeinen (9):
>       ARM: OMAP2xxx: HWMOD: Fix DSS reset
>       ARM: OMAP2xxx: HWMOD: fix DSS clock data
>       ARM: OMAP3: HWMOD: Fix DSS reset
>       ARM: OMAP3: HWMOD: fix DSS clock data
>       ARM: OMAP4: HWMOD: remove extra clocks
>       ARM: OMAP4: HWMOD: Add HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core
>       ARM: OMAP4: HWMOD: fix DSS clock data
>       ARM: OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
>       ARM: OMAP: HWMOD: Unify DSS resets for OMAPs
> 
>  arch/arm/mach-omap2/Makefile                       |    5 +-
>  arch/arm/mach-omap2/display.c                      |  160 ++++++++++++++++++++
>  arch/arm/mach-omap2/display.h                      |   29 ++++
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   17 ++-
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   17 ++-
>  .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   37 ++++-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   24 ++--
>  arch/arm/mach-omap2/omap_hwmod_common_data.c       |    4 +
>  arch/arm/mach-omap2/omap_hwmod_common_data.h       |    4 +
>  arch/arm/plat-omap/include/plat/common.h           |    3 +
>  include/video/omapdss.h                            |    7 -
>  12 files changed, 277 insertions(+), 35 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/display.h
