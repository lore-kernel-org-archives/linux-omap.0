From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/3] omap platform and board related late patches
 for v3.7 merge window
Date: Mon, 24 Sep 2012 17:39:53 -0700
Message-ID: <20120925003953.GQ28835@atomide.com>
References: <pull-1348521952-285145>
 <E1TGGAI-0000D1-T0@merlin.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62798 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751094Ab2IYAj5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 20:39:57 -0400
Content-Disposition: inline
In-Reply-To: <E1TGGAI-0000D1-T0@merlin.infradead.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120924 14:30]:
> The following changes since commit 0e70156de4c8465bfb8cb45cdc1bbc2fa474ce14:
> 
>   ARM: OMAP2+: Make omap4-keypad.h local (2012-09-20 15:04:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-board-late-v2-for-v3.7
> 
> for you to fetch changes up to ead53717d9ab28c942b9adf66f8c02442dbfbc8a:
> 
>   arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX (2012-09-24 10:32:39 -0700)
> 
> ----------------------------------------------------------------
> These board and platform related patches have been posted
> quite a while ago but have somehow fallen though the cracks
> as most of the focus has been making things to work with
> device tree. As the first patch depends on sparse IRQ
> related removal of irqs.h and related header moves, these
> are based on omap-cleanup-local-headers-for-v3.7 tag.

Let's scrap this pull request, Russell noted that Yegor's patch
breaks sa1111.

Regards,

Tony
 
> ----------------------------------------------------------------
> AnilKumar Ch (1):
>       ARM: OMAP2+: serial: Change MAX_HSUART_PORTS to 6
> 
> Peter Ujfalusi (1):
>       ARM: OMAP4: twl-common: Support for additional devices on i2c1 bus
> 
> Yegor Yefremov (1):
>       arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX


 
>  arch/arm/Kconfig                              |    5 ++--
>  arch/arm/mach-omap2/board-4430sdp.c           |   12 ++++++--
>  arch/arm/mach-omap2/board-omap4panda.c        |   12 ++++++--
>  arch/arm/mach-omap2/twl-common.c              |   37 ++++++++-----------------
>  arch/arm/mach-omap2/twl-common.h              |    3 +-
>  arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
>  6 files changed, 37 insertions(+), 34 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
