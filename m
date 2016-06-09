From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v10 08/14] usb: otg: add OTG/dual-role core
Date: Thu, 9 Jun 2016 15:34:31 +0300
Message-ID: <2522343c-422f-79e1-af40-eb953bde42f6@cogentembedded.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-9-git-send-email-rogerq@ti.com> <57592060.6060801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57592060.6060801@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 6/9/2016 10:53 AM, Roger Quadros wrote:

> It provides APIs for the following tasks
>
> - Registering an OTG/dual-role capable controller
> - Registering Host and Gadget controllers to OTG core
> - Providing inputs to and kicking the OTG state machine
>
> Provide a dual-role device (DRD) state machine.
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
> Signed-off-by: Roger Quadros <rogerq@ti.com>

[...]

> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
> new file mode 100644
> index 0000000..baebe5c
> --- /dev/null
> +++ b/drivers/usb/common/usb-otg.c
> @@ -0,0 +1,833 @@
[...]
> +/**
> + * Change USB protocol when there is a protocol change.
> + * fsm->lock must be held.
> + */

    If you're using the kernel-doc comment, please follow the rules.

> +static int drd_set_protocol(struct otg_fsm *fsm, int protocol)
[...]
> +/**
> + * Called when entering a DRD state.
> + * fsm->lock must be held.
> + */

    Same here.

> +static void drd_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
[...]
> +/**
> + * DRD state change judgement
> + *
> + * For DRD we're only interested in some of the OTG states
> + * i.e. OTG_STATE_B_IDLE: both peripheral and host are stopped
> + *	OTG_STATE_B_PERIPHERAL: peripheral active
> + *	OTG_STATE_A_HOST: host active
> + * we're only interested in the following inputs
> + *	fsm->id, fsm->b_sess_vld
> + */

    And here.

> +/**
> + * Dual-role device (DRD) work function
> + */

    And here.

> +static void usb_drd_work(struct work_struct *work)
> +{
> +	struct usb_otg *otg = container_of(work, struct usb_otg, work);
> +
> +	pm_runtime_get_sync(otg->dev);
> +	while (drd_statemachine(otg))
> +	;

    Indent it more please.

[...]
> +/**
> + * start/kick the OTG FSM if we can
> + * fsm->lock must be held
> + */

    Please follow the kernel-doc rules.

[...]
> +/**
> + * stop the OTG FSM. Stops Host & Gadget controllers as well.
> + * fsm->lock must be held
> + */

    Likewise.

[...]
> +/**
> + * usb_otg_sync_inputs - Sync OTG inputs with the OTG state machine
> + * @fsm:	OTG FSM instance

    Doesn't match the prototype.

> + *
> + * Used by the OTG driver to update the inputs to the OTG
> + * state machine.
> + *
> + * Can be called in IRQ context.
> + */
> +void usb_otg_sync_inputs(struct usb_otg *otg)
[...]
> +/**
> + * usb_otg_register_gadget - Register the gadget controller to OTG core
> + * @gadget:	gadget controller

    We call that USB device controller (UDC). I'm not sure what you meant here...
    And what about the 2nd arg, 'ops'?

[...]
> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> index 85b8fb5..5d4850a 100644
> --- a/include/linux/usb/otg.h
> +++ b/include/linux/usb/otg.h
> @@ -10,10 +10,68 @@
>  #define __LINUX_USB_OTG_H
>
>  #include <linux/phy/phy.h>
> -#include <linux/usb/phy.h>
> -#include <linux/usb/otg-fsm.h>
> +#include <linux/device.h>
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

    IRQ?

> + * @ops: otg to host controller interface
> + * @ops: otg to host controller interface

    Once is enough. :-)

> + * @otg_dev: otg controller device

    OTG?

> +/**
> + * struct usb_otg - usb otg controller state
> + *
> + * @default_a: Indicates we are an A device. i.e. Host.
> + * @phy: USB phy interface

    PHY?

> + * @usb_phy: old usb_phy interface
> + * @host: host controller bus
> + * @gadget: gadget device
> + * @state: current otg state
> + * @dev: otg controller device
> + * @caps: otg capabilities revision, hnp, srp, etc
> + * @fsm: otg finite state machine

    OTG?

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
[...]
> @@ -42,26 +116,101 @@ struct usb_otg {
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

    OTG FSM?

> + * @otg_work: optional custom otg state machine work function

    OTG?

>   */

[...]

    Phew, that was a long patch... normally I don't review the patches that 
are such big. :-)

MBR, Sergei
