From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: CPU consumption is going as high as 95% on ARM Cortex A8
Date: Mon, 21 Dec 2009 09:07:50 +0000
Message-ID: <20091221090750.GA11669@n2100.arm.linux.org.uk>
References: <19F8576C6E063C45BE387C64729E73940449F43857@dbde02.ent.ti.com> <20091217095641.GA399@n2100.arm.linux.org.uk> <19F8576C6E063C45BE387C64729E73940449F43E29@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53350 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748AbZLUJKx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 04:10:53 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940449F43E29@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Dec 21, 2009 at 11:56:23AM +0530, Hiremath, Vaibhav wrote:
> >         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > 
> > will result in the memory being mapped as 'Strongly Ordered',
> > resulting
> > in there being multiple mappings with differing types.  In later
> > kernels, we have pgprot_dmacoherent() and I'd suggest changing the
> > above
> > macro for that.
> > 
> 
> I tried with your suggestion above but unfortunately it didn't work for
> me. I am seeing the same behavior with the pgprot_dmacoherent(). I
> pulled your patch (which got applied cleanly on 2.6.32-rc5) -

What happens if you comment out the pgprot_dmacoherent() / pgprot_noncached()
line completely?

I suspect that will "solve" the problem - but you'll then no longer have
DMA coherency with userspace, so its not really a solution.
