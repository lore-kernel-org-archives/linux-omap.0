From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] ARM: Avoid discarding sections that might have
	SMP_ON_UP fixups SMP_ON_UP fixups
Date: Thu, 27 Jan 2011 16:46:01 +0000
Message-ID: <20110127164601.GD26418@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1101261617190.8580@xanadu.home> <20110127143709.GA13735@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50669 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1A0Qsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 11:48:55 -0500
Content-Disposition: inline
In-Reply-To: <20110127143709.GA13735@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 27, 2011 at 02:37:09PM +0000, Dave Martin wrote:
> On Wed, Jan 26, 2011 at 04:31:37PM -0500, Nicolas Pitre wrote:
> > Since discarded sections are by definition not used, we should at least 
> > put them into the .init section so to discard them at run time.  And 
> > only the EXIT_TEXT and EXIT_DATA would need to be kept (see x86 for 
> > example).
> > 
> > 
> > Nicolas
> 
> I'll check up on whether we need to care about writable data.
> For now I've just attempted to move stuff to .init.

You can keep the discarding of the unwind data for exit sections as
the exit sections don't depend on the unwind data.

It's all to do with sections being referenced from other sections.  If
a section being kept references a section being discarded, then the
linker will error out.  You need to keep any section that is being
referenced - but you don't need to keep sections which only reference
those being kept.

I'd also prefer to see a 'KEEP_EXIT' macro as I think we can discard
these sections in more cases than just SMP_ON_UP.  I think it's:

SMP_ON_UP && !DEBUG_SPINLOCK

which requires it.  So if you have spinlock debugging enabled you can
discard the exit sections.  See include/linux/spinlock.h.
