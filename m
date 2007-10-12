From: Tony Lindgren <tony@atomide.com>
Subject: Re: Need to call kgdb8250_add_platform_port in omap_serial_init()?
Date: Fri, 12 Oct 2007 13:31:08 -0700
Message-ID: <20071012203107.GJ7979@atomide.com>
References: <470E63B4.40103@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <470E63B4.40103@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Drew Moseley <dmoseley@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Drew Moseley <dmoseley@mvista.com> [071011 10:57]:
> 
> The patch below calls kgdb8250_add_platform_port() from omap_serial_init().
> This is copied from mach-omap/serial.c.  Without this patch kgdbwait
> will fail.
> 
> Comments?

Makes sense, but I can't find any references in linux-omap for
kgdb8250_add_platform_port... I guess that's in some other tree?

Regards,

Tony

> Index: linux/arch/arm/mach-omap2/serial.c
> ===================================================================
> --- linux.orig/arch/arm/mach-omap2/serial.c
> +++ linux/arch/arm/mach-omap2/serial.c
> @@ -162,6 +162,9 @@ void __init omap_serial_init()
>  		}
> 
>  		omap_serial_reset(p);
> +#ifdef CONFIG_KGDB_8250
> +		kgdb8250_add_platform_port(i, &serial_platform_data[i]);
> +#endif
>  	}
>  }
> 
> 
> -- 
> mailto:dmoseley@mvista.com
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
