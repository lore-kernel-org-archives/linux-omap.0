From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v4 0/4] Introduce support for TI816X processor series
Date: Fri, 14 Jan 2011 05:03:24 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A77D048@dbde02.ent.ti.com>
References: <1294677460-18071-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48081 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab1AMXdc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 18:33:32 -0500
In-Reply-To: <1294677460-18071-1-git-send-email-hemantp@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Pedanekar, Hemant wrote on Monday, January 10, 2011 10:08 PM:

> This patch set adds support for TI816X processor series. This series
> includes DM8168, C6A816x and AM389x devices.
> 
> The details can be found at following links:
> 
> http://focus.ti.com/general/docs/gencontent.tsp?contentId=77960
> http://www.ti.com/ww/en/dsp/davinci-netra/index.shtml
> 
> This series is architecturally closer to the OMAP devices.
> Hence, these patches
> are being submitted on linux-omap.
> 
> These patches are tested on OMAP3 EVM with multi-omap build.
> 
> Note that, additional patches consisting of TI816X specific hwmods, clock
> data and DMTIMER changes, are required to enable successful
> booting on TI816X EVM.
> These patches will follow shortly.
> 
> The TI816X support is added as part of OMAP3 variant. The approach taken is
> in accordance to the discussions in thread related to following post:
> http://www.spinics.net/lists/linux-omap/msg41505.html
> 
> In addition, TI816X specific customizations/optimizations are handled as a
> part of build configuration CONFIG_SOC_OMAPTI816X. Discussed here:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41927.html
> 
> Hemant Pedanekar (4):
>   TI816X: Update common omap platform files
>   TI816X: Update common OMAP machine specific sources
>   TI816X: Create board support and enable build for TI816X EVM
>   TI816X: Add low level debug support
> 
>  arch/arm/mach-omap2/Kconfig                    |   16 +++
>  arch/arm/mach-omap2/Makefile                   |    1 +
>  arch/arm/mach-omap2/board-ti8168evm.c          |   58 +++++++++++
>  arch/arm/mach-omap2/clock3xxx_data.c           |    5 +-
>  arch/arm/mach-omap2/common.c                   |   24 +++++
>  arch/arm/mach-omap2/control.h                  |   17 +++
>  arch/arm/mach-omap2/id.c                       |   33 ++++++-
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   12 ++
>  arch/arm/mach-omap2/include/mach/entry-macro.S |   13 +++
>  arch/arm/mach-omap2/io.c                       |   13 ++-
>  arch/arm/mach-omap2/irq.c                      |    5 +-
>  arch/arm/mach-omap2/serial.c                   |    8 +-
>  arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
>  arch/arm/plat-omap/include/plat/clock.h        |    1 +
>  arch/arm/plat-omap/include/plat/common.h       |    1 +
>  arch/arm/plat-omap/include/plat/cpu.h          |   22 ++++
>  arch/arm/plat-omap/include/plat/hardware.h     |    1 +
>  arch/arm/plat-omap/include/plat/irqs-ti816x.h  |  131
>  ++++++++++++++++++++++++ arch/arm/plat-omap/include/plat/irqs.h         | 
>  3 + arch/arm/plat-omap/include/plat/serial.h       |    8 ++
>  arch/arm/plat-omap/include/plat/ti816x.h       |   31 ++++++
>  arch/arm/plat-omap/include/plat/uncompress.h   |    7 ++
>  arch/arm/plat-omap/io.c                        |    5 +-
>  23 files changed, 406 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-ti8168evm.c
>  create mode 100644 arch/arm/plat-omap/include/plat/irqs-ti816x.h
>  create mode 100644 arch/arm/plat-omap/include/plat/ti816x.h

Tony,
Can you please provide the comments on v4 patches? Thanks.
-
Hemant

