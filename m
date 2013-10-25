From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH] arm: omap2plus_defconfig: enable more drivers
Date: Fri, 25 Oct 2013 07:44:26 -0700
Message-ID: <20131025144426.GA15154@atomide.com>
References: <1382710831-5758-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:32491 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753349Ab3JYOo2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 10:44:28 -0400
Content-Disposition: inline
In-Reply-To: <1382710831-5758-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [131025 07:20]:
> enable a few more drivers as modules on omap2plus_defconfig,
> this helps us getting more platforms working out of the box
> by just building omap2plus_defconfig.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Hi Tony,
> 
> would you consider enabling these drivers ? I didn't, yet,
> make sure that these drivers won't cause PM regressions. Wanted
> to make sure you'd be ok enabling so many of them.

Sure, we should have all common drivers enabled, preferrably as
loadable modules where possible.

Probably at least MUSB gadgets need to be loadable modulees as at
least I have my test setup in a rack with USB cables connected
all the time. That way the PM tests can be done without the USB
modules loaded.

Or maybe we can just PM runtime suspend the USB drivers for PM
tests?

Regards,

Tony
