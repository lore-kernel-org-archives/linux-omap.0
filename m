From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dsp_fbexport: use kzalloc
Date: Fri, 10 Nov 2006 01:52:46 +0200
Message-ID: <20061109235246.GS16172@atomide.com>
References: <85odridx2n.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <85odridx2n.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Arnaud Patard <arnaud.patard@rtp-net.org> [061108 13:08]:
> 
> The dsp_export function calls omapfb_register_client() right after
> allocating the memory with kmalloc. 
> A commit added to omapfb_register_client() a check on the value of
> plane_idx in the notified block structure. As we're only using kmalloc,
> you may end-up comparing garbage/random values (It even leads to a oops
> on my n770). 
> Using kzalloc() fixes the issue.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---
> 

> ---
>  arch/arm/plat-omap/dsp/dsp_mem.c |    2 	1 +	1 -	0 !
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-omap-2.6/arch/arm/plat-omap/dsp/dsp_mem.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/dsp/dsp_mem.c	2006-11-07 23:43:12.000000000 +0100
> +++ linux-omap-2.6/arch/arm/plat-omap/dsp/dsp_mem.c	2006-11-07 23:43:30.000000000 +0100
> @@ -1495,7 +1495,7 @@ static int dsp_fbexport(dsp_long_t *dspa
>  #endif
>  
>  #ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
> -	omapfb_nb = kmalloc(sizeof(struct omapfb_notifier_block), GFP_KERNEL);
> +	omapfb_nb = kzalloc(sizeof(struct omapfb_notifier_block), GFP_KERNEL);
>  	if (omapfb_nb == NULL) {
>  		printk(KERN_ERR
>  		       "omapdsp: failed to allocate memory for omapfb_nb!\n");

Pushing today.

Tony
