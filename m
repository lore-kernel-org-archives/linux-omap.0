From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Workqueue changes for tahvo-usb
Date: Tue, 9 Jan 2007 15:22:41 -0800
Message-ID: <20070109232241.GK7384@atomide.com>
References: <459D2D30.7040206@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <459D2D30.7040206@googlemail.com>
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

* Dirk Behme <dirk.behme@googlemail.com> [070104 08:38]:
> 
> ARM: OMAP: Workqueue changes for tahvo-usb.c
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 

> Index: linux-osk/drivers/cbus/tahvo-usb.c
> ===================================================================
> --- linux-osk.orig/drivers/cbus/tahvo-usb.c
> +++ linux-osk/drivers/cbus/tahvo-usb.c
> @@ -535,9 +535,9 @@ static int tahvo_usb_set_peripheral(stru
>  	return 0;
>  }
>  
> -static void tahvo_usb_irq_work(void *data)
> +static void tahvo_usb_irq_work(struct work_struct *work)
>  {
> -	struct tahvo_usb *tu = (struct tahvo_usb *)data;
> +	struct tahvo_usb *tu = container_of(work, struct tahvo_usb, irq_work);
>  
>  	mutex_lock(&tu->serialize);
>  	check_vbus_state(tu);
> @@ -631,7 +631,7 @@ static int tahvo_usb_probe(struct device
>  #endif
>  #endif
>  
> -	INIT_WORK(&tu->irq_work, tahvo_usb_irq_work, tu);
> +	INIT_WORK(&tu->irq_work, tahvo_usb_irq_work);
>  	mutex_init(&tu->serialize);
>  
>  	/* Set initial state, so that we generate kevents only on
> 

Pushing today.

Tony
