From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/12] head.S changes to CPU ID
Date: Thu, 14 Jun 2007 04:40:35 -0700
Message-ID: <20070614114035.GD28804@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47011E6091@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47011E6091@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070613 22:01]:
> Updated head.S CPU ID to consider OMAP3 ARCH Cortex processor.
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
> 
> Files:
>  arch/arm/boot/compressed/head.S
> 
> =======================================================================
> diff -purN linux-omap/arch/arm/boot/compressed/head.S val_3430_GIT/arch/arm/boot/compressed/head.S
> --- linux-omap/arch/arm/boot/compressed/head.S	2007-06-12 15:08:45.000000000 -0500
> +++ val_3430_GIT/arch/arm/boot/compressed/head.S	2007-06-12 17:06:57.000000000 -0500
> @@ -646,8 +646,8 @@ proc_types:
>  		b	__armv4_mmu_cache_off
>  		b	__armv6_mmu_cache_flush
>  
> -		.word	0x000f0000		@ new CPU Id
> -		.word	0x000f0000
> +		.word	0x000fc000		@ new CPU Id
> +		.word	0x000ff000
>  		b	__armv7_mmu_cache_on
>  		b	__armv7_mmu_cache_off
>  		b	__armv7_mmu_cache_flush

This you should also send to linux-arm-kernel list.

Should the comment above be changed to ARMv7 from "new CPU Id"?

Tony
