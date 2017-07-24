From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] USB: musb: fix external abort on suspend
Date: Mon, 24 Jul 2017 10:38:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1707241029380.1739-100000@iolanthe.rowland.org>
References: <20170724094939.21477-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170724094939.21477-1-johan@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Daniel Mack <zonque@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 24 Jul 2017, Johan Hovold wrote:

> Make sure that the controller is runtime resumed when system suspending
> to avoid an external abort when accessing the interrupt registers:
> 
>   Unhandled fault: external abort on non-linefetch (0x1008) at 0xd025840a
>   ...
>   [<c05481a4>] (musb_default_readb) from [<c0545abc>] (musb_disable_interrupts+0x84/0xa8)
>   [<c0545abc>] (musb_disable_interrupts) from [<c0546b08>] (musb_suspend+0x38/0xb8)
>   [<c0546b08>] (musb_suspend) from [<c04a57f8>] (platform_pm_suspend+0x3c/0x64)
> 
> This is easily reproduced on a BBB by enabling the peripheral port only
> (as the host port may enable the shared clock) and keeping it
> disconnected so that the controller is runtime suspended. (Well, you
> would also need to the not-yet-merged am33xx-suspend patches by Dave
> Gerlach to be able to suspend the BBB.)
> 
> This is a regression that was introduced by commit 1c4d0b4e1806 ("usb:
> musb: Remove pm_runtime_set_irq_safe") which allowed the parent glue
> device to runtime suspend and thereby exposed a couple of older issues:
> 
> Register accesses without explicitly making sure the controller is
> runtime resumed during suspend was first introduced by commit
> c338412b5ded ("usb: musb: unconditionally save and restore the context
> on suspend") in 3.14.
> 
> Commit a1fc1920aaaa ("usb: musb: core: make sure musb is in RPM_ACTIVE on
> resume") later started setting the RPM status to active during resume
> without first making sure that the parent was runtime resumed. This was
> also implicitly relying on the parent always being active. Since commit
> 71723f95463d ("PM / runtime: print error when activating a child to
> unactive parent") this now also results in following warning:
> 
>   musb-hdrc musb-hdrc.0: runtime PM trying to activate child device
>     musb-hdrc.0 but parent (47401400.usb) is not active

I don't understand this.  Why wouldn't the parent be in RPM_ACTIVE at
this time?  After all, how could the system be expected to resume a
child device if its parent wasn't fully active?

In general, during a system resume callback we should bring a device
back to full power, tell the PM core that this has been done, and leave
it at full power until the whole system resume is finished.  For
efficiency we can avoid doing this in cases where the device was in
runtime suspend before the system suspend began, but you have to be
very careful about it -- see the documentation for the ->prepare
callback in Documentation/driver-api/pm/devices.rst.

Alan Stern
