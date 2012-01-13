From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 04:19:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201130306570.3659@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45875 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121Ab2AMLTs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 06:19:48 -0500
In-Reply-To: <20120112095940.0a54413e@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, linux-omap@vger.kernel.org

On Thu, 12 Jan 2012, NeilBrown wrote:

> On Wed, 11 Jan 2012 06:43:04 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> 
> Not off-mode - just retention.

Okay.  It's expected that the UART will drop the first byte also when CORE 
is in retention, due to the delay involved in waking up the chip.  But 
that shouldn't prevent the MPU from going into a low-power state.  I've 
sent a patch under separate cover that should fix this.

> > If the former, this is hardly surprising as the HDQ driver 
> > (drivers/w1/masters/omap_hdq.c) doesn't contain any context save/restore 
> > code.  In fact the HDQ driver doesn't even use PM runtime, so quite a bit 
> > of work is needed there. 
> 
> The HDQ driver does enable/disable the iclk and fclk.  I thought I read that
> having the clocks enabled would prevent the powerdomain from dropping to a
> lower-power state ??

Several years ago, we started handling all of the operations needed to 
quiesce and wake an IP block in a common integration layer called 'hwmod', 
which is currently called through the PM runtime functions.  This includes 
clk_{enable,disable}().  Unfortunately, due to some internal political 
reasons, not all of our drivers are converted to use PM runtime functions 
yet.  You just happened to hit one that isn't -- apparently very few 
people care very much about this driver...

> Could you suggest some other driver which does do the right sort of runtime
> PM that I could try copying?

I did a quick conversion for you.  The series is at 
git://git.pwsan.com/linux-2.6 in the branch named 'hdq_hwmod_runtime_pm'.  
Please let me know if it works.

I did boot-test it, and noticed that the hwmod subsystem was unable to 
softreset the device:

[    0.182769] omap_hwmod: hdq: softreset failed (waited 10000 usec)

This could be because I screwed up something in the hwmod data, or it 
could be that the HDQ reset hardware doesn't work correctly, similar to 
I2C.  If that presents a problem, you might add the HWMOD_INIT_NO_RESET 
flag to the struct omap_hwmod.flags field for the HDQ.

It also spit out these messages later, but I have no idea what they mean.  
At least the kernel seems to be able to access the HDQ registers:

[    1.685272] omap_hdq omap_hdq: OMAP HDQ Hardware Rev 0.5. Driver in 
Interrupt mode
[    1.888153] w1_master_driver w1_bus_master1: Family 1 for 
01.000000000000.3d is not registered.


- Paul
