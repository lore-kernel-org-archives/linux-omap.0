From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC][PATCH 0/5] Convert GPMC to driver
Date: Fri, 23 Mar 2012 10:10:35 +0100
Message-ID: <4F6C3E0B.9090004@ti.com>
References: <1332484567-21710-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43189 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757886Ab2CWJKk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Mar 2012 05:10:40 -0400
In-Reply-To: <1332484567-21710-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Mohammed,

On 3/23/2012 7:36 AM, Afzal Mohammed wrote:
> Hi,
>
> Convert GPCM code to be a driver. Existing GPMC
> NAND platform handling has been modified to work
> with the new GPMC driver (patches 2&  3). Patch 5
> is to test the driver in OMAP3EVM.

Hehe, cool, thanks for that series,
Benoit

>
> Once all the users has been converted to use this
> driver, would be converted to MFD type.
>
> TODO:
> 1. Let OMAP NAND driver deal with GPMC NAND block
> 2. Remove struct gpmc * stored as static
> 3. Convert all peripherals to use GPMC driver
> 4. Devise method to handle OneNAND cleanly
> 5. Handle acquiring CS# cases
> 6. Convert to MFD driver
>
> Regards
> Afzal
>
> Afzal Mohammed (5):
>    ARM: OMAP2+: gpmc: driver conversion
>    ARM: OMAP2+: nand: create platform data structure
>    ARM: OMAP2+: gpmc-nand: populate gpmc configs
>    mtd: nand: omap2: obtain memory from resource
>    OMAP3EVM: Test gpmc-nand
>
>   arch/arm/mach-omap2/board-devkit8000.c     |    6 +-
>   arch/arm/mach-omap2/board-flash.c          |   63 +-
>   arch/arm/mach-omap2/board-flash.h          |   13 +-
>   arch/arm/mach-omap2/board-ldp.c            |    4 +-
>   arch/arm/mach-omap2/board-omap3beagle.c    |    6 +-
>   arch/arm/mach-omap2/board-omap3evm.c       |   82 +++
>   arch/arm/mach-omap2/board-omap3touchbook.c |    6 +-
>   arch/arm/mach-omap2/board-overo.c          |    5 +-
>   arch/arm/mach-omap2/board-zoom.c           |    5 +-
>   arch/arm/mach-omap2/common-board-devices.c |   46 --
>   arch/arm/mach-omap2/common-board-devices.h |    1 -
>   arch/arm/mach-omap2/gpmc-nand.c            |   88 +--
>   arch/arm/mach-omap2/gpmc.c                 | 1083 ++++++++++++++++------------
>   arch/arm/plat-omap/include/plat/gpmc.h     |   34 +-
>   arch/arm/plat-omap/include/plat/nand.h     |    9 +-
>   drivers/mtd/nand/omap2.c                   |   19 +-
>   16 files changed, 869 insertions(+), 601 deletions(-)
>

