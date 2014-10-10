From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: RCU bug with v3.17-rc3 ?
Date: Fri, 10 Oct 2014 17:18:35 +0100
Message-ID: <20141010161835.GK12379@n2100.arm.linux.org.uk>
References: <20140904192535.GJ13421@saruman.home> <20140904200403.GL13421@saruman.home> <20140905213216.GD5001@linux.vnet.ibm.com> <20141008171322.GH22688@saruman> <20141008175707.GI22688@saruman> <20141008212938.GP22688@saruman> <20141009160138.GA2396@cmpxchg.org> <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian> <20141009214706.GC4606@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60041 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751535AbaJJQS7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2014 12:18:59 -0400
Content-Disposition: inline
In-Reply-To: <20141009214706.GC4606@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rabin Vincent <rabin@rab.in>, Rik van Riel <riel@redhat.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, josh@joshtriplett.org, Felipe Balbi <balbi@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Johannes Weiner <hannes@cmpxchg.org>, Sasha Levin <sasha.levin@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Fri, Oct 10, 2014 at 12:47:06AM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Thu, Oct 09, 2014 at 10:41:01PM +0200, Rabin Vincent wrote:
> >   What GCC version are you using?
> >   
> >   4.8.1 and 4.8.2 are known to miscompile the ARM kernel and these
> >   find_get_entry() crashes with 0xffffffff involved smell a lot like the
> >   earlier reports from kernels build with those compilers:
> >   
> >   https://lkml.org/lkml/2014/6/25/456
> >   https://lkml.org/lkml/2014/6/30/375
> >   https://lkml.org/lkml/2014/6/30/660
> >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854
> >   https://lkml.org/lkml/2014/5/9/330
> 
> Is it possible to blacklist those GCC versions on ARM somehow as it
> seems people are still using them?
> 
> This bug also ruined a file system on one of my boxes last year
> (see e.g. http://marc.info/?l=linux-arm-kernel&m=139033442527244&w=2).

Given that, why the fsck (pun intended) did you not shout a little louder
about getting it blacklisted.  Looking at your marc.info URL, there's
very little information there which hints at filesystem corruption, and
it's a thread of only *one* message according to marc.info.

Even _if_ I did read the message you point to above, that on its own did
not hint at filesystem corruption.

So, would you please mind passing on further details about this,
specifically which function in the ext4 code is affected, so it can
be properly written up.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
