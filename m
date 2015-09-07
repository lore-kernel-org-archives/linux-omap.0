From: Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v4 13/13] usb: otg: Add dual-role device (DRD) support
Date: Mon, 7 Sep 2015 15:53:48 +0800
Message-ID: <20150907075347.GB30578@shlinux2>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
 <1440422484-4737-14-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440422484-4737-14-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 24, 2015 at 04:21:24PM +0300, Roger Quadros wrote:
> DRD mode is a reduced functionality OTG mode. In this mode
> we don't support SRP, HNP and dynamic role-swap.
> 
> In DRD operation, the controller mode (Host or Peripheral)
> is decided based on the ID pin status. Once a cable plug (Type-A
> or Type-B) is attached the controller selects the state
> and doesn't change till the cable in unplugged and a different
> cable type is inserted.
> 
> As we don't need most of the complex OTG states and OTG timers
> we implement a lean DRD state machine in usb-otg.c.
> The DRD state machine is only interested in 2 hardware inputs
> 'id' and 'b_sess_vld'.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/common/usb-otg.c | 178 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/usb/otg-fsm.h  |   5 ++
>  include/linux/usb/otg.h      |   2 +
>  3 files changed, 177 insertions(+), 8 deletions(-)
> 

... ...

> +/* Called when entering a DRD state */
> +static void drd_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
> +{
> +	struct usb_otg *otgd = container_of(fsm, struct usb_otg, fsm);
> +
> +	if (fsm->otg->state == new_state)
> +		return;
> +
> +	fsm->state_changed = 1;
> +	dev_dbg(otgd->dev, "otg: set state: %s\n",
> +		usb_otg_state_string(new_state));
> +	switch (new_state) {
> +	case OTG_STATE_B_IDLE:
> +		drd_set_protocol(fsm, PROTO_UNDEF);

You didn't address this comment for your previous version.

otg_drv_vbus(fsm, 0);

> +		break;
> +	case OTG_STATE_B_PERIPHERAL:
> +		drd_set_protocol(fsm, PROTO_GADGET);

otg_drv_vbus(fsm, 0);

> +		break;
> +	case OTG_STATE_A_HOST:

otg_drv_vbus(fsm, 1);

> +		drd_set_protocol(fsm, PROTO_HOST);
> +		break;
> +	case OTG_STATE_UNDEFINED:
> +	case OTG_STATE_B_SRP_INIT:
> +	case OTG_STATE_B_WAIT_ACON:
> +	case OTG_STATE_B_HOST:
> +	case OTG_STATE_A_IDLE:
> +	case OTG_STATE_A_WAIT_VRISE:
> +	case OTG_STATE_A_WAIT_BCON:
> +	case OTG_STATE_A_SUSPEND:
> +	case OTG_STATE_A_PERIPHERAL:
> +	case OTG_STATE_A_WAIT_VFALL:
> +	case OTG_STATE_A_VBUS_ERR:
> +	default:
> +		dev_warn(otgd->dev, "%s: otg: invalid state: %s\n",
> +			 __func__, usb_otg_state_string(new_state));
> +		break;
> +	}
> +
> +	fsm->otg->state = new_state;
> +}
> +
... ...
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
