From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] misc patch on 24xx
Date: Fri, 13 Jan 2006 16:57:10 -0800
Message-ID: <20060114005710.GM5499@atomide.com>
References: <0ISN0041GUEIYE@mmp1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <0ISN0041GUEIYE@mmp1.samsung.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [060105 23:37]:
> Hi
> 
> We need to display correct SRAM physical address.
> 
> Regards,
> Kyungmin Park
> 
>  diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -147,7 +147,8 @@ void __init omap_map_sram(void)
>  	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
>  
>  	printk(KERN_INFO "SRAM: Mapped pa 0x%08lx to va 0x%08lx size:
> 0x%lx\n",
> -	       omap_sram_io_desc[0].pfn, omap_sram_io_desc[0].virtual,
> +	       __pfn_to_phys(omap_sram_io_desc[0].pfn),
> +	       omap_sram_io_desc[0].virtual,
>  	       omap_sram_io_desc[0].length);
>  
>  	/*

Thanks applied.

Tony
