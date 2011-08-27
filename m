From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Issue: Runtime API usage in wake-up device irq_handler
 during wakeup from system-wide-suspend.
Date: Sat, 27 Aug 2011 10:01:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108270958320.17264-100000@netrider.rowland.org>
References: <4E588EEA.7090004@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:34565 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751904Ab1H0OBx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Aug 2011 10:01:53 -0400
In-Reply-To: <4E588EEA.7090004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Partha Basak <p-basak2@ti.com>, Tero Kristo <t-kristo@ti.com>, Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Sat, 27 Aug 2011, Santosh wrote:

> I might be wrong here, but after discussion with Govindraj on this
> issue, it seems there is a flaw in the way OMAP chain handler
> handling the child interrupts.
> 
> On OMAP, we have special interrupt wakeup source at PRCM level and
> many devices can trigger wakeup from low power via this common
> interrupt source. The common interrupt source upon wakeup from low
> power state, decodes the source of interrupt and based on that
> source, calls the respective device ISR directly.
> 
> The issue I see here is, the ISR on _a_ device (UART in this case)
> is happening even before UART resume and DPM resume has been completed.
> If this is the case, then it is surely asking for trouble. Because not
> just clocks, but even driver state machine is already in suspend state
> when the ISR is called.

If the driver state machine is in the suspend state when the ISR is
called, then the ISR should realize it is handling a wakeup event
instead of a normal I/O event.  All it needs to do is turn off the
interrupt source; the event itself will be taken care of during the
device's resume callback.

Alan Stern

