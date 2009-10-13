From: epsi@gmx.de
Subject: Re: Memory performance  / Cache problem
Date: Tue, 13 Oct 2009 11:13:33 +0200
Message-ID: <20091013091333.141260@gmx.net>
References: <20091012075409.186580@gmx.net>
 <200910121135.15191.siarhei.siamashka@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:38925 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753952AbZJMJOe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Oct 2009 05:14:34 -0400
In-Reply-To: <200910121135.15191.siarhei.siamashka@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: linux-omap@vger.kernel.org

The L2 cache is set and running.
I don't know - can it be configured or misconfigured somehow?

I just checked the output of 2.6.22 kernel and get these lines (which I don't have in newer kernels):

CPU0: D VIPT write-through cache
CPU0: cache: 768 bytes, associativity 1, 8 byte lines, 64 sets
Built 1 zonelists.  Total pages: 32512

I am wondering what is this? First thought was L1 cache, but it's to small. 

The benchmark is running on same hardware, same uboot, same rootfs, just the kernel is different.


> On Monday 12 October 2009 10:54:09 ext epsi@gmx.de wrote:
> > I found the memory performance of newer kernels are quit poor on an
> > EVM-Omap3 board. It works with 2-6 times performance on the old 2.6.22
> > kernel from TI's PSP.
> >
> > Possible reasons:
> > - problem in config the kernel (did omap3_evm_defconfig)
> > - problem in kernel
> > - kernel expects some settings from uboot, which are not done there
> >
> > I have tried the 2.6.29rc3 (from TI's PSP) and the 2.6.31 from git-tree.
> > Both behave quite simular:
> >
> > Transport in MByte:
> >   memcpy =   204.073, loop4 =   183.212, loop1 =    81.693, rand =
> > 4.534
> >
> > while the 22 kernel:
> >  memcpy =   453.932, loop4 =   469.934, loop1 =   125.031, rand =
> > 29.631
> >
> > Can someone give me help or can at least confirm that?
> 
> The numbers from 2.6.22 kernel look much better than anything I have ever
> seen with OMAP3.
> 
> How are you doing benchmarking? Is source buffer properly initialized?
> 
> The point is that if you just happen to allocate a large buffer without
> initializing it, it may end up having all the memory pages referencing to
> a
> single zero page in physical memory. In this case reading from this buffer
> will in fact be perfectly cached in L1 cache and memcpy would look fast.
> 
> If it is not the case, investigating how to boost memory performance in
> the
> latest kernels is very interesting for sure.
> 
> -- 
> Best regards,
> Siarhei Siamashka


-- 
Neu: GMX DSL bis 50.000 kBit/s und 200,- Euro Startguthaben!
http://portal.gmx.net/de/go/dsl02
