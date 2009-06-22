From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading
	issue
Date: Mon, 22 Jun 2009 15:43:39 +0300
Message-ID: <20090622124338.GE7352@atomide.com>
References: <notify-1245247047@atomide.com> <87vdmuyhxc.fsf@deeprootsystems.com> <FCCFB4CDC6E5564B9182F639FC35608702F53D1897@dbde02.ent.ti.com> <20090618052710.GB8482@atomide.com> <87ab45vdg8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51181 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbZFVMnl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 08:43:41 -0400
Content-Disposition: inline
In-Reply-To: <87ab45vdg8.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Kevin Hilman <khilman@deeprootsystems.com> [090618 17:12]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Pandita, Vikram <vikram.pandita@ti.com> [090617 19:26]:
> >> 
> >> 
> >> >-----Original Message-----
> >> >From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >> >Sent: Wednesday, June 17, 2009 10:55 AM
> >> >To: Tony Lindgren; Pandita, Vikram
> >> >Cc: linux-omap@vger.kernel.org
> >> >Subject: Re: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading issue
> >> >
> >> >Tony Lindgren <tony@atomide.com> writes:
> >> >
> >> >> This patch has been applied to the linux-omap
> >> >> by youw fwiendly patch wobot.
> >> >>
> >> >> Branch in linux-omap: omap-fixes
> >> >>
> >> >> Initial commit ID (Likely to change): f84eca35d44fd64cdde542f12d08eb04ca534954
> >> >>
> >> >> PatchWorks
> >> >> http://patchwork.kernel.org/patch/29668/
> >> >>
> >> >> Git (Likely to change, and takes a while to get mirrored)
> >> >> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
> >> >2.6.git;a=commit;h=f84eca35d44fd64cdde542f12d08eb04ca534954
> >> >
> >> >Sorry, I didn't get to this beforethe merge, but $SUBJECT for this
> >> >patch is wrong and not terribly helpful.  It refers to the symptom, bu
> >> >tnot the root cause.
> >> >
> >> >It should be something like:
> >> >
> >> >OMAP3: Zoom2: pass IRQ triggering flags for serial driver
> >> 
> >> Yes that should have been the subject and 
> >> is put that way for the 8250 driver:
> >> http://lists.arm.linux.org.uk/lurker/attach/1@20090612.173251.776f9eda.attach
> >> 
> >> It's learning for next time.
> >
> > Will revert. I guess we now need two 8250 patches upstream? One for the
> > omap register define, and one for the interrupt flags?
> 
> Yes, both of these are pending on LKML, and still no word from Alan.
> 
> To get it upstream, I defined wake-up register locally in
> mach-omap2/serial.c until the patch gets merged, but for the interrupt
> flags there isn't an easy solution.

OK, so it's the irqflags that we still need. I took a look and commented that
we should rather have irqflags field in struct uart_port instead.. So let's
just wait and see until we have some ack from Alan.

Regards,

Tony
