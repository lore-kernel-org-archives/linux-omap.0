From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 0/4] ARM: OMAP2+: am33xx: Add clocktree and hwmod data
Date: Thu, 14 Jun 2012 15:12:45 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA50AF1@DBDE01.ent.ti.com>
References: <1338285402-11306-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48488 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866Ab2FNPMy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 11:12:54 -0400
In-Reply-To: <1338285402-11306-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 29, 2012 at 15:26:38, Hiremath, Vaibhav wrote:
> This patch adds complete clockctree and hwmod data for the
> AM33XX family of devices.
> 
> This patch-series is cleaned up further from Paul's cleanup
> activity on AM33xx clocktree, where all leaf nodes have been
> removed and now modules enable/disable is controlled only
> using hwmod framework interface.
> 
> There are certain modules, like clkdiv32k, debugss, etc..., for
> which we still doesn't have hwmod_data present, so in order to
> disable these modules during boot time, we still have to maintain
> clk node for them. Comment has been added to highlight this, and
> in the future we will cleanup this.
> As far as, CLKDIV32K module, in reality is not module but still
> we have MODULEMODE to control it, so we may have to keep this node
> alone in the clocktree.
> 
> This patch is created on top of recently submitted patches
> (accepted on the list) for am33xx voltage/powerdomain/clockcomain
> patch-series -
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69023.html
> 
> All the patches are also available at
> https://github.com/hvaibhav/am335x-linux   am335x-upstream-staging
> 
> This patch has been boot tested on BeagleBone platform.
> 
> History:
> ========
> ClockTree: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67095.html
> Hwmod: http://www.spinics.net/lists/linux-omap/msg69189.html
> 
> Changes from V1:
> 	- Removed all leaf nodes from clocktree, and migrated
> 	  hwmod data to use parent clock of module's funtional clock
> 	  as main_clk.
> 	- Rebased patches against Kevin's omap_hwmod cleanup patch-series,
> 	  where, cpu_is_xxx is no longer needed and platform specific
> 	  api's will be registered during init call itself.
> 	-
> 
> Paul Walmsley (1):
>   ARM: OMAP3+: clock: Move common clksel_rate & clock data to common
>     file
> 
> Vaibhav Hiremath (3):
>   ARM: OMAP2+: hwmod: Hook-up am33xx support in omap_hwmod framework
>   ARM: OMAP3+: clock33xx: Add AM33XX clock tree data

Kevin and Paul,

Leaving HWMOD data patch aside, both the above patches should be considered 
for acceptance, can you please review the same and if there are no review 
comments, can it be merged?

Thanks,
Vaibhav

>   ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
> 
>  arch/arm/mach-omap2/Makefile                  |    2 +
>  arch/arm/mach-omap2/clock.h                   |   14 +
>  arch/arm/mach-omap2/clock33xx_data.c          | 1105 ++++++++
>  arch/arm/mach-omap2/clock3xxx_data.c          |   20 +-
>  arch/arm/mach-omap2/clock44xx_data.c          |   72 -
>  arch/arm/mach-omap2/clock_common_data.c       |   77 +
>  arch/arm/mach-omap2/io.c                      |    4 +
>  arch/arm/mach-omap2/omap_hwmod.c              |  180 ++
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c    | 3368 +++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
>  11 files changed, 4756 insertions(+), 88 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/clock33xx_data.c
>  create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> 
> 

