From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Tue, 26 Apr 2016 02:07:56 +0000
Message-ID: <AM4PR04MB213045DC3D1C1D67A7D9AF0689630@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-8-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459865117-7032-8-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger

> -----Original Message-----
> From: Roger Quadros [mailto:rogerq@ti.com]
> Sent: Tuesday, April 05, 2016 10:05 PM
> To: stern@rowland.harvard.edu; balbi@kernel.org;
> gregkh@linuxfoundation.org; peter.chen@freescale.com
> Cc: dan.j.williams@intel.com; jun.li@freescale.com;
> mathias.nyman@linux.intel.com; tony@atomide.com; Joao.Pinto@synopsys.com;
> abrestic@chromium.org; r.baldyga@samsung.com; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-omap@vger.kernel.org; Roger Quadros
> <rogerq@ti.com>
> Subject: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
> 
> It provides APIs for the following tasks
> 
> - Registering an OTG/dual-role capable controller
> - Registering Host and Gadget controllers to OTG core
> - Providing inputs to and kicking the OTG state machine
> 
> Provide a dual-role device (DRD) state machine.
> DRD mode is a reduced functionality OTG mode. In this mode we don't
> support SRP, HNP and dynamic role-swap.
> 
> In DRD operation, the controller mode (Host or Peripheral) is decided
> based on the ID pin status. Once a cable plug (Type-A or Type-B) is
> attached the controller selects the state and doesn't change till the
> cable in unplugged and a different cable type is inserted.
> 
> As we don't need most of the complex OTG states and OTG timers we
> implement a lean DRD state machine in usb-otg.c.
> The DRD state machine is only interested in 2 hardware inputs 'id' and
> 'b_sess_vld'.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---

...

> +/**
> + * Register pending host/gadget and remove entry from wait list  */
> +static void usb_otg_flush_wait(struct device *otg_dev) {
> +	struct otg_wait_data *wait;
> +	struct otg_hcd *host;
> +	struct otg_gcd *gadget;
> +
> +	mutex_lock(&wait_list_mutex);
> +
> +	wait = usb_otg_get_wait(otg_dev);
> +	if (!wait)
> +		goto done;
> +
> +	dev_dbg(otg_dev, "otg: registering pending host/gadget\n");
> +	gadget = &wait->gcd;
> +	if (gadget)

If (gadget->gadget)

> +		usb_otg_register_gadget(gadget->gadget, gadget->ops);
> +
> +	host = &wait->primary_hcd;
> +	if (host->hcd)
> +		usb_otg_register_hcd(host->hcd, host->irqnum, host->irqflags,
> +				     host->ops);
> +
> +	host = &wait->shared_hcd;
> +	if (host->hcd)
> +		usb_otg_register_hcd(host->hcd, host->irqnum, host->irqflags,
> +				     host->ops);
> +
> +	list_del(&wait->list);
> +	kfree(wait);
> +
> +done:
> +	mutex_unlock(&wait_list_mutex);
> +}
> +
> +/**
> + * Check if the OTG device is in our OTG list and return
> + * usb_otg data, else NULL.
> + *
> + * otg_list_mutex must be held.
> + */
> +static struct usb_otg *usb_otg_get_data(struct device *otg_dev) {
> +	struct usb_otg *otg;
> +
> +	if (!otg_dev)
> +		return NULL;
> +
> +	list_for_each_entry(otg, &otg_list, list) {
> +		if (otg->dev == otg_dev)
> +			return otg;
> +	}
> +
> +	return NULL;
> +}

Could you export it to be a public API, we may need access usb_otg
in common host driver for handling of enumeration of otg test device.

...

> +/**
> + * Called when entering a DRD state.
> + * fsm->lock must be held.
> + */
> +static void drd_set_state(struct otg_fsm *fsm, enum usb_otg_state
> +new_state) {
> +	struct usb_otg *otg = container_of(fsm, struct usb_otg, fsm);
> +
> +	if (otg->state == new_state)
> +		return;
> +
> +	fsm->state_changed = 1;
> +	dev_dbg(otg->dev, "otg: set state: %s\n",
> +		usb_otg_state_string(new_state));
> +	switch (new_state) {
> +	case OTG_STATE_B_IDLE:
> +		drd_set_protocol(fsm, PROTO_UNDEF);
> +		otg_drv_vbus(otg, 0);
> +		break;
> +	case OTG_STATE_B_PERIPHERAL:
> +		drd_set_protocol(fsm, PROTO_GADGET);
> +		otg_drv_vbus(otg, 0);
> +		break;
> +	case OTG_STATE_A_HOST:
> +		drd_set_protocol(fsm, PROTO_HOST);
> +		otg_drv_vbus(otg, 1);
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

Remove above unused states.

> +	default:
> +		dev_warn(otg->dev, "%s: otg: invalid state: %s\n",
> +			 __func__, usb_otg_state_string(new_state));
> +		break;
> +	}
> +
> +	otg->state = new_state;
> +}
> +
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
> +int drd_statemachine(struct usb_otg *otg) {
> +	struct otg_fsm *fsm = &otg->fsm;
> +	enum usb_otg_state state;
> +	int ret;
> +
> +	mutex_lock(&fsm->lock);
> +
> +	fsm->state_changed = 0;
> +	state = otg->state;
> +
> +	switch (state) {
> +	case OTG_STATE_UNDEFINED:
> +		if (!fsm->id)
> +			drd_set_state(fsm, OTG_STATE_A_HOST);
> +		else if (fsm->id && fsm->b_sess_vld)
> +			drd_set_state(fsm, OTG_STATE_B_PERIPHERAL);
> +		else
> +			drd_set_state(fsm, OTG_STATE_B_IDLE);
> +		break;
> +	case OTG_STATE_B_IDLE:
> +		if (!fsm->id)
> +			drd_set_state(fsm, OTG_STATE_A_HOST);
> +		else if (fsm->b_sess_vld)
> +			drd_set_state(fsm, OTG_STATE_B_PERIPHERAL);
> +		break;
> +	case OTG_STATE_B_PERIPHERAL:
> +		if (!fsm->id)
> +			drd_set_state(fsm, OTG_STATE_A_HOST);
> +		else if (!fsm->b_sess_vld)
> +			drd_set_state(fsm, OTG_STATE_B_IDLE);
> +		break;
> +	case OTG_STATE_A_HOST:
> +		if (fsm->id && fsm->b_sess_vld)
> +			drd_set_state(fsm, OTG_STATE_B_PERIPHERAL);
> +		else if (fsm->id && !fsm->b_sess_vld)
> +			drd_set_state(fsm, OTG_STATE_B_IDLE);
> +		break;
> +
> +	/* invalid states for DRD */
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

Remove above unused states and add a default:

> +		dev_err(otg->dev, "%s: otg: invalid usb-drd state: %s\n",
> +			__func__, usb_otg_state_string(state));
> +		drd_set_state(fsm, OTG_STATE_UNDEFINED);
> +	break;
> +	}
> +
> +	ret = fsm->state_changed;
> +	mutex_unlock(&fsm->lock);
> +	dev_dbg(otg->dev, "otg: quit statemachine, changed %d\n",
> +		fsm->state_changed);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(drd_statemachine);
> +
> +/**
> + * OTG FSM/DRD work function

DRD work function

> + */
> +static void usb_otg_work(struct work_struct *work) {

usb_drd_work() name is better as it's only for drd.

> +	struct usb_otg *otg = container_of(work, struct usb_otg, work);
> +
> +	pm_runtime_get_sync(otg->dev);
> +	drd_statemachine(otg);
> +	pm_runtime_put_sync(otg->dev);
> +}
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
> +
> +	if ((otg->caps->hnp_support || otg->caps->srp_support ||
> +	     otg->caps->adp_support) && !config->otg_work)
> +		dev_info(dev, "otg: limiting to dual-role\n");

dev_err, this should be an error.

> +
> +	if (config->otg_work)	/* custom otg_work ? */
> +		INIT_WORK(&otg->work, config->otg_work);
> +	else
> +		INIT_WORK(&otg->work, usb_otg_work);
> +
> +	otg->wq = create_singlethread_workqueue("usb_otg");
> +	if (!otg->wq) {
> +		dev_err(dev, "otg: %s: can't create workqueue\n",
> +			__func__);
> +		ret = -ENOMEM;
> +		goto err_wq;
> +	}
> +
> +	/* set otg ops */
> +	otg->fsm.ops = config->fsm_ops;
> +
> +	mutex_init(&otg->fsm.lock);
> +
> +	list_add_tail(&otg->list, &otg_list);
> +	mutex_unlock(&otg_list_mutex);
> +
> +	/* were we in wait list? */
> +	mutex_lock(&wait_list_mutex);
> +	wait = usb_otg_get_wait(dev);
> +	mutex_unlock(&wait_list_mutex);
> +	if (wait) {
> +		/* register pending host/gadget and flush from list */
> +		usb_otg_flush_wait(dev);
> +	}
> +
> +	return otg;
> +
> +err_wq:
> +	kfree(otg);
> +unlock:
> +	mutex_unlock(&otg_list_mutex);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_register);
> +
