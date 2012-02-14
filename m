From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: host: ehci: allow ehci_* symbols to be unused
Date: Tue, 14 Feb 2012 10:06:47 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1202140959320.1544-100000@iolanthe.rowland.org>
References: <1329210895-32513-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35939 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760752Ab2BNPGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 10:06:48 -0500
In-Reply-To: <1329210895-32513-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, 14 Feb 2012, Felipe Balbi wrote:

> not all platforms will use all of those ehci_*
> symbols on their hc_driver structure. Sometimes
> we might need to provide a modified version of
> a certain method or not provide it at all, as is
> the case with OMAPs which don't support port handoff
> feature.
> 
> Whenever we compile a kernel for an OMAP board with
> EHCI enabled, we get compile warnings:
> 
> drivers/usb/host/ehci-hub.c:1079: warning: 'ehci_relinquish_port' \
> 	defined but not used
> drivers/usb/host/ehci-hub.c:1088: warning: 'ehci_port_handed_over' \
> 	defined but not used
> 
> In order to cleanup those warnings, we're adding
> __maybe_unused annotation to those functions. We're
> also trying to cope with other platforms which might
> have similar issues with different methods by adding
> the same annotation to all ehci_* functions.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Alan, what do you think about this patch ? It fixes our warnings
> and tries to cope with other possible such cases.

Some of this makes sense: ehci_port_change, ehci_relinquish_port, 
and ehci_port_handed_over are fine.

The others are questionable.  What reason could there be for not 
implementing ehci_bus_suspend and ehci_bus_resume?  Neither of those 
should involve much platform-specific work, if any.

ehci_hub_status_data, ehci_hub_descriptor, and ehci_hub_control are 
even more puzzling.  These are things that _have_ to be implemented for 
the driver to work at all.  Platform code shouldn't replace them; it 
most it should call them as subroutines and override the results when 
necessary.

Alan Stern

