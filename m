From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/4] OMAP: PM: use omap_device API for suspend/resume
Date: Thu, 24 Jun 2010 01:06:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006240105010.1550@utopia.booyaka.com>
References: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com> <1274994799-30297-4-git-send-email-khilman@deeprootsystems.com> <5A47E75E594F054BAF48C5E4FC4B92AB032320719C@dbde02.ent.ti.com> <87mxvebrry.fsf@deeprootsystems.com>
 <alpine.DEB.2.00.1006210911150.1550@utopia.booyaka.com> <87hbkw1idx.fsf@deeprootsystems.com> <alpine.DEB.2.00.1006211130120.1550@utopia.booyaka.com> <87fx0gos2j.fsf@deeprootsystems.com> <alpine.DEB.2.00.1006231832570.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40719 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0FXHGU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 03:06:20 -0400
In-Reply-To: <alpine.DEB.2.00.1006231832570.1550@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Nayak\\, Rajendra" <rnayak@ti.com>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>

One correction here:

On Wed, 23 Jun 2010, Paul Walmsley wrote:

> On Mon, 21 Jun 2010, Kevin Hilman wrote:
> 
> > Just to clarify.  The functions I'm overriding here is the bus
> > functions (bus->pm->[suspend|resume]_noirq(), not any driver functions
> 
> OK, I see that now - this code was confusing in the patch's 
> platform_pm_suspend_noirq():
> 
> +       if (drv->pm) {
> +               if (drv->pm->suspend_noirq)
> +                       ret = drv->pm->suspend_noirq(dev);
> +       }
> 
> This is already done by the DPM core in 
> drivers/base/power/main.c:device_suspend_noirq() and will result in 
> re-executing the driver's suspend_noirq function, which is potentially 
> quite bad.  Same thing for platform_pm_resume_noirq() in the patch.

Sorry, misread this also.  Indeed, something like this is necessary in 
your platform bus override code - so please ignore this part of the 
comments.


- Paul
