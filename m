From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 0/4] Regulator: OMAP: Removing common code for
 TWL4030 from OMAP3-board-evms
Date: Fri, 14 May 2010 12:33:12 -0700
Message-ID: <20100514193312.GB3428@atomide.com>
References: <1267525723-3068-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50238 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758979Ab0ENTdS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 15:33:18 -0400
Content-Disposition: inline
In-Reply-To: <1267525723-3068-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

* Anuj Aggarwal <anuj.aggarwal@ti.com> [100302 02:25]:
> Sending version 3 of this patch-set after rebasing it against the for-next
> branch in the linux-omap tree. The previous series can be found at:
>   http://marc.info/?l=linux-omap&m=126328763822497&w=2
> 
> This patch set is created to clean up various OMAP3-board-evm files
> and remove common TWL4030 specific regulator suplies and init data
> structs. These structures are instead placed in a new generic file -
> twl4030-pmic.c - and are referenced from the OMAP3 board-evm
> files depending on the platform requirements. Regulator having specific
> supplies or init data structs are not changed in their respective
> board-evms.
> 
> uImage built and tested for OMAP3EVM; compile-tested for SDP3430 and all OMAP
> platforms (using omap3_defconfig).
> 
> Anuj Aggarwal (4):
>   Regulator: OMAP: Creating TWL4030 file having supplies & init data
>   Regulator: OMAP: Modifying Kconfig/Makefile to choose from available
>     PMICs
>   Regulator: OMAP: Kconfig modified to select TWL4030 for
>     OMAP3-platforms
>   Regulator: OMAP: Use common regulator supplies and init data structs
> 
>  arch/arm/mach-omap2/Kconfig                  |   20 +++
>  arch/arm/mach-omap2/Makefile                 |    1 +
>  arch/arm/mach-omap2/board-3430sdp.c          |  135 ++------------------
>  arch/arm/mach-omap2/board-cm-t35.c           |   47 +------
>  arch/arm/mach-omap2/board-igep0020.c         |   24 +---
>  arch/arm/mach-omap2/board-ldp.c              |   24 +---
>  arch/arm/mach-omap2/board-omap3beagle.c      |   47 +------
>  arch/arm/mach-omap2/board-omap3evm.c         |   47 +------
>  arch/arm/mach-omap2/board-omap3touchbook.c   |   47 +------
>  arch/arm/mach-omap2/board-overo.c            |   23 +---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |   71 +----------
>  arch/arm/mach-omap2/twl4030-pmic.c           |  175 ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/twl4030-pmic.h           |   34 +++++
>  13 files changed, 277 insertions(+), 418 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/twl4030-pmic.c
>  create mode 100644 arch/arm/mach-omap2/twl4030-pmic.h

Are these patches still relevant?

I'd like to see some acks on these..

Regards,

Tony 
