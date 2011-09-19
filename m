From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 10/11] ARM: pm: convert some assembly to C
Date: Mon, 19 Sep 2011 17:32:15 +0100
Message-ID: <20110919163215.GD16591@n2100.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk> <E1Qz6k7-00078l-SM@rmk-PC.arm.linux.org.uk> <20110907154828.GA21987@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47989 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756479Ab1ISQcc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 12:32:32 -0400
Content-Disposition: inline
In-Reply-To: <20110907154828.GA21987@e102568-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Sep 07, 2011 at 04:48:28PM +0100, Lorenzo Pieralisi wrote:
> > @@ -29,8 +48,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
> >  	 * resume (indicated by a zero return code), we need to switch
> >  	 * back to the correct page tables.
> >  	 */
> > -	ret = __cpu_suspend(virt_to_phys(suspend_pgd),
> > -			    PHYS_OFFSET - PAGE_OFFSET, arg, fn);
> > +	ret = __cpu_suspend(arg, fn);
> >  	if (ret == 0)
> >  		cpu_switch_mm(mm->pgd, mm);
> 
> It is still early testing, but without a local tlb flush here I am getting
> random segmentation faults in user space.
> My fear is that 1:1 global TLB entries cause issues if user space processes 
> happen to map those pages at addresses overlapping 1:1 mapping set-up for 
> resume and we do not flush the TLB.

Yes, having the global TLB entry potentially in userspace is a problem.
I don't think we can get around this any other way than by calling
local_flush_tlb_all() here.  I'll post an updated series shortly.
