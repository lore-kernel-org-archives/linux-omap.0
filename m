From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 0/9] OMAP2/3 SDRC/clock: control CORE M2 divider, clean up SDRC
Date: Tue, 8 Jul 2008 10:07:39 +0530
Message-ID: <02aa01c8e0b4$5c09a450$68bf18ac@ent.ti.com>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33946 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbYGHEh5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jul 2008 00:37:57 -0400
In-Reply-To: <20080708025225.11646.55912.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Paul Walmsley' <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: 'Igor Stoppa' <igor.stoppa@nokia.com>

 

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Tuesday, July 08, 2008 8:25 AM
> To: linux-omap@vger.kernel.org
> Cc: Rajendra Nayak; Igor Stoppa
> Subject: [PATCH 0/9] OMAP2/3 SDRC/clock: control CORE M2 
> divider, clean up SDRC
> 
> This patch series has three main objectives:
> 
> - connect Rajendra Nayak's existing OMAP3 SRAM code for CORE DPLL M2
>   divider reprogramming to the OMAP3 clock tree;
> 
> - create a sane method to pass SDRAM timing parameters from board-*.c 
>   files into the SDRC, to allow optimal timing parameters to be set
>   for a given clock rate;
> 
> - clean up the existing OMAP2/3 SDRC code.
> 
> 
> A few notes:
> 
> - The M2 divider switch does not seem to work consistently on the
>   3430SDP I use to test.  In particular, the switch back to 
> M2=1 results
>   in a hung console.

SRAM being mapped as cacheable could be a possible reason for this.

> 
> - Four SDRC rates are currently defined for the two SDRAM chip
>   registers included in this patch set.  The 165MHz and 83MHz rates
>   are unusual and are intended to match the TI OPP rates set by the
>   u-boot installation on the local 3430SDP.  133MHz and 66MHz rates
>   are also present; per CDP 12.17, apparently these are used on Beagle
>   and OMAP3EVM - not sure if these rates should also be derated
>   slightly?
> 
> 
> The SDRAM timing parameter infrastructure is currently only used for
> OMAP3, but can be also extended to OMAP2 devices once information on
> the SDRAM parts used on those boards is available.
> 
> Thanks to Rajendra Nayak <rnayak@ti.com> and Igor
> Stoppa <igor.stoppa@nokia.com> for finding some of the SDRAM
> datasheets for this patch set.
> 
> Compile-tested for N800, 2430SDP, OMAP3430SDP, OMAP3EVM, OMAP3 Beagle.
> Runtime-tested on OMAP3430SDP ES2.
> 
> If you have the debugfs set_rate patch, you can test the M2 divider
> code on OMAP3430SDP via:
> 
>    cd /debug/clock/virt_26m_ck/osc_sys_ck/sys_ck/dpll3_ck/dpll3_m2_ck
> 
>    # Switch to M2 = 2 (assuming DPLL3 at 331MHz)
>    echo -n 165941176 > rate
> 
>    # Switch back to M2 = 1
>    echo -n 331882352 > rate
> 
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> ---
> 
> size:
>    text    data     bss     dec     hex filename
> 3404220  159104  108240 3671564  38060c vmlinux.3430sdp
> 3403080  159200  108208 3670488  3801d8 vmlinux.3430sdp.patched
> 
> diffstat:
>  arch/arm/mach-omap2/Makefile                       |    6 +
>  arch/arm/mach-omap2/board-2430sdp.c                |    2 
>  arch/arm/mach-omap2/board-3430sdp.c                |    4 
>  arch/arm/mach-omap2/board-apollon.c                |    2 
>  arch/arm/mach-omap2/board-generic.c                |    2 
>  arch/arm/mach-omap2/board-h4.c                     |    2 
>  arch/arm/mach-omap2/board-ldp.c                    |    2 
>  arch/arm/mach-omap2/board-n800.c                   |    2 
>  arch/arm/mach-omap2/board-omap2evm.c               |    2 
>  arch/arm/mach-omap2/board-omap3beagle.c            |    4 
>  arch/arm/mach-omap2/board-omap3evm.c               |    4 
>  arch/arm/mach-omap2/clock.c                        |    2 
>  arch/arm/mach-omap2/clock24xx.c                    |   25 +--
>  arch/arm/mach-omap2/clock34xx.c                    |   68 +++++++-
>  arch/arm/mach-omap2/clock34xx.h                    |    9 -
>  arch/arm/mach-omap2/gpmc.c                         |    2 
>  arch/arm/mach-omap2/io.c                           |    8 -
>  arch/arm/mach-omap2/memory.c                       |  179 
> --------------------
>  arch/arm/mach-omap2/memory.h                       |   43 -----
>  arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |   55 ++++++
>  .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   55 ++++++
>  arch/arm/mach-omap2/sdrc.c                         |   93 ++++++++++
>  arch/arm/mach-omap2/sdrc2xxx.c                     |  164 
> ++++++++++++++++++
>  arch/arm/mach-omap2/sram34xx.S                     |   84 +++------
>  arch/arm/plat-omap/common.c                        |    2 
>  arch/arm/plat-omap/sram.c                          |   63 ++-----
>  include/asm-arm/arch-omap/common.h                 |    2 
>  include/asm-arm/arch-omap/gpmc.h                   |    1 
>  include/asm-arm/arch-omap/io.h                     |    4 
>  include/asm-arm/arch-omap/sdrc.h                   |   64 ++++++-
>  include/asm-arm/arch-omap/sram.h                   |   25 +--
>  31 files changed, 597 insertions(+), 383 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/memory.c
>  delete mode 100644 arch/arm/mach-omap2/memory.h
>  create mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
>  create mode 100644 
> arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
>  create mode 100644 arch/arm/mach-omap2/sdrc.c
>  create mode 100644 arch/arm/mach-omap2/sdrc2xxx.c
> 
> 

