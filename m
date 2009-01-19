From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 11:07:55 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D6A1D56@dlee02.ent.ti.com>
References: <1232360583.6481.92.camel@tubuntu>
 <13B9B4C6EF24D648824FF11BE8967162036D6A19F2@dlee02.ent.ti.com>
 <20090119134329.GA18301@n2100.arm.linux.org.uk>
 <13B9B4C6EF24D648824FF11BE8967162036D6A1A0F@dlee02.ent.ti.com>
 <20090119135654.GB18301@n2100.arm.linux.org.uk>
 <op.un0ew10nl1df02@matts.therealanswer.com>
 <20090119152237.GC18301@n2100.arm.linux.org.uk>
 <op.un0ggdb6l1df02@matts.therealanswer.com>
 <20090119155857.GD18301@n2100.arm.linux.org.uk>
 <20090119161358.GE18301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53044 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697AbZASRIQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 12:08:16 -0500
In-Reply-To: <20090119161358.GE18301@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Matt Gerassimoff <mgeras@gmail.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 > The other thing to point out is that vunmap() does its work lazily
> (as Richard tried to point out).  However, it'll become unlazy when
> it has more than 32MB * NR_CPUS to deal with.  So, make sure that your
> ioremap/vmalloc region is larger than 32MB otherwise you'll still see
> crashes.

Where we felt the most problems in past years was in low physical memory situations with this kind of looping.

The system would get caught in a live lock in rebalance code. That code tries to shrink caches but needs some allocations for it to happen.  Maybe 2.6.29 code is better in this regard.

The other common but easier to fix spot was test code where user space mmap callers would spin in alloc and free. The MMAP calls would always fail after a while.

I've not hear reports for a while so maybe current kernel is great here or the tests aren't being run anymore.

Glad RMK has found the root cause for this issue.

Regards,
Richard W.
