From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] omap4: Fix multi-omap boot with reset un-used clocks
Date: Wed, 19 May 2010 15:01:08 -0500
Message-ID: <4BF44384.40901@ti.com>
References: <1274287087-4049-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38578 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755336Ab0ESUBK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 16:01:10 -0400
In-Reply-To: <1274287087-4049-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Shilimkar, Santosh had written, on 05/19/2010 11:38 AM, the following:
> This patch uses "ENABLE_ON_INIT" flag on the emif clock nodes
> to avoid the emif clk getting cut as part of reset un-used clock
> routine which prevents boot.
> 
> Since omap4 "omap2_clk_init()" calls "clk_enable_init_clocks()"
> which increases the usecount on all ENABLE_ON_INIT clocks, it
> prevents "omap2_clk_disable_unused()" from disabling the clock.
> 
> The real fix is to have driver for EMIF and do clock get/enable
> as part of it. The EMIF driver is planned to be done HWMOD way
> so till that available to keep omap3_defconfig booting on OMAP4430,
> this patch is necessary.
> (Will updated the auto-gen script for 44xx accordingly)
> 
> The fix was suggested by Paul Walmsley
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> With this patch and Tony's below sram fix, omap3_defconfig
> boots on OMAP4430 as it is. Boot tested with 2.6.34 maniline kernel
> on OMAP4430, OMAP3430 with omap3_defconfig and regular defconfig
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27363.html
> 
>  arch/arm/mach-omap2/clock44xx_data.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index a5c0c9c..a1b4cae 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -1369,6 +1369,7 @@ static struct clk emif1_ick = {
>  	.ops		= &clkops_omap2_dflt,
>  	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_1_CLKCTRL,
>  	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
> +	.flags		= ENABLE_ON_INIT,
>  	.clkdm_name	= "l3_emif_clkdm",
>  	.parent		= &ddrphy_ck,
>  	.recalc		= &followparent_recalc,
> @@ -1379,6 +1380,7 @@ static struct clk emif2_ick = {
>  	.ops		= &clkops_omap2_dflt,
>  	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_2_CLKCTRL,
>  	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
> +	.flags		= ENABLE_ON_INIT,
>  	.clkdm_name	= "l3_emif_clkdm",
>  	.parent		= &ddrphy_ck,
>  	.recalc		= &followparent_recalc,
Tested-by: Nishanth Menon <nm@ti.com>

tested on SDP4430 -> NOTE: it wont get through beyond
[    5.953491] Bluetooth: L2CAP socket layer initialized
[    5.958648] Bluetooth: SCO (Voice Link) ver 0.6
[    5.963256] Bluetooth: SCO socket layer initialized
[    5.968475] Bluetooth: RFCOMM TTY layer initialized
[    5.973449] Bluetooth: RFCOMM socket layer initialized
[    5.978698] Bluetooth: RFCOMM ver 1.11
[    5.982482] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.987884] Bluetooth: BNEP filters: protocol multicast
[    5.993164] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    6.000457] lib80211: common routines for IEEE802.11 drivers
[    6.006286] ThumbEE CPU extension supported.
[    6.045471] VFP support v0.3: implementor 41 architecture 3 part 30 
variant 9 rev 0
[    6.057250] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   18.688720] Looking up port of RPC 100003/2 on 128.247.75.5
[   48.694244] rpcbind: server 128.247.75.1 not responding, timed out
[   48.700958] Root-NFS: Unable to get nfsd port number from server, 
using default
[   48.708374] Looking up port of RPC 100005/1 on 128.247.75.5
[   78.710479] rpcbind: server 128.247.75.1 not responding, timed out
[   78.716827] Root-NFS: Unable to get mountd port number from server, 
using default
looks like network is still not functional on SDP4430. different issue

Pass to NFS boot on: SDP3630, SDP3430.

-- 
Regards,
Nishanth Menon
