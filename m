From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
Date: Sat, 2 Feb 2013 10:11:48 -0800
Message-ID: <20130202181147.GC577@atomide.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
 <1359736726-10193-3-git-send-email-jon-hunter@ti.com>
 <20130201215154.GV22517@atomide.com>
 <510C6A3D.70401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56704 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757210Ab3BBSLu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Feb 2013 13:11:50 -0500
Content-Disposition: inline
In-Reply-To: <510C6A3D.70401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>

* Jon Hunter <jon-hunter@ti.com> [130201 17:25]:
> 
> On 02/01/2013 03:51 PM, Tony Lindgren wrote:
> > 
> > How about let's fix this properly to start with so we don't add
> > more blockers moving this code to drivers/bus?
> > 
> > Looks like gpmc_mem_init() gets called from gpmc_probe() so
> > we can pass that information in pdev.
> 
> I wondered if you would suggest that ;-)

:)
 
> I definitely can and it is probably best. Things like this become
> painful when we move to device-tree. We really need a generic way for
> passing stuff like this to drivers for omap. Our options are auxdata or
> bus notifiers. I am wondering whether we can plug pdata in the
> omap_device bus notifier for device-tree. Let me know if you have any
> thoughts.

Hmm but in this case can't you just do it based on the compatible
flag? For legacy systems we also need to pass it in pdata.

Regarding omap_device, we should find a way to keep the dependencies
between drivers and the bus code down to minimum. So ideally things
like this would be only done using just the compatible flag. But the
pdata we cannot remove quite yet.

Regards,

Tony
