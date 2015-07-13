From: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v3 03/11] usb: otg-fsm: Prevent build warning "VDBG"
 redefined
Date: Mon, 13 Jul 2015 09:52:36 +0800
Message-ID: <20150713015235.GB27710@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <1436350777-28056-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436350777-28056-4-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 08, 2015 at 01:19:29PM +0300, Roger Quadros wrote:
> If usb/otg-fsm.h and usb/composite.h are included together
> then it results in the build warning [1].
> 
> Prevent that by using dev_vdbg() instead.
> 
> Also get rid of MPC_LOC which doesn't seem to be used
> by anyone.
> 
> [1] - warning fixed by this patch:
> 
>    In file included from drivers/usb/dwc3/core.h:33,
>                     from drivers/usb/dwc3/ep0.c:33:
>    include/linux/usb/otg-fsm.h:30:1: warning: "VDBG" redefined
>    In file included from drivers/usb/dwc3/ep0.c:31:
>    include/linux/usb/composite.h:615:1: warning: this is the location
> 	of the previous definition
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/chipidea/otg_fsm.c   |  1 +
>  drivers/usb/common/usb-otg-fsm.c | 12 +++++++-----
>  drivers/usb/phy/phy-fsl-usb.c    |  1 +
>  include/linux/usb/otg-fsm.h      | 19 ++++---------------
>  4 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
> index 19d655a..6e67f94 100644
> --- a/drivers/usb/chipidea/otg_fsm.c
> +++ b/drivers/usb/chipidea/otg_fsm.c
> @@ -777,6 +777,7 @@ int ci_hdrc_otg_fsm_init(struct ci_hdrc *ci)
>  	ci->fsm.id = hw_read_otgsc(ci, OTGSC_ID) ? 1 : 0;
>  	ci->fsm.otg->state = OTG_STATE_UNDEFINED;
>  	ci->fsm.ops = &ci_otg_ops;
> +	ci->fsm.dev = ci->dev;
>  
>  	mutex_init(&ci->fsm.lock);
>  
> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
> index 42c6376..1873eb3 100644
> --- a/drivers/usb/common/usb-otg-fsm.c
> +++ b/drivers/usb/common/usb-otg-fsm.c
> @@ -36,8 +36,9 @@ static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
>  	int ret = 0;
>  
>  	if (fsm->protocol != protocol) {
> -		VDBG("Changing role fsm->protocol= %d; new protocol= %d\n",
> -			fsm->protocol, protocol);
> +		dev_vdbg(fsm->dev,
> +			 "Changing role fsm->protocol= %d; new protocol= %d\n",
> +			 fsm->protocol, protocol);
>  		/* stop old protocol */
>  		if (fsm->protocol == PROTO_HOST)
>  			ret = otg_start_host(fsm, 0);
> @@ -124,7 +125,7 @@ static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>  	fsm->state_changed = 1;
>  	if (fsm->otg->state == new_state)
>  		return 0;
> -	VDBG("Set state: %s\n", usb_otg_state_string(new_state));
> +	dev_vdbg(fsm->dev, "Set state: %s\n", usb_otg_state_string(new_state));
>  	otg_leave_state(fsm, fsm->otg->state);
>  	switch (new_state) {
>  	case OTG_STATE_B_IDLE:
> @@ -251,7 +252,7 @@ int otg_statemachine(struct otg_fsm *fsm)
>  
>  	switch (state) {
>  	case OTG_STATE_UNDEFINED:
> -		VDBG("fsm->id = %d\n", fsm->id);
> +		dev_vdbg(fsm->dev, "fsm->id = %d\n", fsm->id);
>  		if (fsm->id)
>  			otg_set_state(fsm, OTG_STATE_B_IDLE);
>  		else
> @@ -359,7 +360,8 @@ int otg_statemachine(struct otg_fsm *fsm)
>  	}
>  	mutex_unlock(&fsm->lock);
>  
> -	VDBG("quit statemachine, changed = %d\n", fsm->state_changed);
> +	dev_vdbg(fsm->dev, "quit statemachine, changed = %d\n",
> +		 fsm->state_changed);
>  	return fsm->state_changed;
>  }
>  EXPORT_SYMBOL_GPL(otg_statemachine);
> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
> index 94eb292..ee3f2c2 100644
> --- a/drivers/usb/phy/phy-fsl-usb.c
> +++ b/drivers/usb/phy/phy-fsl-usb.c
> @@ -817,6 +817,7 @@ static int fsl_otg_conf(struct platform_device *pdev)
>  
>  	/* Set OTG state machine operations */
>  	fsl_otg_tc->fsm.ops = &fsl_otg_ops;
> +	fsl_otg_tc->fsm.dev = &pdev->dev;
>  
>  	/* initialize the otg structure */
>  	fsl_otg_tc->phy.label = DRIVER_DESC;
> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
> index 243274f..c631dde 100644
> --- a/include/linux/usb/otg-fsm.h
> +++ b/include/linux/usb/otg-fsm.h
> @@ -18,24 +18,10 @@
>  #ifndef __LINUX_USB_OTG_FSM_H
>  #define __LINUX_USB_OTG_FSM_H
>  
> +#include <linux/device.h>
>  #include <linux/mutex.h>
>  #include <linux/errno.h>
>  
> -#undef VERBOSE
> -
> -#ifdef VERBOSE
> -#define VDBG(fmt, args...) pr_debug("[%s]  " fmt , \
> -				 __func__, ## args)
> -#else
> -#define VDBG(stuff...)	do {} while (0)
> -#endif
> -
> -#ifdef VERBOSE
> -#define MPC_LOC printk("Current Location [%s]:[%d]\n", __FILE__, __LINE__)
> -#else
> -#define MPC_LOC do {} while (0)
> -#endif
> -
>  #define PROTO_UNDEF	(0)
>  #define PROTO_HOST	(1)
>  #define PROTO_GADGET	(2)
> @@ -195,6 +181,9 @@ struct otg_fsm {
>  	int protocol;
>  	struct mutex lock;
>  	bool state_changed;
> +
> +	/* for debug prints */
> +	struct device *dev;
>  };
>  
>  struct otg_fsm_ops {
> -- 
> 2.1.4
> 

Acked-by: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
