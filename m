From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix section mismatch warning in dsp_common.c
Date: Fri, 18 May 2007 08:47:47 -0700
Message-ID: <20070518154747.GF3369@atomide.com>
References: <464D5251.7060503@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <464D5251.7060503@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070518 00:17]:
>
> Fix
>
> WARNING: arch/arm/plat-omap/built-in.o - Section mismatch: reference
> to .init.text: from .text between 'dsp_cpustat_update' (at offset
> 0x7c40) and 'do_release_mem'
>
> If init_dsp isn't set, dsp_cpustat_update() calls omap_dsp_init(). So
> don't declare omap_dsp_init() as __init.
>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>

> Index: linux-osk/arch/arm/plat-omap/dsp/dsp_common.c
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/dsp/dsp_common.c
> +++ linux-osk/arch/arm/plat-omap/dsp/dsp_common.c
> @@ -268,7 +268,7 @@ void dsp_reset_idle_boot_base(void) { }
>  
>  static int init_done;
>  
> -static int __init omap_dsp_init(void)
> +static int omap_dsp_init(void)
>  {
>  	mutex_init(&cpustat.lock);
>  
> 
> 

Pushing today.

Tony
