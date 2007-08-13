From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix section mismatch warning
Date: Mon, 13 Aug 2007 01:56:33 -0700
Message-ID: <20070813085630.GH13948@atomide.com>
References: <46BEB340.90900@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46BEB340.90900@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070812 00:14]:
> Fix
>
> WARNING: vmlinux.o(.text+0x1554c): Section mismatch: reference to
> .init.text:reserve_bootmem (between 'omapfb_reserve_sdram' and
> 'omap_32k_timer_set_mode')
>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

> Index: linux-osk/arch/arm/plat-omap/fb.c
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/fb.c
> +++ linux-osk/arch/arm/plat-omap/fb.c
> @@ -171,7 +171,7 @@ static int check_fbmem_region(int region
>   * Called from map_io. We need to call to this early enough so that we
>   * can reserve the fixed SDRAM regions before VM could get hold of them.
>   */
> -void omapfb_reserve_sdram(void)
> +void __init omapfb_reserve_sdram(void)
>  {
>  	struct bootmem_data	*bdata;
>  	unsigned long		sdram_start, sdram_size;
> 

Pushing today.

Tony
