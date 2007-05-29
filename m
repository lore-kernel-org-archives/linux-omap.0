From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] musb_hdrc: Add SRP Interface and control it through
	sysfs
Date: Tue, 29 May 2007 10:07:03 -0700
Message-ID: <200705291007.03251.david-b@pacbell.net>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401662563-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401722783-git-send-email-felipebalbi@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11804401722783-git-send-email-felipebalbi@users.sourceforge.net>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 29 May 2007, Felipe Balbi wrote:
> --- linux-omap-2.6.orig/drivers/usb/musb/musb_gadget.c	2007-05-28 01:40:16.000000000 +0300
> +++ linux-omap-2.6/drivers/usb/musb/musb_gadget.c	2007-05-28 13:18:47.000000000 +0300
> @@ -2056,3 +2056,29 @@
>  	(void) musb_gadget_vbus_draw(&musb->g,
>  			is_otg_enabled(musb) ? 8 : 100);
>  }
> +
> +/* called when we want to send a Session Request. Caller must hold the lock */
> +void musb_g_srp(struct musb *musb)

This method should not be needed.  When you
invoke usb_gadget_wakeup(), that's supposed
to trigger SRP when there's no existing
power session.

Note also that SRP is *NOT* an OTG-only
capability ... so it's incorrect to wrap
calls to such a routine in an OTG #ifdef.
Any peripheral is allowed to issue SRP.



> --- linux-omap-2.6.orig/drivers/usb/musb/plat_uds.c	2007-05-28 01:40:16.000000000 +0300
> +++ linux-omap-2.6/drivers/usb/musb/plat_uds.c	2007-05-28 13:18:47.000000000 +0300
> @@ -1579,6 +1579,32 @@
>  }
>  static DEVICE_ATTR(cable, S_IRUGO, musb_cable_show, NULL);
>  
> +#ifdef CONFIG_USB_MUSB_OTG
> +static ssize_t
> +musb_srp_store(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t n)
> +{
> +	struct musb	*musb=dev_to_musb(dev);
> +	unsigned long	flags;
> +	unsigned short	srp;
> +
> +	if (sscanf(buf, "%hu", &srp) != 1
> +			|| (srp != 1)) {
> +		printk (KERN_ERR "SRP: Value must be 1\n");
> +		return -EINVAL;
> +	}

I see no point to such input validation.  Why even bother?


> +
> +	spin_lock_irqsave(&musb->Lock, flags);
> +	if (srp == 1){
> +		musb_g_srp(musb);

Call the "resume" method, not a special SRP-only one.


> +	}
> +	spin_unlock_irqrestore(&musb->Lock, flags);
> +
> +	return n;
> +}
> +static DEVICE_ATTR(srp, 0644, NULL, musb_srp_store);
> +#endif /* CONFIG_USB_MUSB_OTG */
> +
>  #endif
>  
>  /* Only used to provide cable state change events */
> @@ -1648,6 +1674,9 @@
>  #ifdef CONFIG_SYSFS
>  	device_remove_file(musb->controller, &dev_attr_mode);
>  	device_remove_file(musb->controller, &dev_attr_cable);
> +#ifdef CONFIG_USB_MUSB_OTG

This, and its sibling later, and the code above, should
all be #ifdeffed CONFIG_USB_GADGET_MUSB_HDRC ... since
any peripheral may issue SRP, not only OTG-capable ones.

> +	device_remove_file(musb->controller, &dev_attr_srp);
> +#endif
>  #endif
>  
>  #ifdef CONFIG_USB_GADGET_MUSB_HDRC
> @@ -1876,6 +1905,9 @@
>  #ifdef CONFIG_SYSFS
>  	status = device_create_file(dev, &dev_attr_mode);
>  	status = device_create_file(dev, &dev_attr_cable);
> +#ifdef CONFIG_USB_MUSB_OTG
> +	status = device_create_file(dev, &dev_attr_srp);
> +#endif /* CONFIG_USB_MUSB_OTG */
>  	status = 0;
>  #endif
>  
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
