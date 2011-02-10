From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/RFC/PATCH 00/13] CBUS meets GENIRQ
Date: Thu, 10 Feb 2011 11:14:47 +0200
Message-ID: <20110210091447.GA3580@legolas.emea.dhcp.ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
 <20110210024349.GI20795@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37379 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751238Ab1BJJOw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 04:14:52 -0500
Received: by fxm20 with SMTP id 20so1221573fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 01:14:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110210024349.GI20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Wed, Feb 09, 2011 at 06:43:49PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110203 02:20]:
> > Hi Tony,
> > 
> > When you have some extra time, could you run these on N810
> > to check whether I'm on the right path ? After these patches
> > all CBUS drivers are using standard request_threaded_irq()
> > calls. It's one step closer into getting those in mainline.
> 
> Cool sorry it took a while, this is starting to look like

no problem ;-)

> it will be pretty close to be posted for merging :)

yeah, I guess so too.

> I guess we should move files around to have:
> 
> drivers/mfd/cbus-retu.c
> drivers/mfd/cbus-tahvo.c
> 
> drivers/rtc/rtc-cbus-retu.c

sure we gotta do that.

> Anything else remaining to do?

there are a few things remaining still. The drivers aren't as good as
I'd like them to be yet.

> Also the following patch was needed to get this to boot
> with interrupts working. Maybe you have a better plan
> for getting the retu irq_base?

That's on my TODO list, I need to pass IRQ number via pdata.

> Anyways, since n8x0 boots and stays up, we know it's
> working, so I've pushed them all to the cbus branch.

Cool thanks. I'll update my local cbus branch based on yours and try to
find some time to play with the last few stuff. Maybe I'll have some
small time during the weekend which I could use to play with it.

-- 
balbi
