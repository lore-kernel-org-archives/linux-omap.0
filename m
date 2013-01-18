From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2: Fix missing omap2xxx_clkt_vps_xxx function
 calls
Date: Fri, 18 Jan 2013 09:34:06 -0600
Message-ID: <50F96B6E.3060108@ti.com>
References: <1357851209-5332-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1301171848490.14118@utopia.booyaka.com> <50F85087.3060507@ti.com> <alpine.DEB.2.00.1301172230250.14118@utopia.booyaka.com> <alpine.DEB.2.00.1301172320460.14118@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40128 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937Ab3ARPeK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 10:34:10 -0500
In-Reply-To: <alpine.DEB.2.00.1301172320460.14118@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On 01/17/2013 05:24 PM, Paul Walmsley wrote:
> 
> Here's the updated version (at the bottom of this message). Seems to work 
> based on a quick test on 2430SDP.
> 
> # shutdown -r -n now
> shutdown: sending all processes the TERM signal...
> shutdown: sending all processes the KILL signal.
> shutdown: turning off swap
> shutdown: unmounting all file systems
> umount: /debug: not mounted
> umount: /run/shm: not mounted
> umount: /dev: not mounted
> umount: /tmp: not mounted
> umount: /run/lock: not mounted
> umount: /run: not mounted
> umount: /lib/init/rw: not found
> Please stand by while rebooting the system.
> [   79.635925] Disabling non-boot CPUs ...
> [   79.640197] Restarting system.
> 
> 
> U-Boot 1.1.4 (Mar 18 2007 - 12:22:00)
> 
> OMAP2430C-GP revision 3, PRCM #5A
> TI 2430SDP 1.1 Version + mDDR (Boot NOR)
> DRAM:  128 MB
> Flash: 192 MB
> NAND:64 MB
> In:    serial
> Out:   serial
> Err:   serial
> Hit any key to stop autoboot:  0 
> 
> 
> ... etc. ...
> 
> 
> - Paul
> 
> 
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Thu, 10 Jan 2013 14:53:29 -0600
> Subject: [PATCH] ARM: OMAP2: Fix missing omap2xxx_clkt_vps_late_init function
>  calls
> 
> During the migration to the common clock framework, calls to the
> functions omap2xxx_clkt_vps_late_init() were not preserved for
> OMAP2420 and OMAP2430. This causes the variables "sys_ck_rate" and
> "curr_prcm_set" to be uninitialised on boot. On reboot, this causes the
> following error message to be displayed because the appropriate MPU
> clock frequency (derived from sys_ck_rate) cannot be found.
> 
> "Could not set MPU rate to 4294MHz"
> 
> Fix this by adding back calls to omap2xxx_clkt_vps_late_init() in the
> OMAP2420 and OMAP2430 clock initialisation code.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> [paul@pwsan.com: dropped the duplicated call to
>  omap2xxx_clkt_vps_check_bootloader_rates() after consultation with Jon;
>  updated patch description]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/cclock2420_data.c |    2 ++
>  arch/arm/mach-omap2/cclock2430_data.c |    2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/cclock2420_data.c b/arch/arm/mach-omap2/cclock2420_data.c
> index 7e5febe..ab7e952 100644
> --- a/arch/arm/mach-omap2/cclock2420_data.c
> +++ b/arch/arm/mach-omap2/cclock2420_data.c
> @@ -1935,6 +1935,8 @@ int __init omap2420_clk_init(void)
>  			omap2_init_clk_hw_omap_clocks(c->lk.clk);
>  	}
>  
> +	omap2xxx_clkt_vps_late_init();
> +
>  	omap2_clk_disable_autoidle_all();
>  
>  	omap2_clk_enable_init_clocks(enable_init_clks,
> diff --git a/arch/arm/mach-omap2/cclock2430_data.c b/arch/arm/mach-omap2/cclock2430_data.c
> index eda079b..eb3dab6 100644
> --- a/arch/arm/mach-omap2/cclock2430_data.c
> +++ b/arch/arm/mach-omap2/cclock2430_data.c
> @@ -2050,6 +2050,8 @@ int __init omap2430_clk_init(void)
>  			omap2_init_clk_hw_omap_clocks(c->lk.clk);
>  	}
>  
> +	omap2xxx_clkt_vps_late_init();
> +
>  	omap2_clk_disable_autoidle_all();
>  
>  	omap2_clk_enable_init_clocks(enable_init_clks,

Thanks! Looks good to me.

Jon

