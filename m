From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problem with OHCI on OMAP4430
Date: Fri, 26 Oct 2012 11:19:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1210261057580.6007-100000@iolanthe.rowland.org>
References: <CANP3njw4=efheeOq9TsusNBwHASSfF7tG_1jYc4aHdW6+sX2zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56486 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932078Ab2JZPTl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 11:19:41 -0400
In-Reply-To: <CANP3njw4=efheeOq9TsusNBwHASSfF7tG_1jYc4aHdW6+sX2zQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mohan V <mohanvforum@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, keshava_mgowda@ti.com

On Fri, 26 Oct 2012, Mohan V wrote:

> >> When the USB bus is in suspend, a device connected to OHCI port does
> >> not get detected, whereas the device connected to EHCI port is getting detected.
> >
> > Can you provide a dmesg log showing the OHCI problem with
> > CONFIG_USB_DEBUG enabled?
> >
> Please find the attached log (ohci-detect.log), where the device is
> disconnected from the
> OHCI port and then does not get detected when connected again.
> We are using android 3.0 kernel.

I'm not going to be able to help very much with an Android kernel.  
Does the same problem occur with a vanilla non-Android 3.6 kernel?  If 
it doesn't, that indicates the problem was caused by some 
Android-specific changes.

Are you referring to this part of the log?

> ------------------------Device not getting detected when connected---------------------------
> 
> / # [  135.621002] usbhs_wakeup: Enabling clocks
> [  135.625762] usbhs_runtime_resume:++++++
> [  135.630371] usbhs_runtime_resume:------
> [  135.638183] USB IO PAD Wakeup event triggered##################
> [  135.644958] usbhs_runtime_suspend:++++++
> [  135.649749] usbhs_runtime_suspend:-----

It appears that ohci_irq() didn't run.  Did
ohci_finish_controller_resume() get called?

My guess is your usbhs_runtime_resume() routine has a bug.  Maybe the 
usbhs_runtime_suspend() routine does too.

> We sometime see the crash in "ohci_hub_status_data" function. So, when
> we add the
> below check at the entry of the function, there is no crash. Please
> find attached crash log.
> (ohci-crash.log)

I don't understand the crash log.  What is the cause of the crash?  Is 
there some error involving spin_lock_irqrestore() in 
ohci_hub_status_data()

>         if (!HC_IS_RUNNING(hcd->state)) {
> 		return 0;
> 	}
> 
> But the device does not get detected subsequently with this change. There is
> a similar check in ehci-hub.c.

No, there isn't.  Not since the 3.1 kernel.  In any case, ehci-hcd is 
different from ohci-hcd; you shouldn't expect their hub_status_data 
routines to be the same.

Alan Stern

