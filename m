From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] DSS fixes for v3.2-rc2
Date: Thu, 24 Nov 2011 16:06:54 +0000
Message-ID: <201111241606.54879.arnd@arndb.de>
References: <20111123235542.GL31337@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58964 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab1KXQG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Nov 2011 11:06:57 -0500
In-Reply-To: <20111123235542.GL31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Wednesday 23 November 2011, Tony Lindgren wrote:
> Hi Arnd,
> 
> This one has been separated out from the rest of the fixes.

Pulled into the fixes branch now. I'll send out the branch
after testing it on tomorrow's linux-next.

> If some of these need to go to stable, then Tomi should
> do the rebasing and send them to stable@vger.kernel.org
> as they don't apply cleanly on v3.1.

Ok. I've taken Tomi on Cc as a reminder for him, although I guess
you already discussed it with him.

Kiitoksia paljon,

	Arnd

> 
> The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:
>   Linus Torvalds (1):
>         Linux 3.2-rc2
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-dss
> 
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
> Tony Lindgren (1):
>       Merge branch 'hwmod_dss_fixes_3.2rc' of git://git.pwsan.com/linux-2.6 into fixes-dss
> 
>  arch/arm/mach-omap2/Makefile                       |    5 +-
>  arch/arm/mach-omap2/display.c                      |  159 ++++++++++++++++++++
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
>  12 files changed, 276 insertions(+), 35 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/display.h
> 

