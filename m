From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v8 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 24 May 2016 12:45:46 +0300
Message-ID: <574422CA.8080002@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-9-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463133808-10630-9-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter.chen@freescale.com
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

I have one question here. Please see below.

On 13/05/16 13:03, Roger Quadros wrote:
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
> ---
>  drivers/usb/common/Makefile  |    2 +-
>  drivers/usb/common/usb-otg.c | 1042 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/core/Kconfig     |    4 +-
>  include/linux/usb/gadget.h   |    2 +
>  include/linux/usb/hcd.h      |    1 +
>  include/linux/usb/otg-fsm.h  |    7 +
>  include/linux/usb/otg.h      |  154 ++++++-
>  7 files changed, 1206 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/usb/common/usb-otg.c
> 

<snip>

> +
> +/**
> + * usb_otg_register() - Register the OTG/dual-role device to OTG core
> + * @dev: OTG/dual-role controller device.
> + * @config: OTG configuration.
> + *
> + * Registers the OTG/dual-role controller device with the USB OTG core.
> + *
> + * Return: struct usb_otg * if success, ERR_PTR() if error.
> + */
> +struct usb_otg *usb_otg_register(struct device *dev,
> +				 struct usb_otg_config *config)
> +{
> +	struct usb_otg *otg;
> +	struct otg_wait_data *wait;
> +	int ret = 0;
> +
> +	if (!dev || !config || !config->fsm_ops)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* already in list? */
> +	mutex_lock(&otg_list_mutex);
> +	if (usb_otg_get_data(dev)) {
> +		dev_err(dev, "otg: %s: device already in otg list\n",
> +			__func__);
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	/* allocate and add to list */
> +	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
> +	if (!otg) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	otg->dev = dev;
> +	otg->caps = config->otg_caps;

Here, we should be checking if user needs to disable any OTG features. So,

	if (dev->of_node)
		of_usb_update_otg_caps(dev->of_node, &otg->caps);

Do you agree?
This means we need to change otg->caps from 'struct usb_otg_caps *caps;'
to 'struct usb_otg_caps caps;' so that we can modify the local copy instead
of the one passed by the OTG controller.

We can also move of_usb_update_otg_caps() to otg.h.

We will also need to modify the udc-core code so that it sets gadget->otg_caps
to the modified otg_caps from the OTG core. This will ensure that the right
OTG descriptors are sent.

So we will have to introduce an API.

struct usb_otg_caps *usb_otg_get_otg_caps(struct device *otg_dev)

And in udc-core.c,

static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
{
..
        ret = driver->bind(udc->gadget, driver);
        if (ret)
                goto err1;

        /* If OTG, the otg core starts the UDC when needed */
        if (udc->gadget->otg_dev) {
+		udc->gadget->is_otg = true;
+		udc->gadget->otg_caps = usb_otg_get_otg_caps(udc->gadget->otg_dev);
                mutex_unlock(&udc_lock);
                usb_otg_register_gadget(udc->gadget, &otg_gadget_intf);
                mutex_lock(&udc_lock);
        } else {
                ret = usb_gadget_udc_start(udc);
                if (ret) {
                        driver->unbind(udc->gadget);
                        goto err1;
                }
                usb_udc_connect_control(udc);
        }
..
}

What do you say?

regards,
-roger
