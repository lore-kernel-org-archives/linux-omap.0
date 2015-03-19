From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH 3/9] usb: otg: add OTG core
Date: Thu, 19 Mar 2015 16:54:22 +0200
Message-ID: <550AE31E.5020405@ti.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com> <1426686963-11613-4-git-send-email-rogerq@ti.com> <20150319082656.GA4210@shlinux1.ap.freescale.net> <550AA556.1030301@ti.com> <20150319144122.GB7950@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150319144122.GB7950@shlinux1.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Jun <b47624@freescale.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 19/03/15 16:41, Li Jun wrote:
> On Thu, Mar 19, 2015 at 12:30:46PM +0200, Roger Quadros wrote:
>> On 19/03/15 10:26, Li Jun wrote:
>>> On Wed, Mar 18, 2015 at 03:55:57PM +0200, Roger Quadros wrote:
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
>>>> TODO:
>>>> - sysfs interface to allow application inputs to OTG state machine
>>>> - otg class?
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> ---
>>>> +struct otg_data {
>>>> +	struct device *dev;	/* HCD & GCD's parent device */
>>>> +
>>>> +	struct otg_fsm fsm;
>>>> +	/* HCD, GCD and usb_otg_state are present in otg_fsm->otg
>>>> +	 * HCD is bus_to_hcd(fsm->otg->host)
>>>> +	 * GCD is fsm->otg->gadget
>>>> +	 */
>>>> +	struct otg_fsm_ops fsm_ops;	/* private copy for override */
>>>> +	struct usb_otg otg;
>>>> +	struct usb_hcd *shared_hcd;	/* if shared HCD registered */
>>>> +
>>>> +	/* saved hooks to OTG device */
>>>> +	int (*start_host)(struct otg_fsm *fsm, int on);
>>>> +	int (*start_gadget)(struct otg_fsm *fsm, int on);
>>>> +
>>>> +	struct list_head list;
>>>> +
>>>> +	struct work_struct work;	/* OTG FSM work */
>>>> +	struct workqueue_struct *wq;
>>>> +
>>>> +	struct otg_timer timers[NUM_OTG_FSM_TIMERS];
>>>> +
>>>> +	bool fsm_running;
>>>> +	bool gadget_can_start;		/* OTG FSM says gadget can start */
>>>> +	bool host_can_start;		/* OTG FSM says host can start */
>>>
>>> Do not understand above 2 *_can_start flags from the patch, which are set
>>> only when you really start host/gadget, to prevent host/gadget driver to
>>> start it out of otg fsm control?
>>
>> host_can_start is used only by this driver in the following _unlikely_ condition
>> and could probably be got rid of.
>> - Primary HCD and gadget registers
>> - OTG FSM signals host to start but it can't start as shared HCD isn't yet registered.
>> so we set this flag.
>> - when shared HCD registers, we check the flag and explicitly start both the host controllers.
>>
>> gadget_can_start is used by the gadget driver through the usb_otg_gadget_can_start() API.
>> This is needed because gadget might start at a later time depending on either
>> - gadget function driver loads
> 
> I think it should be loaded before kick off OTG fsm.

Agree. This could be done.

> 
>> - userspace enables softconnect.
> 
> Why use the input of softconnect in userspace? I suppose all inputs should be
> in scope/defined by OTG spec(a_bus_req, b_bus_req...).
> So it's possible the gadget has not been started(pull up DP) while the OTG fsm
> is in b_peripheral state? If yes, it's breaking OTG spec 7.2.3:

Good point.

> ... 
> When a high-speed capable B-device enters this state it shall enable its pull-up
> on D+. After the B-device enables its pull-up, it shall monitor the state of the
> bus to determine if a bus reset is being signaled by the A-device.
> ...
> 
> So for B-device, it should start gadget(pull up DP) if detects valid BSV vbus,
> that's the only condition.

OK. so we can ignore the softconnect in the OTG case and I can get rid of the
udc/gadget_running flags.

so now b_peripheral means UDC started.

cheers,
-roger

> 
> Li Jun
>>
>>>
>>> Li Jun
>>>> +
>>>> +	/* use otg->fsm.lock for serializing access */
>>>> +};
>>>> +
>>>> + * Can be called in IRQ context.
>>>> + */
>>>> +void usb_otg_sync_inputs(struct otg_fsm *fsm)
>>>> +{
>>>> +	struct otg_data *otgd = container_of(fsm, struct otg_data, fsm);
>>>> +
>>>> +	/* Don't kick FSM till it has started */
>>>> +	if (!otgd->fsm_running)
>>>> +		return;
>>>> +
>>>> +	/* Kick FSM */
>>>> +	queue_work(otgd->wq, &otgd->work);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(usb_otg_sync_inputs);
>>>> +
>>>> +/**
>>>> + * usb_otg_kick_fsm - Kick the OTG state machine
>>>> + * @hcd_gcd_device:	Host/Gadget controller device
>>>> + *
>>>> + * Used by USB host/device stack to sync OTG related
>>>> + * events to the OTG state machine.
>>>> + * e.g. change in host_bus->b_hnp_enable, gadget->b_hnp_enable
>>>> + *
>>> There are quite a few otg fsm variables which should be updated when 
>>> events/interrupts(b_conn, a_srp_det, ...) occur, how is your plan to
>>> update them? Still rely on specific controller driver irq handler to
>>> capture all those events and update them?
>>
>> Yes, my plan was that the OTG controller driver will handle those
>> interrupts, update otg_fsm members and call usb_otg_sync_inputs() to
>> notify the OTG FSM.
>>
>> cheers,
>> -roger
>>
>>>
>>> Li Jun
>>>> + * Returns: 0 on success, error value otherwise.
>>>> + */
>>>> +int usb_otg_kick_fsm(struct device *hcd_gcd_device)
>>>> +{
>>>> +	struct otg_data *otgd;
>>>> +
>>>> +	mutex_lock(&otg_list_mutex);
>>>> +	otgd = usb_otg_device_get_otgd(hcd_gcd_device->parent);
>>>> +	if (!otgd) {
>>>> +		dev_err(hcd_gcd_device, "%s: invalid host/gadget device\n",
>>>> +			__func__);
>>>> +		mutex_unlock(&otg_list_mutex);
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	mutex_unlock(&otg_list_mutex);
>>>> +	usb_otg_sync_inputs(&otgd->fsm);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(usb_otg_kick_fsm);
>>>> -- 
>>>> 2.1.0
>>>>
>>
