From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 07/13] usb: otg: add OTG core
Date: Wed, 9 Sep 2015 13:01:14 +0300
Message-ID: <55F0036A.60403@ti.com>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
 <1440422484-4737-8-git-send-email-rogerq@ti.com>
 <20150907074002.GA30578@shlinux2> <55ED6C9F.2000502@ti.com>
 <20150909062006.GB812@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150909062006.GB812@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/09/15 09:20, Li Jun wrote:
> On Mon, Sep 07, 2015 at 01:53:19PM +0300, Roger Quadros wrote:
>> On 07/09/15 10:40, Li Jun wrote:
>>> On Mon, Aug 24, 2015 at 04:21:18PM +0300, Roger Quadros wrote:
>>>> The OTG core instantiates the OTG Finite State Machine
>>>> per OTG controller and manages starting/stopping the
>>>> host and gadget controllers based on the bus state.
>>>>
>>>> It provides APIs for the following tasks
>>>>
>>>> - Registering an OTG capable controller
>>>> - Registering Host and Gadget controllers to OTG core
>>>> - Providing inputs to and kicking the OTG state machine
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>>  MAINTAINERS                  |    4 +-
>>>>  drivers/usb/Kconfig          |    2 +-
>>>>  drivers/usb/Makefile         |    1 +
>>>>  drivers/usb/common/Makefile  |    3 +-
>>>>  drivers/usb/common/usb-otg.c | 1061 ++++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/usb/common/usb-otg.h |   71 +++
>>>>  drivers/usb/core/Kconfig     |   11 +-
>>>>  include/linux/usb/otg.h      |  189 +++++++-
>>>>  8 files changed, 1321 insertions(+), 21 deletions(-)
>>>>  create mode 100644 drivers/usb/common/usb-otg.c
>>>>  create mode 100644 drivers/usb/common/usb-otg.h
>>>>
>>>
>>> ... ...
>>>
>>>> +
>>>> +/**
>>>> + * Get OTG device from host or gadget device.
>>>> + *
>>>> + * For non device tree boot, the OTG controller is assumed to be
>>>> + * the parent of the host/gadget device.
>>>
>>> This assumption/restriction maybe a problem, as I pointed in your previous
>>> version, usb_create_hcd() use the passed dev as its dev, but,
>>> usb_add_gadget_udc() use the passed dev as its parent dev, so often the
>>> host and gadget don't share the same parent device, at least it doesn't
>>> apply to chipidea case.
>>
>> Let's provide a way for OTG driver to provide the OTG core exactly which is
>> the related host/gadget device.
>>
>>>
>>>> + * For device tree boot, the OTG controller is derived from the
>>>> + * "otg-controller" property.
>>>> + */
>>>> +static struct device *usb_otg_get_device(struct device *hcd_gcd_dev)
>>>> +{
>>>> +	struct device *otg_dev;
>>>> +
>>>> +	if (!hcd_gcd_dev)
>>>> +		return NULL;
>>>> +
>>>> +	if (hcd_gcd_dev->of_node) {
>>>> +		struct device_node *np;
>>>> +		struct platform_device *pdev;
>>>> +
>>>> +		np = of_parse_phandle(hcd_gcd_dev->of_node, "otg-controller",
>>>> +				      0);
>>>> +		if (!np)
>>>> +			goto legacy;	/* continue legacy way */
>>>> +
>>>> +		pdev = of_find_device_by_node(np);
>>>> +		of_node_put(np);
>>>> +		if (!pdev) {
>>>> +			dev_err(&pdev->dev, "couldn't get otg-controller device\n");
>>>> +			return NULL;
>>>> +		}
>>>> +
>>>> +		otg_dev = &pdev->dev;
>>>> +		return otg_dev;
>>>> +	}
>>>> +
>>>> +legacy:
>>>> +	/* otg device is parent and must be registered */
>>>> +	otg_dev = hcd_gcd_dev->parent;
>>>> +	if (!usb_otg_get_data(otg_dev))
>>>> +		return NULL;
>>>> +
>>>> +	return otg_dev;
>>>> +}
>>>> +
>>>
>>> ... ...
>>>
>>>> +static void usb_otg_init_timers(struct usb_otg *otgd, unsigned *timeouts)
>>>> +{
>>>> +	struct otg_fsm *fsm = &otgd->fsm;
>>>> +	unsigned long tmouts[NUM_OTG_FSM_TIMERS];
>>>> +	int i;
>>>> +
>>>> +	/* set default timeouts */
>>>> +	tmouts[A_WAIT_VRISE] = TA_WAIT_VRISE;
>>>> +	tmouts[A_WAIT_VFALL] = TA_WAIT_VFALL;
>>>> +	tmouts[A_WAIT_BCON] = TA_WAIT_BCON;
>>>> +	tmouts[A_AIDL_BDIS] = TA_AIDL_BDIS;
>>>> +	tmouts[A_BIDL_ADIS] = TA_BIDL_ADIS;
>>>> +	tmouts[B_ASE0_BRST] = TB_ASE0_BRST;
>>>> +	tmouts[B_SE0_SRP] = TB_SE0_SRP;
>>>> +	tmouts[B_SRP_FAIL] = TB_SRP_FAIL;
>>>> +
>>>> +	/* set controller provided timeouts */
>>>> +	if (timeouts) {
>>>> +		for (i = 0; i < NUM_OTG_FSM_TIMERS; i++) {
>>>> +			if (timeouts[i])
>>>> +				tmouts[i] = timeouts[i];
>>>> +		}
>>>> +	}
>>>> +
>>>> +	otg_timer_init(A_WAIT_VRISE, otgd, set_tmout, TA_WAIT_VRISE,
>>>> +		       &fsm->a_wait_vrise_tmout);
>>>> +	otg_timer_init(A_WAIT_VFALL, otgd, set_tmout, TA_WAIT_VFALL,
>>>> +		       &fsm->a_wait_vfall_tmout);
>>>> +	otg_timer_init(A_WAIT_BCON, otgd, set_tmout, TA_WAIT_BCON,
>>>> +		       &fsm->a_wait_bcon_tmout);
>>>> +	otg_timer_init(A_AIDL_BDIS, otgd, set_tmout, TA_AIDL_BDIS,
>>>> +		       &fsm->a_aidl_bdis_tmout);
>>>> +	otg_timer_init(A_BIDL_ADIS, otgd, set_tmout, TA_BIDL_ADIS,
>>>> +		       &fsm->a_bidl_adis_tmout);
>>>> +	otg_timer_init(B_ASE0_BRST, otgd, set_tmout, TB_ASE0_BRST,
>>>> +		       &fsm->b_ase0_brst_tmout);
>>>> +
>>>> +	otg_timer_init(B_SE0_SRP, otgd, set_tmout, TB_SE0_SRP,
>>>> +		       &fsm->b_se0_srp);
>>>> +	otg_timer_init(B_SRP_FAIL, otgd, set_tmout, TB_SRP_FAIL,
>>>> +		       &fsm->b_srp_done);
>>>> +
>>>> +	/* FIXME: what about A_WAIT_ENUM? */
>>>
>>> Either you init it as other timers, or you remove all of it, otherwise
>>> there will be NULL pointer crash.
>>
>> I want to initialize it but was not sure about the timeout value.
>> What timeout value I must use?
>>
> 
> It's not defined in OTG spec, I don't know either.
> or you filter it out when add/del timer in below 2 functions.
> 	if (id == A_WAIT_ENUM)
> 		return;
> 

Looks like it is used for some workaround. See phy-fsl-usb.c line 269

/*
 * Workaround for a_host suspending too fast.  When a_bus_req=0,
 * a_host will start by SRP.  It needs to set b_hnp_enable before
 * actually suspending to start HNP
 */
void a_wait_enum(unsigned long foo)
{
        VDBG("a_wait_enum timeout\n");
        if (!fsl_otg_dev->phy.otg->host->b_hnp_enable)
                fsl_otg_add_timer(&fsl_otg_dev->fsm, a_wait_enum_tmr);
        else
                otg_statemachine(&fsl_otg_dev->fsm);
}

I'll filter it out for now as per your suggestion. We can look back
into it if we face issues as mentioned in the workaround.

>>>
>>>> +}
>>>> +
>>>> +/**
>>>> + * OTG FSM ops function to add timer
>>>> + */
>>>> +static void usb_otg_add_timer(struct otg_fsm *fsm, enum otg_fsm_timer id)
>>>> +{
>>>> +	struct usb_otg *otgd = container_of(fsm, struct usb_otg, fsm);
>>>> +	struct otg_timer *otgtimer = &otgd->timers[id];
>>>> +	struct hrtimer *timer = &otgtimer->timer;
>>>> +
>>>> +	if (!otgd->fsm_running)
>>>> +		return;
>>>> +
>>>> +	/* if timer is already active, exit */
>>>> +	if (hrtimer_active(timer)) {
>>>> +		dev_err(otgd->dev, "otg: timer %d is already running\n", id);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	hrtimer_start(timer, otgtimer->timeout, HRTIMER_MODE_REL);
>>>> +}
>>>> +
>>>> +/**
>>>> + * OTG FSM ops function to delete timer
>>>> + */
>>>> +static void usb_otg_del_timer(struct otg_fsm *fsm, enum otg_fsm_timer id)
>>>> +{
>>>> +	struct usb_otg *otgd = container_of(fsm, struct usb_otg, fsm);
>>>> +	struct hrtimer *timer = &otgd->timers[id].timer;
>>>> +
>>>> +	hrtimer_cancel(timer);
>>>> +}
>>>> +
> 
> ... ...
> 
>>>> +	}
>>>> +
>>>> +	otgd->dev = dev;
>>>> +	otgd->caps = &config->otg_caps;
>>>
>>> How about define otgd->caps as a pointer, then don't need copy it.
>>
>> otgd->caps is a pointer.
>>
> 
> okay, you are right.
> 
>>>
>>>> +	INIT_WORK(&otgd->work, usb_otg_work);
>>>> +	otgd->wq = create_singlethread_workqueue("usb_otg");
>>>> +	if (!otgd->wq) {
>>>> +		dev_err(dev, "otg: %s: can't create workqueue\n",
>>>> +			__func__);
>>>> +		ret = -ENOMEM;
>>>> +		goto err_wq;
>>>> +	}
>>>> +
>>>> +	usb_otg_init_timers(otgd, config->otg_timeouts);
>>>> +
>>>> +	/* create copy of original ops */
>>>> +	otgd->fsm_ops = *config->fsm_ops;
>>>
>>> The same, use a pointer is enough?
>>
>> We are creating a copy because we are overriding timer ops.
>>
> 
> okay.
> 
>>>
>>>> +	/* FIXME: we ignore caller's timer ops */
>>>> +	otgd->fsm_ops.add_timer = usb_otg_add_timer;
>>>> +	otgd->fsm_ops.del_timer = usb_otg_del_timer;
>>>> +	/* set otg ops */
>>>> +	otgd->fsm.ops = &otgd->fsm_ops;
>>>> +	otgd->fsm.otg = otgd;
>>>> + *
> 
> ... ...
> 
>>>> + * This is used by the USB Host stack to register the Host controller
>>>> + * to the OTG core. Host controller must not be started by the
>>>> + * caller as it is left upto the OTG state machine to do so.
>>>
>>> I am confused on how to use this function.
>>> - This function should be called before start fsm per usb_otg_start_fsm().
>>
>> yes.
>>
>>> - Called by usb_add_hcd(), so we need call usb_add_hcd() before start fsm.
>>
>> yes.
>>
>>> - If I want to add hcd when switch to host role, and remove hcd when switch
>>>   to peripheral, with this design, I cannot use this function?
>>
>> You add hcd only once during the life of the OTG device. If it is linked to the
>> OTG controller the OTG fsm manages the start/stop of hcd using the otg_hcd_ops.
>>
>> "usb/core/hcd.c"
>> static struct otg_hcd_ops otg_hcd_intf = {
>>         .add = usb_otg_add_hcd,
>>         .remove = usb_otg_remove_hcd,
>> };
>>
>> Your otg driver must use teh usb_otg_add/remove_hcd to start/stop the controller.
>> Using usb_remove_hcd() means the hcd resource is no longer available and the
>> otg fsm will be stopped.
>>
>>> - How about split it out of usb_add_hcd()?
>>
>> Adding the HCD and starting/stopping the hcd is split into
>> usb_add/remove_hcd() and usb_otg_add/remove_hcd() for OTG case.
>>
> 
> Catch your point now.
> Do usb_add_hcd to register hcd before start fsm, and use usb_otg_start_host()
> to start/stop host role for otg fsm.
> 
correct :).

>>>
>>>> + *
>>>> + * Returns: 0 on success, error value otherwise.
>>>> + */
>>>> +int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>>>> +			 unsigned long irqflags, struct otg_hcd_ops *ops)
>>>> +{
>>>> +	struct usb_otg *otgd;
>>>> +	struct device *hcd_dev = hcd->self.controller;
>>>> +	struct device *otg_dev = usb_otg_get_device(hcd_dev);
>>>> +
>>>> +	if (!otg_dev)
>>>> +		return -EINVAL;	/* we're definitely not OTG */
>>>> +
>>>> +	/* we're otg but otg controller might not yet be registered */
>>>> +	mutex_lock(&otg_list_mutex);
>>>> +	otgd = usb_otg_get_data(otg_dev);
>>>> +	mutex_unlock(&otg_list_mutex);
>>>> +	if (!otgd) {
>>>> +		dev_dbg(hcd_dev,
>>>> +			"otg: controller not yet registered. waiting..\n");
>>>> +		/*
>>>> +		 * otg controller might register later. Put the hcd in
>>>> +		 * wait list and call us back when ready
>>>> +		 */
>>>> +		if (usb_otg_hcd_wait_add(otg_dev, hcd, irqnum, irqflags, ops)) {
>>>> +			dev_dbg(hcd_dev, "otg: failed to add to wait list\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	/* HCD will be started by OTG fsm when needed */
>>>> +	mutex_lock(&otgd->fsm.lock);
>>>
>>> If call usb_add_hcd() when start host role, deadlock.
>>
>> No. You must call usb_otg_add_hcd() to start host role.
>>
>>>
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
>>>
>>> otgd->host = hcd_to_bus(hcd);
>>
>> ok. So we set host at both places. struct usb_otg in struct otg_fsm starts to
>> feel redundant now. I think we should get rid of it and get the usb_otg struct
>> using container_of() instead.
>>
> 
> Then you may come to force existing otg fsm code to use your OTG core.

Let's leave it around then.

> 
>>>
>>>> +		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
>>>> +
>>>> +		/* start FSM */
>>>> +		usb_otg_start_fsm(&otgd->fsm);
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
>>>
>>> Return non-zero, then if err, do we need call usb_otg_add_hcd() after
>>> usb_otg_register_hcd() fails?
>>
>> You should not call usb_otg_register_hcd() but usb_add_hcd().
>> If that fails then you fail as ususal.
> 
> My point is if we use usb_add_hcd(), but failed in usb_otg_register_hcd(),
> then usb_otg_add_hcd() will be called in *all* error case, is this your
> expectation?
> 	if (usb_otg_register_hcd(hcd, irqnum, irqflags, &otg_hcd_intf))
> 		return usb_otg_add_hcd(hcd, irqnum, irqflags);
> 

Yes, my intention was that if otg fails then it is a non otg HCD so register normally.
Let me correct my previous statement. If you are absolutely sure
that the HCD is for otg/dual-role usage then you should call usb_otg_register_hcd().

>>>> + * @fsm_running: state machine running/stopped indicator
>>>> + */
>>>>  struct usb_otg {
>>>>  	u8			default_a;
>>>>  
>>>>  	struct phy		*phy;
>>>>  	/* old usb_phy interface */
>>>>  	struct usb_phy		*usb_phy;
>>>> +
>>>
>>> add a blank line?
>>>
> 
> You missed this.

Sorry. Did you suggest to remove that blank line
or add a new one before usb_phy?

> 
>>>>  	struct usb_bus		*host;
>>>>  	struct usb_gadget	*gadget;
>>>>  
>>>>  	enum usb_otg_state	state;
>>>>  
>>>> +	struct device *dev;
>>>> +	struct usb_otg_caps *caps;
>>>> +	struct otg_fsm fsm;
>>>> +	struct otg_fsm_ops fsm_ops;
>>>> +
>>>> +	/* internal use only */
>>>> +	struct otg_hcd primary_hcd;
>>>> +	struct otg_hcd shared_hcd;
>>>> +	struct otg_gadget_ops *gadget_ops;
>>>> +	struct otg_timer timers[NUM_OTG_FSM_TIMERS];
>>>> +	struct list_head list;
>>>> +	struct work_struct work;
>>>> -- 
>>>> 2.1.4
> 

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
