From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention
 issue
Date: Fri, 22 Jun 2012 10:35:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206221034340.1578-100000@iolanthe.rowland.org>
References: <87vcij1loh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43728 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932484Ab2FVOfk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 10:35:40 -0400
In-Reply-To: <87vcij1loh.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, notasas@gmail.com

On Fri, 22 Jun 2012, Kevin Hilman wrote:

> As I said way back in the beginning this thread.  The runtime PM of this
> driver is leaving the device enabled.
> 
> To test idle retention, ensure the UART auto-suspend is enable for all
> UARTS:
> 
> echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
> 
> Then wait > 3 seconds and 'cat /debug/pm_debug/count'.  

This is probably a foolish question, but have you checked that the 
power/control attribute is set to "auto"?

Alan Stern

