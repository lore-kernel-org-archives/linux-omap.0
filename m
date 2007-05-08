From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in tusb6010_omap.c
Date: Mon, 7 May 2007 17:17:17 -0700
Message-ID: <20070508001716.GF31968@atomide.com>
References: <463C3921.104@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <463C3921.104@googlemail.com>
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

* Dirk Behme <dirk.behme@googlemail.com> [070505 00:59]:
> 
> Fix warning
> 
> drivers/usb/musb/tusb6010_omap.c: In function 'tusb_omap_dma_cb':
> drivers/usb/musb/tusb6010_omap.c:188: warning: format '%i' expects
> type 'int', but argument 4 has type 'long unsigned int'
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> 

> Index: linux-osk/drivers/usb/musb/tusb6010_omap.c
> ===================================================================
> --- linux-osk.orig/drivers/usb/musb/tusb6010_omap.c
> +++ linux-osk/drivers/usb/musb/tusb6010_omap.c
> @@ -185,7 +185,7 @@ static void tusb_omap_dma_cb(int lch, u1
>  	if (pio > 0 && pio < 32) {
>  		u8	*buf;
>  
> -		DBG(2, "Using PIO for remaining %i bytes\n", pio);
> +		DBG(2, "Using PIO for remaining %lu bytes\n", pio);
>  		buf = phys_to_virt((u32)chdat->dma_addr) + chdat->transfer_len;
>  		if (chdat->tx) {
>  			consistent_sync(phys_to_virt((u32)chdat->dma_addr),
> 

Pushing this too.

Tony
