From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 04/12] usb: otg-fsm: move host controller operations
 into usb_otg->hcd_ops
Date: Mon, 18 Apr 2016 16:00:35 +0800
Message-ID: <20160418080035.GF4477@shlinux2.ap.freescale.net>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459865117-7032-5-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 05, 2016 at 05:05:09PM +0300, Roger Quadros wrote:
> This is to prevent missing symbol build error if OTG is
> enabled (built-in) and HCD core (CONFIG_USB) is module.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Acked-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>

> ---
>  drivers/usb/chipidea/otg_fsm.c   |  7 +++++++
>  drivers/usb/common/usb-otg-fsm.c | 15 +++++++++++----
>  drivers/usb/phy/phy-fsl-usb.c    |  7 +++++++
>  include/linux/usb/otg.h          |  2 ++
>  4 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
> index f4e9fb5..5fdf8ca 100644
> --- a/drivers/usb/chipidea/otg_fsm.c
> +++ b/drivers/usb/chipidea/otg_fsm.c
> @@ -582,6 +582,12 @@ static struct otg_fsm_ops ci_otg_ops = {
>  	.start_gadget = ci_otg_start_gadget,
>  };
>  
> +static struct otg_hcd_ops ci_hcd_ops = {
> +	.usb_bus_start_enum = usb_bus_start_enum,
> +	.usb_control_msg = usb_control_msg,
> +	.usb_hub_find_child = usb_hub_find_child,
> +};
> +
>  int ci_otg_fsm_work(struct ci_hdrc *ci)
>  {
>  	/*
> @@ -805,6 +811,7 @@ int ci_hdrc_otg_fsm_init(struct ci_hdrc *ci)
>  	ci->otg.state = OTG_STATE_UNDEFINED;
>  	ci->otg.fsm.ops = &ci_otg_ops;
>  	ci->otg.fsm.dev = ci->dev;
> +	ci->otg.hcd_ops = &ci_hcd_ops;
>  	ci->gadget.hnp_polling_support = 1;
>  	ci->otg.fsm.host_req_flag = devm_kzalloc(ci->dev, 1, GFP_KERNEL);
>  	if (!ci->otg.fsm.host_req_flag)
> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
> index abc462c..2cb4aed 100644
> --- a/drivers/usb/common/usb-otg-fsm.c
> +++ b/drivers/usb/common/usb-otg-fsm.c
> @@ -135,11 +135,16 @@ static void otg_hnp_polling_work(struct work_struct *work)
>  	enum usb_otg_state state = otg->state;
>  	u8 flag;
>  	int retval;
> +	struct otg_hcd_ops *hcd_ops = otg->hcd_ops;
>  
>  	if (state != OTG_STATE_A_HOST && state != OTG_STATE_B_HOST)
>  		return;
>  
> -	udev = usb_hub_find_child(otg->host->root_hub, 1);
> +	if (!hcd_ops || !hcd_ops->usb_control_msg ||
> +	    !hcd_ops->usb_hub_find_child)
> +		return;
> +
> +	udev = hcd_ops->usb_hub_find_child(otg->host->root_hub, 1);
>  	if (!udev) {
>  		dev_err(otg->host->controller,
>  			"no usb dev connected, can't start HNP polling\n");
> @@ -148,7 +153,7 @@ static void otg_hnp_polling_work(struct work_struct *work)
>  
>  	*fsm->host_req_flag = 0;
>  	/* Get host request flag from connected USB device */
> -	retval = usb_control_msg(udev,
> +	retval = hcd_ops->usb_control_msg(udev,
>  				usb_rcvctrlpipe(udev, 0),
>  				USB_REQ_GET_STATUS,
>  				USB_DIR_IN | USB_RECIP_DEVICE,
> @@ -177,7 +182,7 @@ static void otg_hnp_polling_work(struct work_struct *work)
>  	if (state == OTG_STATE_A_HOST) {
>  		/* Set b_hnp_enable */
>  		if (!otg->host->b_hnp_enable) {
> -			retval = usb_control_msg(udev,
> +			retval = hcd_ops->usb_control_msg(udev,
>  					usb_sndctrlpipe(udev, 0),
>  					USB_REQ_SET_FEATURE, 0,
>  					USB_DEVICE_B_HNP_ENABLE,
> @@ -256,7 +261,9 @@ static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>  		otg_loc_conn(otg, 0);
>  		otg_loc_sof(otg, 1);
>  		otg_set_protocol(fsm, PROTO_HOST);
> -		usb_bus_start_enum(otg->host, otg->host->otg_port);
> +		if (otg->hcd_ops && otg->hcd_ops->usb_bus_start_enum)
> +			otg->hcd_ops->usb_bus_start_enum(otg->host,
> +							 otg->host->otg_port);
>  		otg_start_hnp_polling(fsm);
>  		break;
>  	case OTG_STATE_A_IDLE:
> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
> index a18a2ee..39605d5 100644
> --- a/drivers/usb/phy/phy-fsl-usb.c
> +++ b/drivers/usb/phy/phy-fsl-usb.c
> @@ -792,6 +792,12 @@ static struct otg_fsm_ops fsl_otg_ops = {
>  	.start_gadget = fsl_otg_start_gadget,
>  };
>  
> +static struct otg_hcd_ops fsl_hcd_ops = {
> +	.usb_bus_start_enum = usb_bus_start_enum,
> +	.usb_control_msg = usb_control_msg,
> +	.usb_hub_find_child = usb_hub_find_child,
> +};
> +
>  /* Initialize the global variable fsl_otg_dev and request IRQ for OTG */
>  static int fsl_otg_conf(struct platform_device *pdev)
>  {
> @@ -821,6 +827,7 @@ static int fsl_otg_conf(struct platform_device *pdev)
>  	/* Set OTG state machine operations */
>  	fsl_otg_tc->otg.fsm.ops = &fsl_otg_ops;
>  	fsl_otg_tc->otg.fsm.dev = &pdev->dev;
> +	fsl_otg_tc->otg.hcd_ops = &fsl_hcd_ops;
>  
>  	/* initialize the otg structure */
>  	fsl_otg_tc->phy.label = DRIVER_DESC;
> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> index e8a14dc..85b8fb5 100644
> --- a/include/linux/usb/otg.h
> +++ b/include/linux/usb/otg.h
> @@ -12,6 +12,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/usb/phy.h>
>  #include <linux/usb/otg-fsm.h>
> +#include <linux/usb/hcd.h>
>  
>  struct usb_otg {
>  	u8			default_a;
> @@ -24,6 +25,7 @@ struct usb_otg {
>  
>  	enum usb_otg_state	state;
>  	struct otg_fsm fsm;
> +	struct otg_hcd_ops	*hcd_ops;
>  
>  	/* bind/unbind the host controller */
>  	int	(*set_host)(struct usb_otg *otg, struct usb_bus *host);
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
