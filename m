From: Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [RFC][PATCH 3/9] usb: otg: add OTG core
Date: Thu, 19 Mar 2015 16:26:59 +0800
Message-ID: <20150319082656.GA4210@shlinux1.ap.freescale.net>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com>
 <1426686963-11613-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426686963-11613-4-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 18, 2015 at 03:55:57PM +0200, Roger Quadros wrote:
> The OTG core instantiates the OTG Finite State Machine
> per OTG controller and manages starting/stopping the
> host and gadget controllers based on the bus state.
> 
> It provides APIs for the following tasks
> 
> - Registering an OTG capable controller
> - Registering Host and Gadget controllers to OTG core
> - Providing inputs to and kicking the OTG state machine
> 
> TODO:
> - sysfs interface to allow application inputs to OTG state machine
> - otg class?
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
> +struct otg_data {
> +	struct device *dev;	/* HCD & GCD's parent device */
> +
> +	struct otg_fsm fsm;
> +	/* HCD, GCD and usb_otg_state are present in otg_fsm->otg
> +	 * HCD is bus_to_hcd(fsm->otg->host)
> +	 * GCD is fsm->otg->gadget
> +	 */
> +	struct otg_fsm_ops fsm_ops;	/* private copy for override */
> +	struct usb_otg otg;
> +	struct usb_hcd *shared_hcd;	/* if shared HCD registered */
> +
> +	/* saved hooks to OTG device */
> +	int (*start_host)(struct otg_fsm *fsm, int on);
> +	int (*start_gadget)(struct otg_fsm *fsm, int on);
> +
> +	struct list_head list;
> +
> +	struct work_struct work;	/* OTG FSM work */
> +	struct workqueue_struct *wq;
> +
> +	struct otg_timer timers[NUM_OTG_FSM_TIMERS];
> +
> +	bool fsm_running;
> +	bool gadget_can_start;		/* OTG FSM says gadget can start */
> +	bool host_can_start;		/* OTG FSM says host can start */

Do not understand above 2 *_can_start flags from the patch, which are set
only when you really start host/gadget, to prevent host/gadget driver to
start it out of otg fsm control?

Li Jun
> +
> +	/* use otg->fsm.lock for serializing access */
> +};
> +
> + * Can be called in IRQ context.
> + */
> +void usb_otg_sync_inputs(struct otg_fsm *fsm)
> +{
> +	struct otg_data *otgd = container_of(fsm, struct otg_data, fsm);
> +
> +	/* Don't kick FSM till it has started */
> +	if (!otgd->fsm_running)
> +		return;
> +
> +	/* Kick FSM */
> +	queue_work(otgd->wq, &otgd->work);
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_sync_inputs);
> +
> +/**
> + * usb_otg_kick_fsm - Kick the OTG state machine
> + * @hcd_gcd_device:	Host/Gadget controller device
> + *
> + * Used by USB host/device stack to sync OTG related
> + * events to the OTG state machine.
> + * e.g. change in host_bus->b_hnp_enable, gadget->b_hnp_enable
> + *
There are quite a few otg fsm variables which should be updated when 
events/interrupts(b_conn, a_srp_det, ...) occur, how is your plan to
update them? Still rely on specific controller driver irq handler to
capture all those events and update them?

Li Jun
> + * Returns: 0 on success, error value otherwise.
> + */
> +int usb_otg_kick_fsm(struct device *hcd_gcd_device)
> +{
> +	struct otg_data *otgd;
> +
> +	mutex_lock(&otg_list_mutex);
> +	otgd = usb_otg_device_get_otgd(hcd_gcd_device->parent);
> +	if (!otgd) {
> +		dev_err(hcd_gcd_device, "%s: invalid host/gadget device\n",
> +			__func__);
> +		mutex_unlock(&otg_list_mutex);
> +		return -ENODEV;
> +	}
> +
> +	mutex_unlock(&otg_list_mutex);
> +	usb_otg_sync_inputs(&otgd->fsm);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_kick_fsm);
> -- 
> 2.1.0
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
