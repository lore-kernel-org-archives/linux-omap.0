From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP: TWL4030 IRQ
Date: Mon, 3 Aug 2009 18:23:21 +0100
Message-ID: <20090803172321.GB32479@flint.arm.linux.org.uk>
References: <1248674448-17495-1-git-send-email-santosh.shilimkar@ti.com> <20090803163611.GB28606@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44365 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbZHCRXj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 13:23:39 -0400
Content-Disposition: inline
In-Reply-To: <20090803163611.GB28606@sortiz.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, Aug 03, 2009 at 06:36:12PM +0200, Samuel Ortiz wrote:
> Hi Santosh,
> 
> On Mon, Jul 27, 2009 at 11:30:48AM +0530, Santosh Shilimkar wrote:
> > From: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > (Rebased on 2.6.31-rc4)
> > 
> > The TWL4030 IRQ handler has a bug which leads to spinlock lock-up. It is
> > calling the 'unmask' function in a process context. :The mask/unmask/ack
> > functions are only designed to be called from the IRQ handler code,
> > or the proper API interfaces found in linux/interrupt.h.
> > 
> > Also there is no need to have IRQ chaining mechanism. The right way to
> > handle this is to claim the parent interrupt as a standard interrupt
> > and arrange for handle_twl4030_pih to take care of the rest of the devices.
> I'd like this one to be split in 2 different patches as you're addressing 2
> different issues here.

You'd like me to remove the IRQ handling entirely from this code as one
patch, thereby breaking it, and then add the new IRQ handling as a
separate patch?

Are you sure?

I really don't think so, and I suspect you haven't even read the patch.

It's all _one_ issue, with two explainations of why the current code is
wrong.

So my reply is: unable to split patch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
