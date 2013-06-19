From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during bus suspend
Date: Wed, 19 Jun 2013 10:39:09 -0700
Message-ID: <87r4fy6lvm.fsf@linaro.org>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
	<1371650753-11452-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371650753-11452-5-git-send-email-rogerq@ti.com> (Roger
	Quadros's message of "Wed, 19 Jun 2013 17:05:51 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: stern@rowland.harvard.edu, tony@atomide.com, balbi@ti.com, ruslan.bilovol@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

Roger Quadros <rogerq@ti.com> writes:

> Runtime suspend the controller during bus suspend and resume it
> during bus resume. This will ensure that the USB Host power domain
> enters lower power state and does not prevent the SoC from
> endering deeper sleep states.
>
> Remote wakeup will come up as an interrupt while the controller
> is suspended, so tackle it carefully using a workqueue.

I don't think you need a special workqueue here.  The workqueue of the PM
core (pm_wq) will be used if you just use an asynchronous 'get' in the
ISR.  Then, the driver's own runtime PM callbacks can be used instead of
an additional workqueue.

Another thing to worry about here when using runtime PM to implement
suspend/resume is that runtime PM can be disabled from userspace (e.g.
echo disabled > /sys/devices/.../power/control.)  If that's the case,
all the pm_runtime_suspended() checks will always fail becuase that
call also checks if runtime PM is disabled.  You'll likely want to use
the pm_runtime_status_suspended() check instead, which checks only the
status, and doesn't matter if runtime PM is currently disabled.

Because of the corner issues here, please test system suspend/resume
when runtime PM has been disabled.

Kevin
