From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Wed, 5 May 2010 16:02:09 +0100
Message-ID: <20100505150209.GC2606@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46698 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934437Ab0EEPCV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 11:02:21 -0400
Content-Disposition: inline
In-Reply-To: <20100325233248.GM24984@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, Mar 25, 2010 at 11:32:48PM +0000, Russell King - ARM Linux wrote:
> LMB... logical memory blocks.
> 
> LM is a different method of managing memory regions during the early
> boot period when the usual kernel memory allocators are not up and
> running.  LMB has been in the kernel for quite some time, and is
> already being used by Microblaze, PPC, SH and Sparc.  Maybe soon x86
> as well.
> 
> The motivation for this is that there appears to be plans to kill off
> the other method - bootmem.  (see discussions on the linux-arch ml.)

I've now queued the first three patches in this series for the next
merge window, which is basically the preparation for moving to LMB.
Essentially, that's:

- removing useless includes of linux/bootmem.h
- sorting the meminfo array prior to sanity_check_meminfo()
- moving the mapping of lowmem into mmu.c and making create_mapping()
  static

None of these changes should affect any currently merged platforms, and
wouldn't be affected by Ben's LMB updates either.
