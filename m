From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Make omap-ir build with workqueue changes.
Date: Tue, 9 Jan 2007 15:31:31 -0800
Message-ID: <20070109233131.GP7384@atomide.com>
References: <1167946702756-git-send-email-balrog@zabor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1167946702756-git-send-email-balrog@zabor.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Andrzej Zaborowski <balrog@zabor.org> [070104 12:39]:
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
> 
> ---
>  drivers/net/irda/omap-ir.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/irda/omap-ir.c b/drivers/net/irda/omap-ir.c
> index 562c876..85658dc 100644
> --- a/drivers/net/irda/omap-ir.c
> +++ b/drivers/net/irda/omap-ir.c
> @@ -54,6 +54,7 @@ #include <linux/ioport.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
> +#include <linux/workqueue.h>
>  
>  #include <net/irda/irda.h>
>  #include <net/irda/irmod.h>
> @@ -849,7 +850,7 @@ static int omap_irda_probe(struct platfo
>  
>  	/* Any better way to avoid this? No. */
>  	if (machine_is_omap_h3() || machine_is_omap_h4())
> -		INIT_WORK(&omap_ir->pdata->gpio_expa, NULL, NULL);
> +		INIT_DELAYED_WORK(&omap_ir->pdata->gpio_expa, NULL);
>  
>  	err = register_netdev(dev);
>  	if (!err)

Pushing today.

Tony
