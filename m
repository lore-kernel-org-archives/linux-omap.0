From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 0/6] Suspend USB Host controller on bus suspend
Date: Wed, 19 Jun 2013 11:23:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306191121280.2026-100000@iolanthe.rowland.org>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371650753-11452-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, balbi@ti.com, ruslan.bilovol@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 19 Jun 2013, Roger Quadros wrote:

> Hi,
> 
> This series attempts to suspend the OMAP EHCI host controller on USB
> Bus suspend.

Why do you want to suspend the host controller during bus suspend?  
They are two different operations and should be carried out at two 
different times.  The controller should be suspended during controller 
suspend, not during bus suspend.

> As the omap-ehci controller driver needs to do some additional work to put
> itself into suspend/resume and make sure it is resumed to process an interrupt,
> we need to be able to override irq, bus_suspend, and bus_resume handlers. This
> provision is done in patch 3.

Do you still need to override these things if you do the controller
suspend at the right time?

Alan Stern
