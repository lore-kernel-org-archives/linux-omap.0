From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] MUSB: Kill compile warnings at
	drivers/usb/musb/tusb6010.c
Date: Fri, 31 Aug 2007 09:47:29 -0700
Message-ID: <20070831164728.GB12350@atomide.com>
References: <11882419051271-git-send-email-felipe.lima@indt.org.br>
	<11882419064188-git-send-email-felipe.lima@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11882419064188-git-send-email-felipe.lima@indt.org.br>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.lima@indt.org.br> [070827 12:12]:
> Get rid of the following warning:
> drivers/usb/musb/tusb6010.c: In function 'tusb_otg_ints':
> drivers/usb/musb/tusb6010.c:716: warning: unused variable 'devctl'
> 
> Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
> ---
>  drivers/usb/musb/tusb6010.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
> index 23840dc..562eb9d 100644
> --- a/drivers/usb/musb/tusb6010.c
> +++ b/drivers/usb/musb/tusb6010.c
> @@ -713,8 +713,6 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *base)
>  			schedule_work(&musb->irq_work);
>  
>  		} else /* A-dev state machine */ {
> -			u8	devctl;
> -
>  			DBG(2, "vbus change, %s, otg %03x\n",
>  				otg_state_string(musb), otg_stat);
>  

Thanks, pushing today.

Tony
