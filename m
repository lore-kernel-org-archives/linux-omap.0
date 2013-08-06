From: Roger Quadros <rogerq@ti.com>
Subject: Re: Reg: USB: ehci-omap: Suspend the controller during idle.
Date: Tue, 6 Aug 2013 17:27:17 +0300
Message-ID: <520107C5.20803@ti.com>
References: <8D86EEFC18AF0D43A2B8E0ABFA8B88A17B16B9455E@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42884 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963Ab3HFO1b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Aug 2013 10:27:31 -0400
In-Reply-To: <8D86EEFC18AF0D43A2B8E0ABFA8B88A17B16B9455E@EXGMBX01.sasken.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bharathraj Nagaraju <bharathraj.nagaraju@sasken.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

Hi,

On 08/06/2013 03:55 PM, Bharathraj Nagaraju wrote:
>   Dear All,
> 
>   We are working on omap4470 based device,kernel-3.0.31 is running on this.
>   In our device modem is connected to OMAP4470 using USB EHCI.
> 
>   In our current kernel code, clocks are enabled when ports get connected
>   and disabled during disconnect.Due to this current consumption is more in idle use case.
> 
>   I have tried to put the host in smart idle/standby mode,due to erratas around Host doesn't allow us
>   use smart idle/standby capabilities.
> 
>   1) i571: USB host EHCI may stall when entering smart-standby mode
>   2) i660: USBHOST Configured In Smart-Idle Can Lead To a Deadlock
> 
>   we are thinking to implement USB EHCI runtime suspend/resume feature.
> 
>   In kernel-3.0.31 architecture the usbcore driver is parent of ehci and ohci drivers.
>   The ehci and ohci drivers call the pm_runtime_get_sync and pm_runtime_put_sync of parent device usbhs core.
> 
>   From the ehci-omap driver what i can see only partial implementation of runtime PM.
>   what i mean is that runtime PM methods are used only during the normal suspend path
>   and when nothing is connected to ports(modem disconnected in our case).
> 
>   I am thinking to change the ehci driver code, could claver enough to use runtime PM
>   to disable the hardware when modem is connected and the system is in idle state.
> 
>   Kindly guide me how can i go about this.
> 
>   Let me know if you need further clarification from me on this.
> 
>   Thanks for spending your valuable time .......:)


The problem with OMAP EHCI controller is that it needs to rely on IO Daisy chain mechanism
to wake up when it is suspended. Without that, we can't really put the controller in to runtime
suspend, else we will not be able to detect a new device connect.

IO daisy chaining is still not supported in mainline. One approach had been posted [1] and it works
but it is still in transition.

I've made some patches [2] which implement USB runtime suspend with remote wakeup working
for OMAP3 beagle-xm board. This depends on [1]. It shouldn't be hard to get it working on OMAP4.

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/101105
[2] http://article.gmane.org/gmane.linux.ports.arm.kernel/251250

cheers,
-roger

