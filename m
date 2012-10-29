From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problem with OHCI on OMAP4430
Date: Mon, 29 Oct 2012 11:24:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1210291111260.22882-100000@netrider.rowland.org>
References: <CANP3njys-W+JXdkH3Vj-90VgMENwtcDMZ6y-oEift3fC89yYwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:37689 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752717Ab2J2PYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 11:24:05 -0400
In-Reply-To: <CANP3njys-W+JXdkH3Vj-90VgMENwtcDMZ6y-oEift3fC89yYwg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mohan V <mohanvforum@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, keshava_mgowda@ti.com

On Mon, 29 Oct 2012, Mohan V wrote:

> > I'm not going to be able to help very much with an Android kernel.
> > Does the same problem occur with a vanilla non-Android 3.6 kernel?  If
> > it doesn't, that indicates the problem was caused by some
> > Android-specific changes.
> >
> With the vanilla 3.6 kernel, the device connected to OHCI port is not even
> detected. The below messages are seen:
> 
> [    5.343780] usb 2-2: new low-speed USB device number 5 using ohci-omap3
> [    5.351776] ohci-omap3 ohci-omap3.0: urb ee7f83c0 path 2 ep0out
> 5ec20000 cc 5 --> status -62
> [    5.570770] ohci-omap3 ohci-omap3.0: urb ee7f83c0 path 2 ep0out
> 5ec20000 cc 5 --> status -62
> [    5.789062] usb 2-2: device not accepting address 5, error -62
> [    5.795288] hub 2-0:1.0: unable to enumerate USB device on port 2

It looks like the device was detected just fine but the host was
unable to communicate with it.  I don't know why; maybe a clock or
power line wasn't turned on properly or a PHY wasn't enabled.

> We think it may not be hardware issue, since the device gets detected on
> android-3.0 kernel. The support for OHCI on OMAP4430 SDP board
> seems to be missing in Linux mainline (3.6).
> 
> We ported some OMAP specific patches from android kernel, with this the
> device gets detected only if it is connected at boot.
> If the system is booted and then device is connected, it doesn't get detected.

Doesn't get detected, or does get detected but then doesn't 
communicate?

Perhaps you should send some questions to the maintainers of the
various ohci-omap drivers or the Android maintainers.

> > Are you referring to this part of the log?
> >
> >> ------------------------Device not getting detected when connected---------------------------
> >>
> >> / # [  135.621002] usbhs_wakeup: Enabling clocks
> >> [  135.625762] usbhs_runtime_resume:++++++
> >> [  135.630371] usbhs_runtime_resume:------
> >> [  135.638183] USB IO PAD Wakeup event triggered##################
> >> [  135.644958] usbhs_runtime_suspend:++++++
> >> [  135.649749] usbhs_runtime_suspend:-----
> >
> > It appears that ohci_irq() didn't run.  Did
> > ohci_finish_controller_resume() get called?
> >
> This function is not used in ohci-omap3.c and is used only in ohci-omap.c.
> Is it necessary to call this function?

It is necessary if the driver supports suspend/resume.  As far as I can
tell, the ohci-omap3 driver does not have this support (at least, not
in the 3.6 kernel) whereas the ohci-omap driver does.

What driver produced the "usbhs_runtime_suspend" and
"usbhs_runtime_resume" messages above?  (No such messages are present
in ohci-omap3.c.)  Apparently that driver _does_ support
suspend/resume.

Alan Stern

