From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot in
 DT only mode
Date: Fri, 29 Nov 2013 20:12:11 +0100
Message-ID: <CABxcv==NQpKN4evq3ufgo7EGeLuXphgRjz3WXHeBsnKX5qMvHg@mail.gmail.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:43833 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab3K2TMN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 14:12:13 -0500
Received: by mail-we0-f171.google.com with SMTP id q58so9590214wes.2
        for <linux-omap@vger.kernel.org>; Fri, 29 Nov 2013 11:12:12 -0800 (PST)
In-Reply-To: <1385424867-27243-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

On Tue, Nov 26, 2013 at 1:14 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> We can finally make mach-omap2 to boot in device tree only mode for v3.14.
>
> By doing that, we can get rid of about 20000 lines of legacy code for v3.14
> that's no longer needed with device tree :) And that's not counting the
> additional removal of the code that comes with the pending patches to
> move clocks to drivers/clk.
>
> Looks like we still have some legacy boards that don't have a .dts file,
> so if you're using one, please post the .dts file. I've posted some quick
> instructions in the first patch of this series for bringing up omaps with
> device tree.
>
> For most omap2+ boards that are not yet supported with device tree just
> the .dts file is needed. Some boards also may need additional entries to
> pdata-quirks.c. If there are more complicated issues, please let me know
> so we can sort out those issues ASAP.
>
> I don't have all omap boards so I have not been able to do a .dts file
> for those. Some help would be appreciated there if you are using a
> board with no .dts file posted yet. I can naturally help too where
> possible so we get the devices working with device tree as needed :)
>
> These patches need v3.13-rc1 and some of the following patches
> depending on your board:
>
> [PATCH 0/8] Various omap device tree usability fixes for v3.13 merge window
> [PATCH 00/11] Make omap24xx booting device tree based for v3.14 merge window
> [PATCH 0/3] Yet more fixes for booting omaps with device tree
> [PATCH 0/5] Prepare making omap3 device tree only and convert LDP
>
> I've also pushed all the patches into a temporary testing branch:
>
> omap-for-v3.14/tmp-testing-unstable-not-immutable
>
> Regards,
>
> Tony
>

That's great!

I just tested your branch on my DM3730 IGEPv2 board and everything
works correctly.

Also, I noticed that there are some remaining code that is unused now
that the board files are gone and can be removed.

I'll send now as a separate series but the diffstat is

 arch/arm/mach-omap2/Makefile        |   9 -----
 arch/arm/mach-omap2/board-flash.c   | 245
----------------------------------------------------------------------------------------------------------------------------
 arch/arm/mach-omap2/board-flash.h   |  62 --------------------------------
 arch/arm/mach-omap2/gpmc-smc91x.c   | 186
----------------------------------------------------------------------------------------------
 arch/arm/mach-omap2/gpmc-smc91x.h   |  42 ----------------------
 arch/arm/mach-omap2/gpmc-smsc911x.c | 100
---------------------------------------------------
 arch/arm/mach-omap2/gpmc-smsc911x.h |  35 ------------------
 arch/arm/mach-omap2/gpmc.c          |   1 -
 8 files changed, 680 deletions(-)

Best regards,
Javier

>
> Tony Lindgren (12):
>   ARM: OMAP2+: Remove legacy omap3 board-*.c files and make mach-omap2
>     DT only for booting
>   ARM: OMAP2+: Remove legacy serial.c
>   ARM: OMAP2+: Remove legacy hsmmc.c
>   ARM: OMAP2+: Remove legacy i2c.c platform init code
>   ARM: OMAP2+: Remove legacy PM init
>   ARM: OMAP2+: Remove legacy twl4030 platform init code
>   ARM: OMAP2+: Remove legacy usb-host.c platform init code
>   ARM: OMAP2+: Remove legacy muxing for usb-tusb6010.c
>   ARM: OMAP2+: Remove legacy usb-musb.c platform init code
>   ARM: OMAP2+: Remove legacy hwmod mux code
>   ARM: OMAP2+: Remove legacy mux code
>   ARM: OMAP2+: Remove legacy data from hwmod for omap3
>
>  arch/arm/mach-omap1/i2c.c                          |   83 +
>  arch/arm/mach-omap2/Kconfig                        |  112 --
>  arch/arm/mach-omap2/Makefile                       |   35 +-
>  arch/arm/mach-omap2/board-3430sdp.c                |  633 ------
>  arch/arm/mach-omap2/board-am3517crane.c            |  150 --
>  arch/arm/mach-omap2/board-am3517evm.c              |  379 ----
>  arch/arm/mach-omap2/board-cm-t35.c                 |  771 --------
>  arch/arm/mach-omap2/board-cm-t3517.c               |  337 ----
>  arch/arm/mach-omap2/board-devkit8000.c             |  655 -------
>  arch/arm/mach-omap2/board-ldp.c                    |  425 ----
>  arch/arm/mach-omap2/board-omap3beagle.c            |  596 ------
>  arch/arm/mach-omap2/board-omap3logic.c             |  251 ---
>  arch/arm/mach-omap2/board-omap3pandora.c           |  630 ------
>  arch/arm/mach-omap2/board-omap3stalker.c           |  438 -----
>  arch/arm/mach-omap2/board-omap3touchbook.c         |  396 ----
>  arch/arm/mach-omap2/board-overo.c                  |  572 ------
>  arch/arm/mach-omap2/board-rx51-peripherals.c       | 1323 -------------
>  arch/arm/mach-omap2/board-rx51-video.c             |   67 -
>  arch/arm/mach-omap2/board-rx51.c                   |  142 --
>  arch/arm/mach-omap2/board-ti8168evm.c              |   62 -
>  arch/arm/mach-omap2/common-board-devices.h         |    2 -
>  arch/arm/mach-omap2/common.h                       |    9 -
>  arch/arm/mach-omap2/devices.c                      |    2 -
>  arch/arm/mach-omap2/dss-common.c                   |    1 -
>  arch/arm/mach-omap2/hsmmc.c                        |  518 -----
>  arch/arm/mach-omap2/i2c.c                          |   97 -
>  arch/arm/mach-omap2/io.c                           |    1 -
>  arch/arm/mach-omap2/msdi.c                         |    1 -
>  arch/arm/mach-omap2/mux.c                          | 1161 -----------
>  arch/arm/mach-omap2/mux.h                          |  355 ----
>  arch/arm/mach-omap2/mux34xx.c                      | 2061 --------------------
>  arch/arm/mach-omap2/mux34xx.h                      |  402 ----
>  arch/arm/mach-omap2/omap_hwmod.c                   |  160 +-
>  .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  134 +-
>  .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  201 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  833 +-------
>  arch/arm/mach-omap2/omap_twl.c                     |  314 ---
>  arch/arm/mach-omap2/pm.c                           |  161 +-
>  arch/arm/mach-omap2/serial.c                       |  335 ----
>  arch/arm/mach-omap2/twl-common.c                   |  570 ------
>  arch/arm/mach-omap2/twl-common.h                   |   66 -
>  arch/arm/mach-omap2/usb-host.c                     |  496 -----
>  arch/arm/mach-omap2/usb-musb.c                     |  114 --
>  arch/arm/mach-omap2/usb-tusb6010.c                 |   21 -
>  arch/arm/plat-omap/Makefile                        |    3 -
>  arch/arm/plat-omap/i2c.c                           |  116 --
>  46 files changed, 136 insertions(+), 16055 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/board-3430sdp.c
>  delete mode 100644 arch/arm/mach-omap2/board-am3517crane.c
>  delete mode 100644 arch/arm/mach-omap2/board-am3517evm.c
>  delete mode 100644 arch/arm/mach-omap2/board-cm-t35.c
>  delete mode 100644 arch/arm/mach-omap2/board-cm-t3517.c
>  delete mode 100644 arch/arm/mach-omap2/board-devkit8000.c
>  delete mode 100644 arch/arm/mach-omap2/board-ldp.c
>  delete mode 100644 arch/arm/mach-omap2/board-omap3beagle.c
>  delete mode 100644 arch/arm/mach-omap2/board-omap3logic.c
>  delete mode 100644 arch/arm/mach-omap2/board-omap3pandora.c
>  delete mode 100644 arch/arm/mach-omap2/board-omap3stalker.c
>  delete mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c
>  delete mode 100644 arch/arm/mach-omap2/board-overo.c
>  delete mode 100644 arch/arm/mach-omap2/board-rx51-peripherals.c
>  delete mode 100644 arch/arm/mach-omap2/board-rx51-video.c
>  delete mode 100644 arch/arm/mach-omap2/board-rx51.c
>  delete mode 100644 arch/arm/mach-omap2/board-ti8168evm.c
>  delete mode 100644 arch/arm/mach-omap2/hsmmc.c
>  delete mode 100644 arch/arm/mach-omap2/mux.c
>  delete mode 100644 arch/arm/mach-omap2/mux.h
>  delete mode 100644 arch/arm/mach-omap2/mux34xx.c
>  delete mode 100644 arch/arm/mach-omap2/mux34xx.h
>  delete mode 100644 arch/arm/mach-omap2/omap_twl.c
>  delete mode 100644 arch/arm/mach-omap2/serial.c
>  delete mode 100644 arch/arm/mach-omap2/twl-common.c
>  delete mode 100644 arch/arm/mach-omap2/twl-common.h
>  delete mode 100644 arch/arm/mach-omap2/usb-host.c
>  delete mode 100644 arch/arm/mach-omap2/usb-musb.c
>  delete mode 100644 arch/arm/plat-omap/i2c.c
>
> --
> 1.8.1.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
