From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 00/11] ARM: OMAP: DMTIMER clean-up and fixes in preparation
 for device-tree
Date: Mon, 4 Jun 2012 12:29:38 -0500
Message-ID: <4FCCF082.7020705@ti.com>
References: <1338830555-20469-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45246 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab2FDR3j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 13:29:39 -0400
In-Reply-To: <1338830555-20469-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>


On 06/04/2012 12:22 PM, Jon Hunter wrote:
> In order to migrate the dmtimer driver to support device-tree I found that it
> was first necessary to clean-up the timer platform data. The goal of this
> series is to simplify the timer platform data structure from ...
> 
> struct dmtimer_platform_data {
> 	int (*set_timer_src)(struct platform_device *pdev, int source);
> 	int timer_ip_version;
> 	u32 needs_manual_reset:1;
> 	bool reserved;
> 	bool loses_context;
> 	int (*get_context_loss_count)(struct device *dev);
> };
> 
> to ...
> 
> struct dmtimer_platform_data {
> 	int (*set_timer_src)(struct platform_device *pdev, int source);
> 	u32 timer_capability;
> };
> 
> ... where timer_capability is a bit mask that indicates the timer features
> supported and uses the HWMOD timer capabilities flags described in
> plat/dmtimer.h. For OMAP2+ devices this allows us to read the timer
> capabilities from the HWMOD data and for OMAP1 devices the flags are simply
> populated by the timer initialisation code. Eventually, the aim is to read the
> timer capabilities from the device tree blob.
> 
> This series includes some fixes as well as clean-up. For instance OMAP1 dmtimer
> support is currently completely broken and so I have included a fix for this.
> If it is preferred to split the series into fixes and clean-up I can do that.
> 
> This series is based upon the current linux-omap master branch (3.5-rc1). I have
> built both omap1 and omap2plus configurations as well as booted the respective
> kernels on the omap5912 OSK (omap1), OMAP3430 Beagle and OMAP4460 PANDA.

Forgot to add high-level changes for V2:

V2:
- Fix OMAP1 dmtimer support which currently broken. Requesting a timer
  fails because clk_get() is called and this is not support for OMAP1
  devices.
- Only use "set_timer_src" function pointer for OMAP1 devices.

Testing:
- On the above boards I have tested that I can request a timer and set
  the parent clock.

Cheers
Jon
