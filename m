From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFT/PATCH] serial: omap: prevent resume if device is not suspended.
Date: Fri, 12 Oct 2012 13:32:34 -0700
Message-ID: <87lifbwhwd.fsf@deeprootsystems.com>
References: <20120925091228.GI31374@n2100.arm.linux.org.uk>
	<20120925091112.GK9137@arwen.pp.htv.fi>
	<20120925092118.GJ31374@n2100.arm.linux.org.uk>
	<CAKdam57bpTJ94Gn=mKVw1Fm-76fVPp3DGjFuNu_HfesybM1hPg@mail.gmail.com>
	<87ipas2y4h.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1210111748010.5736@utopia.booyaka.com>
	<50784458.9080806@ti.com> <877gqv7imt.fsf@deeprootsystems.com>
	<20121012164202.GQ28061@n2100.arm.linux.org.uk>
	<877gqv4lmt.fsf@deeprootsystems.com>
	<20121012185426.GS28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44602 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab2JLUch (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 16:32:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3152389pad.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Oct 2012 13:32:37 -0700 (PDT)
In-Reply-To: <20121012185426.GS28061@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 12 Oct 2012 19:54:26 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sourav <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, gregkh@linuxfoundation.org, tony@atomide.com, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, Oct 12, 2012 at 10:59:22AM -0700, Kevin Hilman wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> > On Fri, Oct 12, 2012 at 09:35:54AM -0700, Kevin Hilman wrote:
>> >> Sourav <sourav.poddar@ti.com> writes:
>> >> > diff --git a/drivers/tty/serial/omap-serial.c
>> >> > b/drivers/tty/serial/omap-serial.c
>> >> > index 6ede6fd..3fbc7f7 100644
>> >> > --- a/drivers/tty/serial/omap-serial.c
>> >> > +++ b/drivers/tty/serial/omap-serial.c
>> >> > @@ -1414,6 +1414,7 @@ static int __devinit serial_omap_probe(struct
>> >> > platform_device *pdev)
>> >> >         INIT_WORK(&up->qos_work, serial_omap_uart_qos_work);
>> >> >
>> >> >         platform_set_drvdata(pdev, up);
>> >> > +       pm_runtime_set_active(&pdev->dev);
>> >> 
>> >> NAK.
>> >> 
>> >> This will obviously break platforms where the UARTs are not active
>> >> before driver loads.
>> >
>> > I thought I had proposed a solution for this issue, which was this
>> > sequence:
>> >
>> >         omap_device_enable(dev);                                                
>> >         pm_runtime_set_active(dev);                                             
>> >         pm_runtime_enable(dev);                                                 
>> >
>> > Yes, I can understand people not liking the omap_device_enable()
>> > there, but I also notice that the email suggesting that never got a
>> > reply either - not even a "I tried this and it doesn't work" or "it
>> > does work".
>> 
>> Yes, that solution would work (though I didn't actually try it.)
>> 
>> However, we can't use omap_device_enable() in the driver.  We're trying
>> to clean all the drivers of OMAP-specific APIs.  That being said,
>> something similar could be done in the device/board init code to ensure
>> the UART HW is in the state that the driver is expecting it, but again,
>> that would just mask the real problem which is that a (re)init of the
>> console UART on 2420/n800 is causing output to disappear.
>
> See my more expansive suggestion just posted.
>
> Whatever way, this discrepancy between runtime PM state and actual device
> state is what is biting you, and it is that which needs fixing.  

I'm not conviced (yet) that a mismatch is the root cause.  Yes, that's
what the author of $SUBJECT patch assumed and stated, but I'm not
pursuaded.  

If it's an improperly configured mux issue, then the UART will break
whenever the device is actually omap_device_enable'd, whether in the
driver or in the bus layer.

Kevin

