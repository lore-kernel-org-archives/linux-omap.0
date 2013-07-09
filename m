From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
Date: Tue, 9 Jul 2013 16:58:42 +0300
Message-ID: <51DC1712.30401@ti.com>
References: <Pine.LNX.4.44L0.1306281346430.1047-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1306281346430.1047-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ruslan.bilovol-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/28/2013 10:06 PM, Alan Stern wrote:
> On Fri, 28 Jun 2013, Roger Quadros wrote:
> 
>>> That's not what I meant.  Never mind the pinctrl; I was asking about
>>> the EHCI controller itself.  Under what circumstances does the
>>> controller assert its wakeup signal?  And how do you tell it to stop
>>> asserting that signal?
>>
>> I believe this would be through the EHCI Interrupt enable register (USBINTR).
>> I'm not aware of any other mechanism.
> 
> That's strange, because ehci_suspend() sets the intr_enable register to 
> 0.  So how do you ever get any wakeup interrupts at all?
> 
>> Right. It seems the external hub has signaled remote wakeup but the kernel doesn't
>> resume the root hub's port it is connected to.
>>
>> By observing the detailed logs below you can see that the root hub does not generate
>> an INTerrupt transaction to notify the port status change event. I've captured the pstatus
>> and GetPortStatus info as well.
> 
> We don't need an interrupt.  The driver is supposed to detect the
> remote wakeup sent by the external hub all by itself.
> 
>> Failing case
>> ------------
>>
>> [   16.108032] usb usb1: usb auto-resume
>> [   16.108062] ehci-omap 48064800.ehci: resume root hub
>> [   16.108154] hub 1-0:1.0: hub_resume
>> [   16.108398] ehci_hub_control GetPortStatus, port 1 temp = 0x1000
>> [   16.108459] ehci_hub_control GetPortStatus, port 2 temp = 0x14c5
> 
> Here's where we should detect it.  Look at the GetPortStatus case in
> ehci_hub_control(); the PORT_RESUME bit (0x0040) is set in temp, so the
> "Remote Wakeup received?" code should run.  In particular, these lines
> should run:
> 
> 			/* resume signaling for 20 msec */
> 			ehci->reset_done[wIndex] = jiffies
> 					+ msecs_to_jiffies(20);
> 			usb_hcd_start_port_resume(&hcd->self, wIndex);
> 			/* check the port again */
> 			mod_timer(&ehci_to_hcd(ehci)->rh_timer,
> 					ehci->reset_done[wIndex]);
> 
> Therefore 20 ms later, around timestamp 16.128459,
> ehci_hub_status_data() should have been called.  At that time, the
> root-hub port should have been fully resumed.
> 
>> [   16.108551] hub 1-0:1.0: port 2: status 0507 change 0000
>> [   16.108612] ehci_hub_control GetPortStatus, port 3 temp = 0x1000
>> [   16.108642] hub 1-0:1.0: hub_activate submitting urb
>> [   16.109222] ehci_irq port 3 pstatus 0x1000
>> [   16.109222] ehci_irq port 2 pstatus 0x14c5
>> [   16.109252] ehci_irq port 1 pstatus 0x1000
>> [   16.109374] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> 
> But apparently nothing happened.  Why not?  Did the rh_timer get reset?  
> Maybe you can find out what went wrong.
> 
> (Hmmm, we seem to be missing a
> 
> 			set_bit(wIndex, &ehci->resuming_ports);
> 
> line in there...)
> 

Right. This is indeed the problem. I've cooked up a patch for that and will send
it separately in a moment.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
