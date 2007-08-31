From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] ARM: OMAP: MUSB: dont exit with spinlock held
Date: Thu, 30 Aug 2007 22:47:35 -0700
Message-ID: <20070831054735.E513223744B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20070831025359.663866890@mvista.com>
	<20070831025811.557377351@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070831025811.557377351@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com, khilman@mvista.com
List-Id: linux-omap@vger.kernel.org

> From linux-omap-open-source-bounces@linux.omap.com  Thu Aug 30 20:07:19 2007
> Date: Thu, 30 Aug 2007 19:54:00 -0700
> From: Kevin Hilman <khilman@mvista.com>
> To: linux-omap-open-source@linux.omap.com
> Subject: [PATCH 1/2] ARM: OMAP: MUSB: dont exit with spinlock held
>
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
>
> ---
>  drivers/usb/musb/musb_core.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> Index: dev/drivers/usb/musb/musb_core.c
> ===================================================================
> --- dev.orig/drivers/usb/musb/musb_core.c
> +++ dev/drivers/usb/musb/musb_core.c
> @@ -1682,19 +1682,22 @@ musb_vbus_store(struct device *dev, stru
>  	struct musb	*musb = dev_to_musb(dev);
>  	unsigned long	flags;
>  	unsigned long	val;
> +	ssize_t retval = n;
>  
>  	spin_lock_irqsave(&musb->lock, flags);
>  	if (sscanf(buf, "%lu", &val) < 1) {

What's it doing grabbing the spinlock before sscanf() anyway?
It's not loke any protected data is handed off to sscanf()...
This should instead be:

	if (sscanf(...)...)
		return -EINVAL

	spin_lock_irqsave(...)

General rule of thumb:  don't grab spinlocks earlier than necessary.


>  		printk(KERN_ERR "Invalid VBUS timeout ms value\n");
> -		return -EINVAL;
> +		retval = -EINVAL;
> +		goto out;
>  	}
>  	musb->a_wait_bcon = val;
>  	if (musb->xceiv.state == OTG_STATE_A_WAIT_BCON)
>  		musb->is_active = 0;
>  	musb_platform_try_idle(musb, jiffies + msecs_to_jiffies(val));
> +out:
>  	spin_unlock_irqrestore(&musb->lock, flags);
>  
> -	return n;
> +	return retval;
>  }
>  
>  static ssize_t
>
