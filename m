From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] make omap24xx boot in dt mode only, prepare omap3 to
 drop legacy booting for v3.14
Date: Tue, 10 Dec 2013 12:29:06 -0800
Message-ID: <20131210202906.GT13171@atomide.com>
References: <pull-1386707155-223559>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:31633 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751030Ab3LJU3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 15:29:11 -0500
Content-Disposition: inline
In-Reply-To: <pull-1386707155-223559>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131210 12:27]:
> The following changes since commit f2e2c9d9b4087b74eb9e00d8dfac148354cb0b71:
> 
>   ARM: dts: Fix booting for secure omaps (2013-12-06 15:30:43 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap 

Sorry forgot to push the new tag, the link is:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/board-removal-safe
 
> for you to fetch changes up to adfe9361b236154215d4b0fc8b6d79995394b15c:
> 
>   ARM: dts: Add basic devices on am3517-evm (2013-12-08 14:15:46 -0800)
> 
> ----------------------------------------------------------------
> Make omap2420 and 2430 boot in device tree only mode and prepare things
> for removing omap3 legacy booting support.
> 
> We can make omap2420 and 2430 boot in device tree only mode by keeping
> board-n8x0.c around until Menelaus has device tree and regulator support
> so devices still work. For the omap2430-sdp we have omap2430-sdp.dts,
> and there's also a minimal support for H4 in omap2420-h4.dts.
> 
> For omap3, let's not drop the legacy platform booting quite yet so
> people have a little time to update their booting system.
> 
> With the fixes going into v3.13, thing should behave pretty much the
> same way for legacy booting and device tree based booting for omap3.
> 
> So people using omap3 based boards, please update your systems to
> boot in device tree mode as omap3 is the last SoC in mach-omap2
> that boots in the legacy mode.
> 
> ----------------------------------------------------------------
> Aaro Koskinen (1):
>       ARM: OMAP2+: dts: add n8x0 onenand
> 
> Tony Lindgren (20):
>       mfd: twl-core: Fix passing of platform data in the device tree case
>       Merge branch 'dt-regressions' into omap-for-v3.13/fixes-take4
>       ARM: dts: Add basic device tree support for omap2430 sdp
>       ARM: dts: Add basic Nokia N8X0 support
>       ARM: dts: Add basic support for omap3 LDP zoom1 labrador
>       Merge branch 'omap-for-v3.13/fixes-take4' into omap-for-v3.14/board-removal
>       Merge branch 'omap-for-v3.14/dt' into omap-for-v3.14/board-removal
>       ARM: OMAP2+: Add support for board specific auxdata quirks
>       ARM: OMAP2+: Add device tree compatible revision checks for n8x0
>       ARM: OMAP2+: Make n8x0 behave better with device tree based booting
>       ARM: OMAP2+: Add quirks support for n8x0
>       ARM: OMAP2+: Remove legacy booting support for n8x0
>       ARM: OMAP2+: Remove board file for H4
>       ARM: OMAP2+: Remove legacy board file for 2430sdp
>       ARM: OMAP2+: Remove legacy mux code for omap2
>       ARM: OMAP2+: Remove legacy hwmod entries for omap2
>       Merge branch 'omap-for-v3.14/board-removal' into omap-for-v3.14/omap3-board-removal
>       ARM: OMAP2+: Add support for legacy auxdata for twl
>       ARM: OMAP2+: Use pdata quirks for emac on am3517
>       ARM: dts: Add basic devices on am3517-evm
> 
>  arch/arm/boot/dts/Makefile                         |   5 +
>  arch/arm/boot/dts/am3517-evm.dts                   |  29 +
>  arch/arm/boot/dts/omap2420-n800.dts                |   8 +
>  arch/arm/boot/dts/omap2420-n810-wimax.dts          |   8 +
>  arch/arm/boot/dts/omap2420-n810.dts                |   8 +
>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |  99 +++
>  arch/arm/boot/dts/omap2430-sdp.dts                 |  49 ++
>  arch/arm/boot/dts/omap3-ldp.dts                    | 231 ++++++
>  arch/arm/mach-omap2/Kconfig                        |  13 -
>  arch/arm/mach-omap2/Makefile                       |   4 -
>  arch/arm/mach-omap2/board-2430sdp.c                | 273 -------
>  arch/arm/mach-omap2/board-h4.c                     | 365 ----------
>  arch/arm/mach-omap2/board-n8x0.c                   | 234 ++----
>  arch/arm/mach-omap2/common-board-devices.h         |   1 +
>  arch/arm/mach-omap2/common.h                       |   1 +
>  arch/arm/mach-omap2/msdi.c                         |  69 --
>  arch/arm/mach-omap2/mux.h                          |   2 -
>  arch/arm/mach-omap2/mux2420.c                      | 690 ------------------
>  arch/arm/mach-omap2/mux2420.h                      | 282 --------
>  arch/arm/mach-omap2/mux2430.c                      | 793 ---------------------
>  arch/arm/mach-omap2/mux2430.h                      | 370 ----------
>  arch/arm/mach-omap2/omap_device.c                  |   2 +
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c         | 137 ----
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c         | 266 -------
>  .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c | 165 +----
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  72 +-
>  arch/arm/mach-omap2/omap_hwmod_common_data.h       |   5 -
>  arch/arm/mach-omap2/pdata-quirks.c                 | 107 ++-
>  drivers/mfd/twl-core.c                             |  15 +-
>  29 files changed, 609 insertions(+), 3694 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap2420-n800.dts
>  create mode 100644 arch/arm/boot/dts/omap2420-n810-wimax.dts
>  create mode 100644 arch/arm/boot/dts/omap2420-n810.dts
>  create mode 100644 arch/arm/boot/dts/omap2420-n8x0-common.dtsi
>  create mode 100644 arch/arm/boot/dts/omap2430-sdp.dts
>  create mode 100644 arch/arm/boot/dts/omap3-ldp.dts
>  delete mode 100644 arch/arm/mach-omap2/board-2430sdp.c
>  delete mode 100644 arch/arm/mach-omap2/board-h4.c
>  delete mode 100644 arch/arm/mach-omap2/mux2420.c
>  delete mode 100644 arch/arm/mach-omap2/mux2420.h
>  delete mode 100644 arch/arm/mach-omap2/mux2430.c
>  delete mode 100644 arch/arm/mach-omap2/mux2430.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
