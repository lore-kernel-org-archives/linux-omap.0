From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP2: UART: fix console UART mismatched runtime
	PM status
Date: Wed, 17 Oct 2012 09:28:18 +0100
Message-ID: <20121017082818.GZ28061@n2100.arm.linux.org.uk>
References: <1350344998-16328-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53860 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab2JQI22 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 04:28:28 -0400
Content-Disposition: inline
In-Reply-To: <1350344998-16328-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>

On Mon, Oct 15, 2012 at 04:49:58PM -0700, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
> 
> The runtime PM framework assumes that the hardware state of devices
> when initialized is disabled.  For all omap_devices, we idle/disable
> device by default.  However, the console uart uses a "no idle" option
> during omap_device init in order to allow earlyprintk usage to work
> seamlessly during boot.
> 
> Because the hardware is left partially enabled after init (whatever
> the bootloader settings were), the omap_device should later be fully
> initialized (including mux) and the runtime PM framework should be
> told that the device is active, and not disabled so that the hardware
> state is in sync with runtime PM state.
> 
> To fix, after the device has been created/registered, call
> omap_device_enable() to finialize init and use pm_runtime_set_active()
> to tell the runtime PM core the device is enabled.

I still believe you're better off with the approach I gave.  Why?
Because every driver you have contains virtually the same sequence of
runtime PM "initialization" which is to runtime PM enable the device
and then do a get on it.

Why not do that in bus code if all your drivers are doing the same
thing, and kill off a bunch of code in the drivers?

It's fairly easy to do with the BUS_NOTIFY_BIND_DRIVER / BUS_NOTIFY_UNBIND_DRIVER
bus level notifies, and you've already hooked the notifier list for
these callbacks in omap_device.c
