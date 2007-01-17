From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] MUSB HDRC: RMMOD fixing
Date: Wed, 17 Jan 2007 11:57:25 -0800
Message-ID: <200701171157.26218.david-b@pacbell.net>
References: <1169062794.14795.1.camel@balbi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1169062794.14795.1.camel@balbi>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipe.lima@indt.org.br>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 17 January 2007 11:39 am, Felipe Balbi wrote:
> Hello guys,
> 
> musb_hdrc was failing when rmmoding,

Failing how?  Last several times I tried that it worked just fine...

Of course I still have a few patches to scrub out from my queue too;
but this isn't one of them.

- Dave


> this minimmun patch fixes the problem
> 
> 
> 
> [PATCH] MUSB HDRC: RMMOD Fail-fixing
> 	
> 	musb_hdrc was failing when rmmoding. This little patch
> 	fixes the problem.	
> 
> Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
> ---
> 
> Index: linux-omap-2.6/drivers/usb/musb/plat_uds.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/usb/musb/plat_uds.c
> +++ linux-omap-2.6/drivers/usb/musb/plat_uds.c
> @@ -1614,3 +1614,2 @@ static void musb_free(struct musb *musb)
>  	musb_platform_exit(musb);
> -	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, 0);
>  
> 
> 
> 
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> felipe.lima@indt.org.br
> 
> Nokia Institute of Technology - INdT
> Kernel Developers Team
> 
> +55 92 8127 0839
> 
