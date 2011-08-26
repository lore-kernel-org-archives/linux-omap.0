From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Issue: Runtime API usage in wake-up device irq_handler
 during wakeup from system-wide-suspend.
Date: Fri, 26 Aug 2011 14:36:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108261429340.2275-100000@netrider.rowland.org>
References: <1314363693-20831-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:53088 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751023Ab1HZSg1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Aug 2011 14:36:27 -0400
In-Reply-To: <1314363693-20831-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>, Felipe Balbi <balbi@ti.com>, Partha Basak <p-basak2@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Fri, 26 Aug 2011, Govindraj.R wrote:

> Hello,
> 
> During system_wide_suspend pm runtime is disabled.
> I.e. __pm_runtime_disable is called from __device_suspend.
> Now, if a wakeup interrupt is triggered and the wakeup device irq handler
> is called even before device_resume and pm_runtime_enable happens,
> the device irq_handler proceeds to enable clock with runtime API to
> handle wakeup event.
>  
> Wouldn't this result in system wide abort since the pm_runtime is not enabled
> yet from dpm_resume?
> As we end up accessing regs after doing runtime get_sync.
>  
> Looks like this scenario is not handled currently.
> Or Am I missing something here?

I don't have the complete picture, but it seems that the IRQ handler 
needs to check the return code from pm_runtime_get_sync().  If the call 
fails then the handler shouldn't try to access the device registers.

In the case of a genuine wakeup event, the event should be handled 
later on as part of the resume or resume_noirq processing.

However, this does raise a potential problem.  What happens if the 
clocks are needed in order to turn off the IRQ source?  Runtime PM 
won't allow the clocks to be enabled until after interrupts have been 
enabled, and by then it will be too late -- the source will have caused 
an interrupt storm.

Alan Stern

