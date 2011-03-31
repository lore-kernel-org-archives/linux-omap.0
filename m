From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 14:23:08 +0200
Message-ID: <20110331122308.GG7420@game.jcrosoft.org>
References: <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
	<alpine.LFD.2.00.1103301531420.28032@xanadu.home>
	<AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
	<alpine.LFD.2.00.1103301814250.28032@xanadu.home>
	<alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm>
	<alpine.LFD.2.00.1103302255280.28032@xanadu.home>
	<AANLkTikV5OMifKjWRVdtJLEcxcZ56jrjWLYJBX89pHQ0@mail.gmail.com>
	<alpine.LFD.2.00.1103310012500.28032@xanadu.home>
	<20110331105440.42692165@lxorguk.ukuu.org.uk>
	<20110331105000.GC14323@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110331105000.GC14323@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: david@lang.hm, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Dave Airlie <airlied@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On 11:50 Thu 31 Mar     , Russell King - ARM Linux wrote:
> On Thu, Mar 31, 2011 at 10:54:40AM +0100, Alan Cox wrote:
> > If I boot it on a current PC I'm booting on a multiprocessor system with
> > different timers, totally different IRQ controllers, different keyboard
> > controllers (USB), PCI Express, an IOMMU, NCQ SATA, ACPI, graphics
> > running in shared host memory able to give/take pages from the host,
> > extra instructions, etc etc
> > 
> > And the same kernel boots just fine on both just fine.
> 
> We've been there for a long time with ARM.  Right from the start I had
> a single kernel image which booted over a range of ARM CPUs and
> platforms.
> 
> As far as ARM CPU architectures go, today we can have a single kernel
> image which covers ARMv3 to ARMv5, and a separate kernel image which
> covers ARMv6 to ARMv7 including SMP and UP variants.  The thing which
> currently stops ARMv3 to ARMv7 all together is the different page table
> layouts, the ASID tagging, the exclusive load/store support for cmpxchg
> and other atomic operations, etc.
As we can see a lots of people work on this, to now do not add thousand of
boards but try to have only a few

Personnaly I do it on at91 as example and will continue to try to have one board in
the kernel with board information pass via Barebox, when it's possible.
I think it's a common effort doen by the ARM Community and this will imply
a lots of changesets.

The work done by Linaro with the device tree will help a lot to simplify the
pass of the information from the boot loader to the kernel. But we can already
do it today.

Best Regards,
J.
