From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
Date: Wed, 11 Jan 2012 08:07:11 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201110714221.31702@utopia.booyaka.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com> <1323773758-6375-5-git-send-email-shubhrajyoti@ti.com> <alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com> <4EEB086A.2050607@ti.com> <CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA@mail.gmail.com>
 <CANQgH-YLez8B-t8nf9_M8samn9YWUa7LcOFx6uPFrJE9tnXB1Q@mail.gmail.com> <87hb03tw8h.fsf@ti.com> <4F0D26DF.1020108@ti.com> <alpine.DEB.2.00.1201110619090.31702@utopia.booyaka.com> <4F0D9589.1080609@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F0D9589.1080609-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 11 Jan 2012, Shubhrajyoti wrote:

> On Wednesday 11 January 2012 06:59 PM, Paul Walmsley wrote:
>
> > The real question is how you plan to handle the device reset function, 
> > given that the driver should compile on a non-OMAP build (meaning that you 
> > can't call omap_device*() functions from the driver directly), nor should 
> > the driver touch the SYSCONFIG register directly.
> 
> Paul I thought through it myself not very clear.
> - One way is to find some way for the dt to pass function pointer. Or maybe
> a flag that  activates a static function / hwmod func.
>  
> Will give this a little more thought and get back. I have not any answer
> right now.

Well, if it makes you feel any better, no one else seems to have thought 
through it very much either :-(

To me this is essentially implementing a bus-level (or really, 
integration-level) reset of the device.  This seems to be a function that 
many other buses might support.  So let's look at some of the other 
common Linux bus implementations.

PCI has pci_reset_function() in drivers/pci/pci.c, which a handful of 
PCI-specific drivers call. USB has usb_reset_device() in 
drivers/usb/core/hub.c, also called by a handful of devices.

So there's precedent for the use case.

Incidentally, this is the kind of thing that ideally should be supported 
via a common function pointer in struct bus_type or maybe struct device. 
So rather than the driver calling pci_reset_function() or 
usb_reset_device(), it seems preferable for the driver to do something 
like:

    if (dev->bus->device_reset)
        dev->bus->device_reset(dev);

It seems best to avoid binding a driver tightly to a particular bus 
whenever possible.

...

Now to consider something like this from an OMAP perspective.

In a rough approximation of an ideal world, much of the hwmod and 
omap_device code would live somewhere like drivers/omap_bus/.  Our devices 
would be omap_device based rather than platform_device or of_device based.  
We could export omap_device_reset() and then the I2C driver could call 
this directly.  We're at least a year away from this (if ever): we need 
PRM, CM, SCM drivers; we'd need to have a real omap_bus and omap_device 
that our drivers would use, unlike the faux omap_device we have now.  
Maybe the latter is never going to happen now due to the DT situation.
So any solution that would depend on these steps as prerequisites might 
easily be delayed for an infinite amount of time.

But let's say that a device_reset() function pointer existed inside the 
common struct bus_type in include/linux/device.h, as discussed above.  
>From an OMAP perspective, we could simply set that to point to 
omap_device_reset() in the OMAP-specific device creation code or DT 
notifier callback code.  PCI and USB code could set it to point to their 
own reset functions.  Something like the code fragment above would be 
recommended for all device drivers to do an integration device reset.

Anyway, just an idea.


- Paul
