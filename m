From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: make wakeupgen_lock raw
Date: Fri, 1 Feb 2013 14:38:36 -0800
Message-ID: <20130201223836.GC22517@atomide.com>
References: <1354891787-24119-1-git-send-email-balbi@ti.com>
 <20130124182159.GL4424@arwen.pp.htv.fi>
 <51023995.1050703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:10124 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757779Ab3BAWik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 17:38:40 -0500
Content-Disposition: inline
In-Reply-To: <51023995.1050703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130124 23:54]:
> On Thursday 24 January 2013 11:52 PM, Felipe Balbi wrote:
> >Hi,
> >
> >On Fri, Dec 07, 2012 at 04:49:47PM +0200, Felipe Balbi wrote:
> >>From: Thomas Gleixner <tglx@linutronix.de>
> >>
> >>When applying RT patch on top of Linux, spinlocks are
> >>implemented as RT-mutexes, which means they are preemptable.
> >>
> >>Current GIC implementation on OMAP is using a spinlock
> >>to protect against preemption. As it turns out, we need
> >>to convert that lock into a raw_spinlock so that OMAP's
> >>interrupt controller works as expected after RT-patch
> >>is applied.
> >>
> >>This patch is simply to decrease the amount of changes
> >>RT-team needs to carry out of tree. It doesn't cause any
> >>changes in behavior.
> >>
> >>Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >>Signed-off-by: Felipe Balbi <balbi@ti.com>
> >
> Sorry i missed this patch. Tony can you please
> pick it up?
> 
> For the patch,
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 

Looks like no comments, so applying this into
omap-for-v3.9/fixes-non-critical.

Regards,

Tony 
 
