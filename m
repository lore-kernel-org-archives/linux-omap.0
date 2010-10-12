From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap3: various code improvements for IGEP v2 board.
Date: Tue, 12 Oct 2010 16:06:23 +0300
Message-ID: <20101012130623.GP2965@legolas.emea.dhcp.ti.com>
References: <1286878570-1973-1-git-send-email-eballetbo@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60512 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757219Ab0JLNGd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Oct 2010 09:06:33 -0400
Content-Disposition: inline
In-Reply-To: <1286878570-1973-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Oct 12, 2010 at 05:16:10AM -0500, Enric Balletbo i Serra wrote:
>The comments of this post also apply to IGEP v2 board (thanks Laurent)
>
>  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36402.html
>
>Changes are:
>
>  - Set onenand_setup to NULL instead of adding a no-op function.
>  - On igep2_flash_init() function:
>    - Use 'for' loop instead 'while' loop.
>    - No need to initialize ret to 0, we're assigning it right after.
>    - No need to check for onenandcs < GPMC_CS_NUM here, it will always be true.
>  - omap_board_config_size is implicitly initialized to 0 in
>    plat-omap/common.c, get_config() won't dereference omap_board_config,
>    so we can remove the empty igep2_config array.

you should probably split this patch in a series.

>Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>---
> arch/arm/mach-omap2/board-igep0020.c |   39 ++++++++++++---------------------
> 1 files changed, 14 insertions(+), 25 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
>index 152f757..ddcfd06 100644
>--- a/arch/arm/mach-omap2/board-igep0020.c
>+++ b/arch/arm/mach-omap2/board-igep0020.c
>@@ -136,16 +136,10 @@ static struct mtd_partition igep2_onenand_partitions[] = {
> 	},
> };
>
>-static int igep2_onenand_setup(void __iomem *onenand_base, int freq)
>-{
>-       /* nothing is required to be setup for onenand as of now */
>-       return 0;
>-}
>-
> static struct omap_onenand_platform_data igep2_onenand_data = {
> 	.parts = igep2_onenand_partitions,
> 	.nr_parts = ARRAY_SIZE(igep2_onenand_partitions),
>-	.onenand_setup = igep2_onenand_setup,
>+	.onenand_setup = NULL,

static variable. Just remove the line ;-)

-- 
balbi
