From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/12] OMAP: clock/SRAM: patches for 2.6.38, part one
Date: Tue, 14 Dec 2010 12:19:02 +0530
Message-ID: <c4bb5d1427408e750a004cfc352c4a54@mail.gmail.com>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:54003 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753839Ab0LNGtG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 01:49:06 -0500
Received: by pvc21 with SMTP id 21so62167pvc.31
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 22:49:05 -0800 (PST)
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Tuesday, December 14, 2010 12:05 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH 00/12] OMAP: clock/SRAM: patches for 2.6.38, part one
>
I guess you wanted to say "SCRM" instead of SRAM in subject line

> This clock/SRAM patch series, based on v2.6.37-rc5:
>
> - fixes some problems and missing data with OMAP4 clocks,
>
> - adds SCRM IP block data (part of the OMAP4 PRCM collection of
modules),
>
> - cleans up the way that OMAP3 clock data CK_* and RATE_IN_* flags are
>   used,
>
> - adds some comments to the SRAM code,
>
> - prepares part of the OMAP1 clock code for a combined OMAP1 defconfig
>   (although more work is left to be done before a combined OMAP1
>    defconfig is safe, from a clock framework perspective),
>
> - and fixes a few minor bugs in the OMAP2/3 clock code.
>
>
> Boot-tested on OSK 5912, N800, OMAP35xx Beagle, and OMAP37xx Beagle-XM.
>
> This series is also available from git://git.pwsan.com/linux-2.6
> branch 'clk_a_2.6.38'.
>
>
> - Paul
>
> ---
>
> clk_a_2.6.38
>    text	   data	    bss	    dec	    hex	filename
> 5733349	 471616	5608768	11813733	 b44365	vmlinux.orig
> 5734273	 473728	5608768	11816769	 b44f41
> 	vmlinux.patched
>
>
> Benoit Cousson (3):
>       OMAP4: clock data: Add control for pad_clks_ck and slimbus_clk
>       OMAP3: clock data: Add "wkup_clkdm" in sr1_fck and sr2_fck
>       OMAP4: PRCM: Add SCRM header file
>
> Janusz Krzysztofik (1):
>       OMAP1: clock_data: use runtime cpu / machine checks
>
> Jonathan Bergsagel (1):
>       OMAP4: clock data: Add missing fields in iva_hsd_byp_clk_mux_ck
>
> Paul Walmsley (4):
>       OMAP2xxx clock: fix dss2_fck recalc to use clksel
>       OMAP3: clock: clarify usage of struct clksel_rate.flags and struct
> omap_clk.cpu
>       OMAP3: clock: fix incorrect rate display when switching MPU rate
at
> boot
>       OMAP2/3: SRAM: add comment about crashes during a TLB miss
>
> Rajendra Nayak (2):
>       OMAP4: clock data: Add SCRM auxiliary clock nodes
>       OMAP4: clock data: Export control to enable/disable CORE/PER M3
> clocks
>
> Thara Gopinath (1):
>       OMAP4: clock data: Add missing DPLL x2 clock nodes
>
>
>  arch/arm/mach-omap1/clock_data.c              |   17 -
>  arch/arm/mach-omap2/clock2420_data.c          |    2
>  arch/arm/mach-omap2/clock2430_data.c          |    2
>  arch/arm/mach-omap2/clock3xxx.c               |    2
>  arch/arm/mach-omap2/clock3xxx_data.c          |  218 ++++-----
>  arch/arm/mach-omap2/clock44xx_data.c          |  620
++++++++++++++++++--
> -----
>  arch/arm/mach-omap2/scrm44xx.h                |  176 +++++++
>  arch/arm/mach-omap2/sram242x.S                |    6
>  arch/arm/mach-omap2/sram243x.S                |    6
>  arch/arm/mach-omap2/sram34xx.S                |    6
>  arch/arm/plat-omap/include/plat/clkdev_omap.h |   20 -
>  arch/arm/plat-omap/include/plat/clock.h       |   11
>  12 files changed, 772 insertions(+), 314 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/scrm44xx.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
