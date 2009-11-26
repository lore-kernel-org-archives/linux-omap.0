From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH 0/8] Series short description
Date: Thu, 26 Nov 2009 12:14:51 +0530
Message-ID: <0d7101ca6e63$f5b88a10$LocalHost@wipultra793>
References: <20091126001646.1546.34352.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49026 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758516AbZKZGo6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Nov 2009 01:44:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Tony Lindgren" <tony@atomide.com>
To: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-omap@vger.kernel.org>
Sent: Thursday, November 26, 2009 5:48 AM
Subject: [PATCH 0/8] Series short description


> Hi all,
>
> Here are some omap mux updates for review. These
> are intended for the v2.6.33 merge window.
>
> Initially this series changes the omap34xx mux
> code, I'm planning on adding 3630, 2420, and 2430
> code later on.
>
> There are several reasons why we need better mux
> code:
>
> - We want to make the mux code more generic and this
>  will allow us to use the internal signal names and
>  gpio numbers instead of mux register offsets. The
>  internal signal names stay the same across omap
>  generations for some devices.
>
> - We need to map mux registers to GPIO registers for
>  dynamic muxing of the GPIO pins during off-idle.
>
> - We want to be able to override the bootloader mux
>  values for the modded boards, such as the Beagle.
>
> - We want to have the mux signals and balls available
>  under debugfs for debugging new drivers.

Does it also detect conflicts when two drivers try
to step on each other and overwrite the mux settings of
other. SPI and EHCI was one of the problems I faced.


>
> Some of these might eventually work for other archs
> too, so let me know if you have any comments on that.
>
> Regards,
>
> Tony
>
> Here are some instructions on how to use:
>
> To see what got muxed during init, edit the kernel
> CMDLINE to have debug in it:
>
> # dmesg | grep mux
> mux: Setting signal i2c2_scl.i2c2_scl 0x0100 -> 0x0100
> mux: Setting signal i2c2_sda.i2c2_sda 0x0100 -> 0x0100
> mux: Setting signal i2c3_scl.i2c3_scl 0x0100 -> 0x0100
> mux: Setting signal i2c3_sda.i2c3_sda 0x0100 -> 0x0100
> mux: Setting signal gpmc_ncs3.gpio54 0x410c -> 0x010c
> ...
>
> Looks like the gpmc_ncs3.gpio54 muxing in the kernel
> has a bug where we should have OMAP_WAKEUP_EN set for
> board_smc91x_init for board-rx51? :)
>
> To override bootloader mux settings, edit the kernel CMDLINE:
>
> omap_mux=i2c2_scl.i2c2_scl=0x100,i2c2_sda.i2c2_sda=0x100
>
> Note that this only changes the bootloader settings, not
> what might be muxed from the board-*.c files.
>
> With CONFIG_DEBUG_FS set:
>
> # mount -t sysfs sys /sys
> # mount -t debugfs debug /sys/kernel/debug
>
> # ls /sys/kernel/debug/omap_mux/i2c
> i2c2_scl  i2c2_sda  i2c3_scl  i2c3_sda  i2c4_scl  i2c4_sda
>
> # cat /sys/kernel/debug/omap_mux/i2c2_scl
> name: i2c2_scl.i2c2_scl (0x480021be/0x18e = 0x0100), b af15, t NA
> mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
> signals: i2c2_scl | NA | NA | NA | gpio_168 | NA | NA | safe_mode
>
> ---
>
> Mike Rapoport (1):
>      omap2: mux: intoduce omap_mux_{read,write}
>
> Tony Lindgren (7):
>      omap: mux: Add new style pin multiplexing code for omap3
>      omap: mux: Add new style pin multiplexing data for 34xx
>      omap: mux: Add new style init functions to omap3 board-*.c files
>      omap: mux: Add debugfs support for new mux code
>      omap: Split i2c platform init for mach-omap1 and mach-omap2
>      omap: mux: Replace omap_cfg_reg() with new style signal or gpio 
> functions
>      omap: mux: Remove old mux code for 34xx
>
>
> arch/arm/mach-omap2/Makefile                 |    4
> arch/arm/mach-omap2/board-3430sdp.c          |   13
> arch/arm/mach-omap2/board-3630sdp.c          |    3
> arch/arm/mach-omap2/board-am3517evm.c        |   11
> arch/arm/mach-omap2/board-cm-t35.c           |   13
> arch/arm/mach-omap2/board-igep0020.c         |   11
> arch/arm/mach-omap2/board-ldp.c              |   10
> arch/arm/mach-omap2/board-omap3beagle.c      |   21
> arch/arm/mach-omap2/board-omap3evm.c         |   21
> arch/arm/mach-omap2/board-omap3pandora.c     |   15
> arch/arm/mach-omap2/board-overo.c            |   14
> arch/arm/mach-omap2/board-rx51-peripherals.c |    7
> arch/arm/mach-omap2/board-rx51.c             |   16
> arch/arm/mach-omap2/board-zoom2.c            |   11
> arch/arm/mach-omap2/devices.c                |   62 +
> arch/arm/mach-omap2/mux.c                    |  961 ++++++++++------
> arch/arm/mach-omap2/mux.h                    |  150 +++
> arch/arm/mach-omap2/mux34xx.c                | 1558 
> ++++++++++++++++++++++++++
> arch/arm/mach-omap2/mux34xx.h                |  351 ++++++
> arch/arm/mach-omap2/usb-ehci.c               |  122 +-
> arch/arm/plat-omap/i2c.c                     |   24
> arch/arm/plat-omap/include/plat/common.h     |    1
> arch/arm/plat-omap/include/plat/mux.h        |  222 ----
> arch/arm/plat-omap/mux.c                     |    8
> 24 files changed, 2932 insertions(+), 697 deletions(-)
> create mode 100644 arch/arm/mach-omap2/mux.h
> create mode 100644 arch/arm/mach-omap2/mux34xx.c
> create mode 100644 arch/arm/mach-omap2/mux34xx.h
>
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

