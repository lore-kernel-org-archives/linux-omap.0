From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v9 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 8 Jun 2016 17:53:36 +0800
Message-ID: <20160608095336.GA4444@shlinux2>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-9-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465376626-30122-9-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 08, 2016 at 12:03:40PM +0300, Roger Quadros wrote:
> +int usb_otg_unregister(struct device *dev)
> +{
> +	struct usb_otg *otg;
> +
> +	mutex_lock(&otg_list_mutex);
> +	otg = usb_otg_get_data(dev);
> +	if (!otg) {
> +		dev_err(dev, "otg: %s: device not in otg list\n",
> +			__func__);
> +		mutex_unlock(&otg_list_mutex);
> +		return -EINVAL;
> +	}
> +
> +	/* prevent unregister till both host & gadget have unregistered */
> +	if (otg->host || otg->gadget) {
> +		dev_err(dev, "otg: %s: host/gadget still registered\n",
> +			__func__);

You need to call mutex_unlock here

> +
> +int usb_otg_gadget_ready(struct usb_gadget *gadget, bool ready)
> +{

What this API is for? Why need it in this version?

> +	struct usb_otg *otg;
> +	struct device *gadget_dev = &gadget->dev;
> +	struct device *otg_dev = gadget->otg_dev;
> +
> +	if (!otg_dev)
> +		return -EINVAL;
> +
> +	mutex_lock(&otg_list_mutex);
> +	otg = usb_otg_get_data(otg_dev);
> +	mutex_unlock(&otg_list_mutex);
> +	if (!otg) {
> +		dev_err(gadget_dev,
> +			"otg: gadget %s wasn't registered with otg\n",
> +			dev_name(&gadget->dev));
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&otg->fsm.lock);
> +	if (otg->gadget != gadget) {
> +		mutex_unlock(&otg->fsm.lock);
> +		dev_err(otg_dev, "otg: gadget %s wasn't registered with otg\n",
> +			dev_name(&gadget->dev));
> +		return -EINVAL;
> +	}
> +
> +	/* Start/stop FSM & gadget */
> +	otg->gadget_ready = ready;
> +	if (ready)
> +		usb_otg_start_fsm(otg);
> +	else
> +		usb_otg_stop_fsm(otg);
> +
> +	dev_dbg(otg_dev, "otg: gadget %s %sready\n", dev_name(&gadget->dev),
> +		ready ? "" : "not ");
> +
> +	mutex_unlock(&otg->fsm.lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_gadget_ready);
> +
> --- a/include/linux/usb/otg.h
> +++ b/include/linux/usb/otg.h
> @@ -10,10 +10,70 @@
>  #define __LINUX_USB_OTG_H
>  
>  #include <linux/phy/phy.h>
> -#include <linux/usb/phy.h>
> -#include <linux/usb/otg-fsm.h>
> +#include <linux/device.h>
> +#include <linux/hrtimer.h>
> +#include <linux/ktime.h>

The above two timer header files are not needed.

Peter
> +#include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/otg-fsm.h>
> +#include <linux/usb/phy.h>
> +
> +/**
> + * struct otg_hcd - host controller state and interface
> + *
> + * @hcd: host controller
> + * @irqnum: irq number
> + * @irqflags: irq flags
> + * @ops: otg to host controller interface
> + * @ops: otg to host controller interface
> + * @otg_dev: otg controller device
> + */
> +struct otg_hcd {
> +	struct usb_hcd *hcd;
> +	unsigned int irqnum;
> +	unsigned long irqflags;
> +	struct otg_hcd_ops *ops;
> +	struct device *otg_dev;
> +};
> +
> +/**
> + * struct usb_otg_caps - describes the otg capabilities of the device
> + * @otg_rev: The OTG revision number the device is compliant with, it's
> + *		in binary-coded decimal (i.e. 2.0 is 0200H).
> + * @hnp_support: Indicates if the device supports HNP.
> + * @srp_support: Indicates if the device supports SRP.
> + * @adp_support: Indicates if the device supports ADP.
> + */
> +struct usb_otg_caps {
> +	u16 otg_rev;
> +	bool hnp_support;
> +	bool srp_support;
> +	bool adp_support;
> +};
>  
> +/**
> + * struct usb_otg - usb otg controller state
> + *
> + * @default_a: Indicates we are an A device. i.e. Host.
> + * @phy: USB phy interface
> + * @usb_phy: old usb_phy interface
> + * @host: host controller bus
> + * @gadget: gadget device
> + * @state: current otg state
> + * @dev: otg controller device
> + * @caps: otg capabilities revision, hnp, srp, etc
> + * @fsm: otg finite state machine
> + * @hcd_ops: host controller interface
> + * ------- internal use only -------
> + * @primary_hcd: primary host state and interface
> + * @shared_hcd: shared host state and interface
> + * @gadget_ops: gadget controller interface
> + * @list: list of otg controllers
> + * @work: otg state machine work
> + * @wq: otg state machine work queue
> + * @flags: to track if host/gadget is running
> + */
>  struct usb_otg {
>  	u8			default_a;
>  
> @@ -24,9 +84,25 @@ struct usb_otg {
>  	struct usb_gadget	*gadget;
>  
>  	enum usb_otg_state	state;
> +	struct device *dev;
> +	struct usb_otg_caps	caps;
>  	struct otg_fsm fsm;
>  	struct otg_hcd_ops	*hcd_ops;
>  
> +	/* internal use only */
> +	struct otg_hcd primary_hcd;
> +	struct otg_hcd shared_hcd;
> +	struct otg_gadget_ops *gadget_ops;
> +	bool gadget_ready;
> +	struct list_head list;
> +	struct work_struct work;
> +	struct workqueue_struct *wq;
> +	u32 flags;
> +#define OTG_FLAG_GADGET_RUNNING (1 << 0)
> +#define OTG_FLAG_HOST_RUNNING (1 << 1)
> +	/* use otg->fsm.lock for serializing access */
> +
> +/*------------- deprecated interface -----------------------------*/
>  	/* bind/unbind the host controller */
>  	int	(*set_host)(struct usb_otg *otg, struct usb_bus *host);
>  
> @@ -42,26 +118,101 @@ struct usb_otg {
>  
>  	/* start or continue HNP role switch */
>  	int	(*start_hnp)(struct usb_otg *otg);
> -
> +/*---------------------------------------------------------------*/
>  };
>  
>  /**
> - * struct usb_otg_caps - describes the otg capabilities of the device
> - * @otg_rev: The OTG revision number the device is compliant with, it's
> - *		in binary-coded decimal (i.e. 2.0 is 0200H).
> - * @hnp_support: Indicates if the device supports HNP.
> - * @srp_support: Indicates if the device supports SRP.
> - * @adp_support: Indicates if the device supports ADP.
> + * struct usb_otg_config - otg controller configuration
> + * @caps: otg capabilities of the controller
> + * @ops: otg fsm operations
> + * @otg_work: optional custom otg state machine work function
>   */
> -struct usb_otg_caps {
> -	u16 otg_rev;
> -	bool hnp_support;
> -	bool srp_support;
> -	bool adp_support;
> +struct usb_otg_config {
> +	struct usb_otg_caps *otg_caps;
> +	struct otg_fsm_ops *fsm_ops;
> +	void (*otg_work)(struct work_struct *work);
>  };
>  
>  extern const char *usb_otg_state_string(enum usb_otg_state state);
>  
> +#if IS_ENABLED(CONFIG_USB_OTG)
> +struct usb_otg *usb_otg_register(struct device *dev,
> +				 struct usb_otg_config *config);
> +int usb_otg_unregister(struct device *dev);
> +int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
> +			 unsigned long irqflags, struct otg_hcd_ops *ops);
> +int usb_otg_unregister_hcd(struct usb_hcd *hcd);
> +int usb_otg_register_gadget(struct usb_gadget *gadget,
> +			    struct otg_gadget_ops *ops);
> +int usb_otg_unregister_gadget(struct usb_gadget *gadget);
> +void usb_otg_sync_inputs(struct usb_otg *otg);
> +int usb_otg_kick_fsm(struct device *otg_dev);
> +int usb_otg_start_host(struct usb_otg *otg, int on);
> +int usb_otg_start_gadget(struct usb_otg *otg, int on);
> +int usb_otg_gadget_ready(struct usb_gadget *gadget, bool ready);
> +
> +#else /* CONFIG_USB_OTG */
> +
> +static inline struct usb_otg *usb_otg_register(struct device *dev,
> +					       struct usb_otg_config *config)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
> +static inline int usb_otg_unregister(struct device *dev)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
> +				       unsigned long irqflags,
> +				       struct otg_hcd_ops *ops)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int usb_otg_unregister_hcd(struct usb_hcd *hcd)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int usb_otg_register_gadget(struct usb_gadget *gadget,
> +					  struct otg_gadget_ops *ops)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int usb_otg_unregister_gadget(struct usb_gadget *gadget)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void usb_otg_sync_inputs(struct usb_otg *otg)
> +{
> +}
> +
> +static inline int usb_otg_kick_fsm(struct device *otg_dev)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int usb_otg_start_host(struct usb_otg *otg, int on)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int usb_otg_start_gadget(struct usb_otg *otg, int on)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int usb_otg_gadget_ready(struct usb_gadget *gadget, bool ready)
> +{
> +	return -ENOTSUPP;
> +}
> +#endif /* CONFIG_USB_OTG */
> +
> +/*------------- deprecated interface -----------------------------*/
>  /* Context: can sleep */
>  static inline int
>  otg_start_hnp(struct usb_otg *otg)
> @@ -113,6 +264,8 @@ otg_start_srp(struct usb_otg *otg)
>  	return -ENOTSUPP;
>  }
>  
> +/*---------------------------------------------------------------*/
> +
>  /* for OTG controller drivers (and maybe other stuff) */
>  extern int usb_bus_start_enum(struct usb_bus *bus, unsigned port_num);
>  
> @@ -237,4 +390,6 @@ static inline int otg_start_gadget(struct usb_otg *otg, int on)
>  	return otg->fsm.ops->start_gadget(otg, on);
>  }
>  
> +int drd_statemachine(struct usb_otg *otg);
> +
>  #endif /* __LINUX_USB_OTG_H */
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
