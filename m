From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC] tidspbridge: use a parameter to allocate shared memory
Date: Thu, 7 Oct 2010 09:40:12 +0200
Message-ID: <201010070940.14208.laurent.pinchart@ideasonboard.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.irobotique.be ([92.243.18.41]:38084 "EHLO
	perceval.irobotique.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759524Ab0JGHj7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 03:39:59 -0400
In-Reply-To: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@suse.de>, Russell King <linux@arm.linux.org.uk>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

Hi Omar,

On Thursday 07 October 2010 07:45:36 Omar Ramirez Luna wrote:
> tidspbridge driver uses a block of memory denominated SHared Memory
> to store info & communicate with DSP, this SHM needs to be physically
> contiguous and non-cacheable,

There are non-cacheable mappings, but there's no such thing as non-cacheable 
memory. Does the MPU mapping for that SHM block really needs to be non-
cacheable, your could you instead flush the cache after writing to it 
(performance issues might be involved, I don't know the details about that SHM 
usage) ?

> to achieve the latter the driver ioremaps
> the memory reserved to be SHM, this will trigger a warning if the
> memory is under kernel control (because it creates another set of
> mapping attributes, for the same memory area).
> 
> For now this can be avoided if a portion of memory (6MB) is left out
> of kernel control (using bootarg attribute mem=) where tidspbridge
> driver can make use of the memory and ioremap it without above
> restriction.
> 
> Parameter has precedence over memblock allocator for shared memory.
> 
> i.e.: on a system with 256MB
> 
> set 'bootargs mem=250M ...'
> 
> cat /proc/iomem
> ...
> 80000000-8f9fffff : System RAM
> 
> So driver needs to be installed with:
> 
> insmod bridgedriver.ko phys_mempool_base=0x8FA00000
> 
> Same rationale applies for the menuconfig option.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

-- 
Regards,

Laurent Pinchart
