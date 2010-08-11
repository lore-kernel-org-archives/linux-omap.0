From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 0/6] Introduce support for TI816X processor series
Date: Wed, 11 Aug 2010 11:08:52 -0700
Message-ID: <87hbj12f9n.fsf@deeprootsystems.com>
References: <1281546621-11348-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52332 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab0HKSIz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 14:08:55 -0400
Received: by qyk7 with SMTP id 7so4968697qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 11:08:55 -0700 (PDT)
In-Reply-To: <1281546621-11348-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Wed, 11 Aug 2010 22:40:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch series adds support for TI816X processor series. First device in this
> series is DM8168 and details can be found at:
>
> http://www.ti.com/ww/en/dsp/davinci-netra/index.shtml
>
> This device is architecturally closer to the OMAP devices. Hence, these patches
> are being submitted on linux-omap.

Is there a public TRM for this part available?

Kevin

> These patches are tested on OMAP3 EVM with multi-omap build.
>
> Note that, additional patches consisting of TI816X specific clock data and
> DMTIMER changes, are required to enable successful booting on TI816X EVM. These
> patches will follow shortly.
>
> Hemant Pedanekar (6):
>   TI816X: Create architecture macros and config entries
>   TI816X: Update common omap platform files
>   TI816X: Update common OMAP machine specific sources
>   TI816X: Create board support for TI816X_EVM
>   TI816X: Enable Build for TI816X EVM
>   TI816X: Add low level debug support
>
>  arch/arm/Makefile                              |    1 +
>  arch/arm/mach-omap2/Kconfig                    |   14 +++
>  arch/arm/mach-omap2/Makefile                   |    2 +
>  arch/arm/mach-omap2/board-ti8168evm.c          |   58 +++++++++++
>  arch/arm/mach-omap2/clockdomain.c              |   20 ++--
>  arch/arm/mach-omap2/id.c                       |   25 +++++
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   12 ++
>  arch/arm/mach-omap2/include/mach/entry-macro.S |   44 ++++++++-
>  arch/arm/mach-omap2/io.c                       |   21 ++++-
>  arch/arm/mach-omap2/irq.c                      |    4 +
>  arch/arm/mach-omap2/serial.c                   |    3 +-
>  arch/arm/plat-omap/Kconfig                     |    2 +-
>  arch/arm/plat-omap/common.c                    |   20 ++++
>  arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
>  arch/arm/plat-omap/include/plat/clock.h        |    1 +
>  arch/arm/plat-omap/include/plat/common.h       |    1 +
>  arch/arm/plat-omap/include/plat/control.h      |   23 ++++
>  arch/arm/plat-omap/include/plat/cpu.h          |   29 +++++-
>  arch/arm/plat-omap/include/plat/hardware.h     |    1 +
>  arch/arm/plat-omap/include/plat/io.h           |   20 ++++
>  arch/arm/plat-omap/include/plat/irqs-ti816x.h  |  128 ++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/irqs.h         |    3 +
>  arch/arm/plat-omap/include/plat/multi.h        |    8 ++
>  arch/arm/plat-omap/include/plat/serial.h       |    8 ++
>  arch/arm/plat-omap/include/plat/ti816x.h       |   40 ++++++++
>  arch/arm/plat-omap/include/plat/uncompress.h   |    7 ++
>  arch/arm/plat-omap/io.c                        |    7 ++
>  27 files changed, 486 insertions(+), 17 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-ti8168evm.c
>  create mode 100644 arch/arm/plat-omap/include/plat/irqs-ti816x.h
>  create mode 100644 arch/arm/plat-omap/include/plat/ti816x.h
