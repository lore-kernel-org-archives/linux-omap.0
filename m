From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] usb: host: ehci: allow ehci_* symbols to be unused
Date: Wed, 15 Feb 2012 10:48:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1202151048090.1638-100000@iolanthe.rowland.org>
References: <1329291266-15798-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37488 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751376Ab2BOPsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 10:48:31 -0500
In-Reply-To: <1329291266-15798-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>

On Wed, 15 Feb 2012, Felipe Balbi wrote:

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
> __maybe_unused annotation to those functions.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Changes from v1:
> 	- only add __maybe_used to relinquish_port, port_handed_over
> 		and port_change

Acked-by: Alan Stern <stern@rowland.harvard.edu>

