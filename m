From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 07/11] usb: otg: add OTG core
Date: Mon, 27 Jul 2015 13:03:04 +0300
Message-ID: <55B601D8.3080702@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com> <1436350777-28056-8-git-send-email-rogerq@ti.com> <20150717074832.GA4515@shlinux2> <55A8EFBA.1000504@ti.com> <20150721105159.GA8903@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150721105159.GA8903@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Jun <b47624@freescale.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 21/07/15 13:52, Li Jun wrote:
> Hi,
> 
> [...]
> 
>>>> +	otg_timer_init(A_WAIT_ENUM, otgd, set_tmout, TB_SRP_FAIL, NULL);
>>>
>>> 2 timers are missing: B_DATA_PLS, B_SSEND_SRP.
>>
>> Those 2 are not used by usb-otg-fsm.c. We can add it when usb-otg-fsm.c is updated.
>>
> 
> ok.
> 
>>>
>>>> +}
> 
> [...]
> 
>>>> +
>>>> +/**
>>>> + * OTG FSM ops function to start/stop host
>>>> + */
>>>> +static int usb_otg_start_host(struct otg_fsm *fsm, int on)
>>>> +{
>>>> +	struct otg_data *otgd = container_of(fsm, struct otg_data, fsm);
>>>> +	struct otg_hcd_ops *hcd_ops;
>>>> +
>>>> +	dev_dbg(otgd->dev, "otg: %s %d\n", __func__, on);
>>>> +	if (!fsm->otg->host) {
>>>> +		WARN_ONCE(1, "otg: fsm running without host\n");
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	if (on) {
>>>> +		/* OTG device operations */
>>>> +		if (otgd->start_host)
>>>> +			otgd->start_host(fsm, on);
>>>> +
>>>> +		/* start host */
>>>> +		hcd_ops = otgd->primary_hcd.ops;
>>>> +		hcd_ops->add(otgd->primary_hcd.hcd, otgd->primary_hcd.irqnum,
>>>> +			     otgd->primary_hcd.irqflags);
>>>> +		if (otgd->shared_hcd.hcd) {
>>>> +			hcd_ops = otgd->shared_hcd.ops;
>>>> +			hcd_ops->add(otgd->shared_hcd.hcd,
>>>> +				     otgd->shared_hcd.irqnum,
>>>> +				     otgd->shared_hcd.irqflags);
>>>> +		}
>>>> +	} else {
>>>> +		/* stop host */
>>>> +		if (otgd->shared_hcd.hcd) {
>>>> +			hcd_ops = otgd->shared_hcd.ops;
>>>> +			hcd_ops->remove(otgd->shared_hcd.hcd);
>>>> +		}
>>>> +		hcd_ops = otgd->primary_hcd.ops;
>>>> +		hcd_ops->remove(otgd->primary_hcd.hcd);
>>>> +
>>>> +		/* OTG device operations */
>>>> +		if (otgd->start_host)
>>>> +			otgd->start_host(fsm, on);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>>> I do not see much benefit by this override function, usb_add/remove_hcd
>>> can be simply included by controller's start_host function, also there
>>> maybe some additional operations after usb_add_hcd, but this override
>>> function limit usb_add_hcd() is the last step.
>>
>> I had tried host start/stop way before but Alan's suggestion was to use
>> bind/unbind the host controller completely as that is much simpler
>>
>> [1] http://article.gmane.org/gmane.linux.usb.general/123842
>>
> 
> I did not mean host start/stop in your first version, I agree using
> usb_add/remove_hcd() for simple.
> 
>>>
>>> Maybe your intention is to make usb_add_hcd is the only operation required
>>> to start host, so ideally controller driver need not define its start_host
>>> routine for this otg ops, I am not sure if this can work for different otg
>>
>> Yes that was the intention.
>>
>>> platforms. If the shared code is only usb_add/remove_hcd(), maybe leave this
>>> ops defined by controller driver can make core code simple and give flexibility
>>> to controller drivers.
>>
>> We don't completely override start/stop_host(). The flexibility is still there.
>> We call controllers start_host(1) before starting the controller and controllers
>> start_host(0) after stopping the controller.
>> So the the controller can still do what they want in otg_fsm_ops.start_host/gadget().
>>
> 
> But if controller driver wants to do something after usb_otg_add_hcd(),
> it's impossible with your current usb_otg_start_host().

Agree with that point. I can't forsee if any driver will need to do that but
we don't want to limit it so i'll consider your point of letting the controller drivers
do whatever they want in start/stop ops.

I can move the existing starts/stop to a library function so they can re-use it if they
don't want anything special.

> 
>> The OTG core only takes care of actually starting/stopping the host controller.
>>
>> If we don't do that then the code in usb_otg_start_host() has to be pasted
>> in every OTG controller driver. This is code duplication.
>>
> 
> Actually the only duplication code may be a function call to original
> usb_add/remove_hcd().

For USB hosts having primary and shared controllers it is not that simple
but they can use the library function in that case.

> 
>>>
>>>> +
>>>> +/**
>>>> + * OTG FSM ops function to start/stop gadget
>>>> + */
>>>> +static int usb_otg_start_gadget(struct otg_fsm *fsm, int on)
>>>> +{
>>>> +	struct otg_data *otgd = container_of(fsm, struct otg_data, fsm);
>>>> +	struct usb_gadget *gadget = fsm->otg->gadget;
>>>> +
>>>> +	dev_dbg(otgd->dev, "otg: %s %d\n", __func__, on);
>>>> +	if (!gadget) {
>>>> +		WARN_ONCE(1, "otg: fsm running without gadget\n");
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	if (on) {
>>>> +		/* OTG device operations */
>>>> +		if (otgd->start_gadget)
>>>> +			otgd->start_gadget(fsm, on);
>>>> +
>>>> +		otgd->gadget_ops->start(fsm->otg->gadget);
>>>> +	} else {
>>>> +		otgd->gadget_ops->stop(fsm->otg->gadget);
>>>> +
>>>> +		/* OTG device operations */
>>>> +		if (otgd->start_gadget)
>>>> +			otgd->start_gadget(fsm, on);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * OTG FSM work function
>>>> + */
>>>> +static void usb_otg_work(struct work_struct *work)
>>>> +{
>>>> +	struct otg_data *otgd = container_of(work, struct otg_data, work);
>>>> +
>>>> +	otg_statemachine(&otgd->fsm);
>>>
>>> Need consider runtime pm, or you want to rely on controller driver take
>>> care of it?
>>
>> For simplicity let's say that controller driver takes care of it.
>>
> 
> Then controller driver need add runtime pm for every otg fsm ops.
> 
> Code like below can make it simple:
> runtime_pm_get_sync(otgd->dev);
> otg_statemachine(&otgd->fsm);
> runtime_pm_get_put(otgd->dev);

That can be done.
> 
> There is another problem, otg work will only do one state transition, but
> in some cases we may need successive state transitions.  

How can we fix this?

> 
>>>
>>>> +}
>>>> +
>>>> +/**
>>>> + * usb_otg_register() - Register the OTG device to OTG core
>>>> + * @parent_device:	parent device of Host & Gadget controllers.
>>>> + * @otg_fsm_ops:	otg state machine ops.
>>>> + *
> 
> [...]
> 
>>>> +/**
>>>> + * start/kick the OTG FSM if we can
>>>> + * fsm->lock must be held
>>>> + */
>>>> +static void usb_otg_start_fsm(struct otg_fsm *fsm)
>>>> +{
>>>> +	struct otg_data *otgd = container_of(fsm, struct otg_data, fsm);
>>>> +
>>>> +	if (otgd->fsm_running)
>>>> +		goto kick_fsm;
>>>> +
>>>> +	if (!fsm->otg->host) {
>>>> +		dev_info(otgd->dev, "otg: can't start till host registers\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>
>>> This cannot work, fsm->otg->host is set in usb_otg_register_hcd(), which is
>>> called by usb_add_hcd(), but usb_add_hcd() should be called only if otg fsm
>>> already started to some A-device state, deadlock.
>>
>> I've changed usb_add_hcd() behaviour. Now usb_otg_add_hcd() does the real work of adding
>> the hcd. usb_add_hcd() prevents the add if it is an otg hcd and just registers
>> with OTG core.
>>
> 
> So you expect the controller driver still call usb_add_hcd() before otg fsm
> start, in which it only registers the created hcd with OTG core.

Yes.
> 
>>>
>>>> +	if (!fsm->otg->gadget) {
>>>> +		dev_info(otgd->dev, "otg: can't start till gadget registers\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	otgd->fsm_running = true;
>>>> +kick_fsm:
>>>> +	queue_work(otgd->wq, &otgd->work);
>>>> +}
>>>> +
> 
> [...]
> 
>>>> +
>>>> +/**
>>>> + * usb_otg_register_hcd - Register Host controller to OTG core
>>>> + * @hcd:	Host controller device
>>>> + * @irqnum:	interrupt number
>>>> + * @irqflags:	interrupt flags
>>>> + * @ops:	HCD ops to add/remove the HCD
>>>> + *
>>>> + * This is used by the USB Host stack to register the Host controller
>>>> + * to the OTG core. Host controller must not be started by the
>>>> + * caller as it is left upto the OTG state machine to do so.
>>>> + *
>>>> + * Returns: 0 on success, error value otherwise.
>>>> + */
>>>> +int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>>>> +			 unsigned long irqflags, struct otg_hcd_ops *ops)
>>>> +{
>>>> +	struct otg_data *otgd;
>>>> +	struct device *otg_dev = hcd->self.controller->parent;
>>>> +
> 
> I see normally we directly use controller dev for hcd->self.controller,
> usb_create_hcd(... struct device *dev, ...)
> {
> 	... ...
> 	hcd->self.controller = dev;
> 	... ...
> }
> 
> For register gadget, it's okay since:
> int usb_add_gadget_udc_release(struct device *parent, ...)
> {
> 	... ...
> 	gadget->dev.parent = parent;
> 	... ...
> }
> 
> So we need parent dev for usb_otg_register(struct device *dev,...), and child dev
> for usb_create_hcd(struct device *dev,...)? dwc3 is designed like this?

Yes. But as we discussed in the cover letter this parent child relationship
doesn't need to be a requirement for device tree case.

> 
>>>> +	mutex_lock(&otg_list_mutex);
>>>> +	otgd = usb_otg_device_get_otgd(otg_dev);
>>>> +	if (!otgd) {
>>>> +		dev_dbg(otg_dev, "otg: %s: device not registered to otg core\n",
>>>> +			__func__);
>>>> +		mutex_unlock(&otg_list_mutex);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	mutex_unlock(&otg_list_mutex);
>>>> +	/* HCD will be started by OTG fsm when needed */
>>>> +	mutex_lock(&otgd->fsm.lock);
>>>> +	if (otgd->primary_hcd.hcd) {
>>>> +		/* probably a shared HCD ? */
>>>> +		if (usb_otg_hcd_is_primary_hcd(hcd)) {
>>>> +			dev_err(otg_dev, "otg: primary host already registered\n");
>>>> +			goto err;
>>>> +		}
>>>> +
>>>> +		if (hcd->shared_hcd == otgd->primary_hcd.hcd) {
>>>> +			if (otgd->shared_hcd.hcd) {
>>>> +				dev_err(otg_dev, "otg: shared host already registered\n");
>>>> +				goto err;
>>>> +			}
>>>> +
>>>> +			otgd->shared_hcd.hcd = hcd;
>>>> +			otgd->shared_hcd.irqnum = irqnum;
>>>> +			otgd->shared_hcd.irqflags = irqflags;
>>>> +			otgd->shared_hcd.ops = ops;
>>>> +			dev_info(otg_dev, "otg: shared host %s registered\n",
>>>> +				 dev_name(hcd->self.controller));
>>>> +		} else {
>>>> +			dev_err(otg_dev, "otg: invalid shared host %s\n",
>>>> +				dev_name(hcd->self.controller));
>>>> +			goto err;
>>>> +		}
>>>> +	} else {
>>>> +		if (!usb_otg_hcd_is_primary_hcd(hcd)) {
>>>> +			dev_err(otg_dev, "otg: primary host must be registered first\n");
>>>> +			goto err;
>>>> +		}
>>>> +
>>>> +		otgd->primary_hcd.hcd = hcd;
>>>> +		otgd->primary_hcd.irqnum = irqnum;
>>>> +		otgd->primary_hcd.irqflags = irqflags;
>>>> +		otgd->primary_hcd.ops = ops;
>>>> +		dev_info(otg_dev, "otg: primary host %s registered\n",
>>>> +			 dev_name(hcd->self.controller));
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * we're ready only if we have shared HCD
>>>> +	 * or we don't need shared HCD.
>>>> +	 */
>>>> +	if (otgd->shared_hcd.hcd || !otgd->primary_hcd.hcd->shared_hcd) {
>>>> +		otgd->fsm.otg->host = hcd_to_bus(hcd);
>>>> +		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
>>>> +
>>>> +		/* start FSM */
>>>> +		usb_otg_start_fsm(&otgd->fsm);
>>>
>>> usb_otg_register_hcd() is called before usb_otg_add_hcd(), start fsm on
>>> this point can make sense since hcd has not been added?
>>
>> for OTG/DRD HCD case:
>> - usb_add_hcd() does not really ADD (or START) the HCD. It just registers with OTG core.
>> - FSM takes care of ADDing (or STARTing) the HCD when it wants using the
>> usb_otg_add_hcd() call.
> 
> Understood.
> 
>> - FSM does not need HCD to be already added. It just needs it to be registered.
> 
> My point is only registering hcd to OTG core cannot be a valid *input* to make
> otg fsm state can be changed, so it's making no sense to call usb_otg_start_fsm(),
> but it's no harm.
> 
>> It takes care of strting it when it wants to.
>>
> 
> Any otg fsm state change(or start it to make its state change) need some otg fsm
> input or variables change happen.

Yes but the OTG FSM can't start till all the resources it needs are available.
i.e. both host and gadget controllers are ready.

> 
>>>
>>>> +	} else {
>>>> +		dev_dbg(otg_dev, "otg: can't start till shared host registers\n");
>>>> +	}
>>>> +
>>>> +	mutex_unlock(&otgd->fsm.lock);
>>>> +
>>>> +	return 0;
>>>> +
>>>> +err:
>>>> +	mutex_unlock(&otgd->fsm.lock);
>>>> +	return -EINVAL;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(usb_otg_register_hcd);
> 
> [...]
> 
>>>> +#define TB_ASE0_BRST         (155)	/* minimum 155 ms, section:5.3.1 */
>>>> +/* SE0 Time Before SRP */
>>>> +#define TB_SE0_SRP           (1000)	/* b_idle,minimum 1s, section:5.1.2 */
>>>> +/* SSEND time before SRP */
>>>> +#define TB_SSEND_SRP         (1500)	/* minimum 1.5 sec, section:5.1.2 */
>>>> +
>>>> +#define TB_SESS_VLD          (1000)
>>>> +
>>>
>>> All otg timer timeout value should be in some *range* defined by otg spec,
>>> not some specific value, I don't think one specific value can meet all otg
>>> platforms, so we need find a way to make those value can be configured by
>>> controller drivers.
>>
>> OK. How about introducing 'struct usb_otg_config' which must be passed
>> to usb_otg_register().
>>
> 
> I think it's okay.
>  
>> /* otg controller configuration */
>> struct usb_otg_config {
>> 	/* OTG caps */
>> 	struct usb_otg_caps otg_caps;
> 
> You can use a pointer to avoid data copy.

OK.

> 
>>
>> 	/* OTG Timer timeouts in ms. If 0, sane default will be used */
>> 	int ta_wait_vrise;
>> 	...
>> };
>>

cheers,
-roger
