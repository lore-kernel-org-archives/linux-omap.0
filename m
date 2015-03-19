From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH 1/9] usb: hcd: Introduce usb_start/stop_hcd()
Date: Thu, 19 Mar 2015 13:38:32 +0200
Message-ID: <550AB538.7090806@ti.com>
References: <Pine.LNX.4.44L0.1503181538170.1497-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1503181538170.1497-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 18/03/15 21:49, Alan Stern wrote:
> On Wed, 18 Mar 2015, Roger Quadros wrote:
> 
>> To support OTG we want a mechanism to start and stop
>> the HCD from the OTG state machine. Add usb_start_hcd()
>> and usb_stop_hcd().
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> There are a few problems in this proposed patch.
> 
>> +int usb_start_hcd(struct usb_hcd *hcd)
>> +{
>> +	int retval;
>> +	struct usb_device *rhdev = hcd->self.root_hub;
>> +
>> +	if (hcd->state != HC_STATE_HALT) {
>> +		dev_err(hcd->self.controller, "not starting a running HCD\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	hcd->state = HC_STATE_RUNNING;
>> +	retval = hcd->driver->start(hcd);
>> +	if (retval < 0) {
>> +		dev_err(hcd->self.controller, "startup error %d\n", retval);
>> +		hcd->state = HC_STATE_HALT;
>> +		return retval;
>> +	}
>> +
>> +	/* starting here, usbcore will pay attention to this root hub */
>> +	if ((retval = register_root_hub(hcd)) != 0)
>> +		goto err_register_root_hub;
> 
> If the host controller is started more than once, you will end up
> unregistering and re-registering the root hub.  The device core does
> not allow this.  Once a device has been unregistered, you must not try
> to register it again -- you have to allocate a new device and register
> it instead.

Understood.

> 
> Also, although you call the driver's ->start method multiple times, the
> ->reset method is called only once, when the controller is first 
> probed.  It's not clear that this will work in a situation where the HC 
> and the UDC share hardware state; after the UDC is stopped it may be 
> necessary to reset the HC before it can run again.

Yes, good point.
> 
> It might be possible to make this work, but I suspect quite a few 
> drivers would need rewriting first.  As another example of the problems 
> you face, consider how stopping a host controller will interact with 
> the driver's PM support (both system suspend and runtime suspend).

Right. This needs more work than I thought.
> 
> It would be a lot simpler to unbind the host controller driver
> completely when switching to device mode and rebind it when switching
> back.  I guess that is the sort of heavy-duty approach you want to
> avoid, but it may be the only practical way forward.

So you mean directly calling usb_add/remove_hcd() from the OTG core?
I don't see any issues with that other than it being a heavy-duty operation
like you said and hope that it doesn't violate the OTG spec timing.

Looking at Figure 5-3: "HNP Sequence of Events (FS)" of the OTG 2.0 spec
we have about 150ms (X10) to switch from B-Device detected A connect (b_wait_acon state)
to driving bus reset (b_host state). I don't think this should be an issue in modern SoCs
but I'm not very sure.

In any case I can migrate to the add/remove hcd approach to simplify things.

cheers,
-roger
