From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] To fix OMAP3430 boot for new mach-types
Date: Fri, 31 Aug 2007 10:20:54 -0700
Message-ID: <20070831172053.GI12350@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701A9127E@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701A9127E@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070830 17:05]:
> 
> This patch is to fix OMAP 3430 boot/compilation for updated mach-types.
> 
> Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>
> 
> File:
>  arch/arm/mach-omap2/board-3430sdp.c
> 
> =======================================================================
> 
> --- linux-omap/arch/arm/mach-omap2/board-3430sdp.c	2007-07-11 09:55:16.000000000 -0500
> +++ my_linux-omap/arch/arm/mach-omap2/board-3430sdp.c	2007-08-30 18:54:44.000000000 -0500
> @@ -181,7 +181,7 @@ static void __init omap_3430sdp_map_io(v
>  	omap2_map_common_io();
>  }
>  
> -MACHINE_START(OMAP_SDP3430, "OMAP3430 sdp3430 board")
> +MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
>  	/* Maintainer: Syed Khasim - Texas Instruments Inc */
>  	.phys_io	= 0x48000000,
>  	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,

Pushing today.

Tony
