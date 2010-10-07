From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] tidspbridge: use a parameter to allocate shared memory
Date: Thu, 7 Oct 2010 20:07:00 +0100
Message-ID: <20101007190700.GB26435@n2100.arm.linux.org.uk>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com> <201010070940.14208.laurent.pinchart@ideasonboard.com> <20101007083242.GB14554@n2100.arm.linux.org.uk> <201010071601.04597.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36750 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab0JGTHk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 15:07:40 -0400
Content-Disposition: inline
In-Reply-To: <201010071601.04597.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@suse.de>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

On Thu, Oct 07, 2010 at 04:01:02PM +0200, Laurent Pinchart wrote:
> Do we have an infrastructure, or even an embryo thereof, to remove pages from 
> the kernel's direct-mapped memory mapping at runtime ? The use of super pages 
> probably complicates the matter.

No, and yes, using section mappings/supersection mappings further
complicates the issue because these are duplicated across all
processes in the system.

Even if you did walk all processes in the system, if your system is SMP
without h/w TLB broadcasting, you'd need to IPI the other CPUs and wait
for the IPI to complete - which you can not do if you're trying to
allocate non-cacheable memory from IRQ context.

We _could_ reduce TASK_SIZE to be slightly below 2GB, which then means
we can split the page tables in hardware, but I don't think its safe to
assume that the kernel will always use the init_mm page table to lookup
the >2GB page table entries.
