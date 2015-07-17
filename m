From: Li Jun <b47624@freescale.com>
Subject: Re: [PATCH v3 10/11] usb: otg: Add dual-role device (DRD) support
Date: Fri, 17 Jul 2015 17:02:13 +0800
Message-ID: <20150717090212.GC4515@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <1436350777-28056-11-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436350777-28056-11-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 08, 2015 at 01:19:36PM +0300, Roger Quadros wrote:

[...]

>  struct otg_fsm *usb_otg_register(struct device *parent_dev,
> -				 struct otg_fsm_ops *fsm_ops)
> +				 struct otg_fsm_ops *fsm_ops,
> +				 bool drd_only)
>  {
>  	struct otg_data *otgd;
>  	int ret = 0;
> @@ -328,7 +482,15 @@ struct otg_fsm *usb_otg_register(struct device *parent_dev,
>  		goto err_wq;
>  	}
>  
> -	usb_otg_init_timers(otgd);
> +	otgd->drd_only = drd_only;
> +	/* For DRD mode we don't need OTG timers */
> +	if (!drd_only) {
> +		usb_otg_init_timers(otgd);
> +
> +		/* FIXME: we ignore caller's timer ops */
> +		otgd->fsm_ops.add_timer = usb_otg_add_timer;
> +		otgd->fsm_ops.del_timer = usb_otg_del_timer;
> +	}
>  
>  	/* save original start host/gadget ops */
>  	otgd->start_host = fsm_ops->start_host;
> @@ -338,9 +500,6 @@ struct otg_fsm *usb_otg_register(struct device *parent_dev,

Your above override will be override back to be fsm_ops's by below copy:

	/* create copy of original ops */
	otgd->fsm_ops = *fsm_ops;

So add/del_timer must be override after the copy.

>  	/* override ops */
>  	otgd->fsm_ops.start_host = usb_otg_start_host;
>  	otgd->fsm_ops.start_gadget = usb_otg_start_gadget;
> -	/* FIXME: we ignore caller's timer ops */
> -	otgd->fsm_ops.add_timer = usb_otg_add_timer;
> -	otgd->fsm_ops.del_timer = usb_otg_del_timer;
>  	/* set otg ops */
>  	otgd->fsm.ops = &otgd->fsm_ops;
>  	otgd->fsm.otg = &otgd->otg;
> @@ -443,8 +602,10 @@ static void usb_otg_stop_fsm(struct otg_fsm *fsm)
>  	otgd->fsm_running = false;
>  
>  	/* Stop state machine / timers */
> -	for (i = 0; i < ARRAY_SIZE(otgd->timers); i++)
> -		hrtimer_cancel(&otgd->timers[i].timer);
> +	if (!otgd->drd_only) {
> +		for (i = 0; i < ARRAY_SIZE(otgd->timers); i++)
> +			hrtimer_cancel(&otgd->timers[i].timer);
> +	}
>  
>  	flush_workqueue(otgd->wq);
>  	fsm->otg->state = OTG_STATE_UNDEFINED;
> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
> index 22d8baa..ae9c30a 100644
> --- a/include/linux/usb/otg-fsm.h
> +++ b/include/linux/usb/otg-fsm.h
> @@ -48,6 +48,11 @@ enum otg_fsm_timer {
>  /**
>   * struct otg_fsm - OTG state machine according to the OTG spec
>   *
> + * DRD mode hardware Inputs
> + *
> + * @id:		TRUE for B-device, FALSE for A-device.
> + * @vbus:	VBUS voltage in regulation.
> + *
>   * OTG hardware Inputs
>   *
>   *	Common inputs for A and B device
> @@ -122,7 +127,8 @@ enum otg_fsm_timer {
>   */
>  struct otg_fsm {
>  	/* Input */
> -	int id;
> +	int id;			/* DRD + OTG */
> +	int vbus;		/* DRD only */

Existing b_sess_vld can be also used for drd only case, no need create
a new flag.

>  	int adp_change;
>  	int power_up;
>  	int a_srp_det;
> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> index ce6f8d8..1086a0b 100644
> --- a/include/linux/usb/otg.h
> +++ b/include/linux/usb/otg.h
> @@ -58,7 +58,7 @@ enum usb_dr_mode {
>  
>  #if IS_ENABLED(CONFIG_USB_OTG)
>  struct otg_fsm *usb_otg_register(struct device *parent_dev,
> -				 struct otg_fsm_ops *fsm_ops);
> +				 struct otg_fsm_ops *fsm_ops, bool drd_only);
>  int usb_otg_unregister(struct device *parent_dev);
>  int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>  			 unsigned long irqflags, struct otg_hcd_ops *ops);
> @@ -73,7 +73,8 @@ struct device *usb_otg_fsm_to_dev(struct otg_fsm *fsm);
>  #else /* CONFIG_USB_OTG */
>  
>  static inline struct otg_fsm *usb_otg_register(struct device *parent_dev,
> -					       struct otg_fsm_ops *fsm_ops)
> +					       struct otg_fsm_ops *fsm_ops,
> +					       bool drd_only)
>  {
>  	return ERR_PTR(-ENOSYS);
>  }
> -- 
> 2.1.4
> 
