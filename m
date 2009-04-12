From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] Save HSMMC registers if core is powered off
Date: Sun, 12 Apr 2009 16:54:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904121630580.32081@utopia.booyaka.com>
References: <1239435130-30784-1-git-send-email-Russ.Dill@gmail.com> <f9d2a5e10904110204x30662644se51ac24c7f94fbcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60226 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbZDLWyx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Apr 2009 18:54:53 -0400
In-Reply-To: <f9d2a5e10904110204x30662644se51ac24c7f94fbcf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: beagleboard@googlegroups.com, linux-omap@vger.kernel.org

Hello Russ,

On Sat, 11 Apr 2009, Russ Dill wrote:

> On Sat, Apr 11, 2009 at 12:32 AM, Russ Dill <russ.dill@gmail.com> wrote:
> > I've noticed that if the core power domain gets powered off during
> > suspend, the MMC registers get reset. Which, among other things causes
> > the MMC host controller code to turn on VMMC1 even if no MMC card is
> > present.
> >
> > I'm not sure if this is the right place to put this code. It also
> > doesn't work. If any of the __raw_readl commands execute, the board will
> > hang on a suspend attempt (assuming the core domain will be powered
> > off.) Strangely, the __raw_writel commands don't cause problems (other
> > than writing 0s to all the MMC registers.)
> 
> That would be because omap_mmc_suspend disables the interface clock.
> The suspend method is a more logical place to save these registers,
> but I'm not sure how to tell from the suspend method if the domain is
> going to be turned off or not.

Generally speaking, the device driver doesn't know this.  The powerdomain 
target state decision may change after the device goes idle.  So the best 
thing to do is to save context unconditionally before disabling clocks.

Another approach to saving device context that should work for most 
registers is to save the register contents when the device registers are 
written -- the "shadow register" approach.  That approach avoids 
unnecessary latency in the device idle path and avoids some register 
reads.

One other possible optimization.  In the event that the device context is 
not lost, an unnecessary context restore can be avoided by using the 
omap_pm_get_dev_context_loss_count() function.  (This is documented in 
plat-omap/include/mach/omap-pm.h)  This function should be used by passing 
a function pointer to the driver code in struct omap_mmc_platform_data, 
called 'get_dev_context_loss_count' -- this should look something like the 
example at the end of this E-mail.

Hope this helps,


- Paul


... In driver idle path, before clk_disable() ...

int loss_count;
if (pdata->get_dev_context_loss_count)
	loss_count = pdata->get_dev_context_loss_count();


... In driver resume path, after clk_enable() ...
int restore_needed = 1;
if (pdata->get_dev_context_loss_count)
	if (pdata->get_dev_context_loss_count() == loss_count)
		restore_needed = 0;

if (restore_needed)
	/* restore device registers here */



