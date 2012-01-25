From: Paul Walmsley <paul@pwsan.com>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Wed, 25 Jan 2012 14:18:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com>
References: <4F206213.9070704@flatfrog.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38840 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab2AYVSI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 16:18:08 -0500
In-Reply-To: <4F206213.9070704@flatfrog.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Orjan Friberg <of@flatfrog.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

On Wed, 25 Jan 2012, Orjan Friberg wrote:

> With CONFIG_PREEMPT=y and hammering away on two different JFFS2 partitions on
> a NAND flash I get an oops within ~10 seconds.  This is on a BeagleBoard xM
> (rev A2, with NAND).
> 
> I've boiled it down to whether CONFIG_PREEMPT (bug happens) or
> CONFIG_PREEMPT_VOLUNTARY (bug doesn't happen) is selected.  Of course,
> changing that affects a other things like inline spinlocking.  Turning on
> CONFIG_DEBUG_SPINLOCK reveals nothing.
> 
> By changing this option, I've made the bug go away in a 2.6.32 and
> 2.6.37 setup where it previously happened, and I've made it appear in a
> 2.6.39 setup where it previously didn't happen.
> 
> Pointers on what to look at next are appreciated.  (I've posted this on the
> mtd-utils mailing list too.)  More details below.

...

> Sometimes the oops trace originates from the garbage collector, 
> sometimes the result is a JFFS2 decompress error.

The problem is unlikely to be OMAP-specific, given the oops you sent.

Here are some suggestions for debugging:

- Try changing all the spin_lock() calls to spin_lock_irqsave() and all 
  the spin_unlock() calls to spin_unlock_irqrestore() to see if the 
  preemption count is being prematurely decremented

- If your oopses are consistently in the same places, add some debugging 
  to that code to determine which line is actually causing the oops.  
  Either that, or try disassembling the function to see what instruction 
  is causing the problem, and reference that back to the source file.  The 
  latter is actually preferable since it is less likely to cause the 
  problem to mysteriously disappear.  Doing this analysis should provide a 
  good clue as to where to look next.  I personally would be rather 
  suspicious of that

		ri->data_crc = cpu_to_je32(crc32(0, comprbuf, cdatalen));

  in jffs2_write_inode_range().

- Try turning on JFFS2 debugging and seeing if you can reproduce it.  
  The output might provide a clue as to where the problem would be.


- Paul
