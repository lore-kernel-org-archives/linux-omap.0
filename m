From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] tidspbridge: use a parameter to allocate shared memory
Date: Thu, 7 Oct 2010 09:32:42 +0100
Message-ID: <20101007083242.GB14554@n2100.arm.linux.org.uk>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com> <201010070940.14208.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41992 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab0JGIdU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 04:33:20 -0400
Content-Disposition: inline
In-Reply-To: <201010070940.14208.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@suse.de>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

On Thu, Oct 07, 2010 at 09:40:12AM +0200, Laurent Pinchart wrote:
> Hi Omar,
> 
> On Thursday 07 October 2010 07:45:36 Omar Ramirez Luna wrote:
> > tidspbridge driver uses a block of memory denominated SHared Memory
> > to store info & communicate with DSP, this SHM needs to be physically
> > contiguous and non-cacheable,
> 
> There are non-cacheable mappings, but there's no such thing as non-cacheable 
> memory. Does the MPU mapping for that SHM block really needs to be non-
> cacheable, your could you instead flush the cache after writing to it 
> (performance issues might be involved, I don't know the details about that SHM 
> usage) ?

ARMv6 and above don't like having multiple mappings with different
memory type/shareability/cache attributes.  It's architecturally
forbidden.

So if you want non-cacheable memory and you want to be architecturally
compliant, you have to exclude it from the kernel's direct-mapped
memory mapping.
