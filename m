From: Nguyen Dinh-R00091 <R00091@freescale.com>
Subject: RE: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 19:20:12 +0000
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA1F8D18@039-SN1MPN1-004.039d.mgd.msft.net>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
 <4DA84AAB.60601@gmail.com> <20110415160339.GF4423@n2100.arm.linux.org.uk>
 <56132A77AB93C141BF06E6B96CA6CFEA1F88D9@039-SN1MPN1-004.039d.mgd.msft.net>
 <20110415162045.GG4423@n2100.arm.linux.org.uk>
 <20110415165857.GH4423@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:3041 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651Ab1DOTUS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 15:20:18 -0400
In-Reply-To: <20110415165857.GH4423@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


>-----Original Message-----
>From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
>Sent: Friday, April 15, 2011 11:59 AM
>To: Nguyen Dinh-R00091
>Cc: Kevin Hilman; davinci-linux-open-source@linux.davincidsp.com; Tony Lindgren; Sekhar Nori; linux-
>omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>Subject: Re: [RFC PATCH] Consolidate SRAM support
>
>On Fri, Apr 15, 2011 at 05:20:45PM +0100, Russell King - ARM Linux wrote:
>> On Fri, Apr 15, 2011 at 04:18:23PM +0000, Nguyen Dinh-R00091 wrote:
>> > >Hmm, that's nice - except for one issue.  According to my grep of
>> > >arch/arm/ and drivers/, nothing uses iram_alloc().  So, does anything in
>> > >the MX stuff use iram_alloc.c, or is it dead code left over from a
>> > >previous experiment?
>> >
>> > This function will be used for suspend code in the mx5x series. I just
>> > got done submitting a series of patches to Sascha for a simple suspend
>> > that does not need running code out of IRAM yet. The next set of suspend
>> > patches will be using these iram functions.
>>
>> Okay, so does iram_alloc() need to return a dma_addr_t or a phys_addr_t ?
>> Are you dealing with physical addresses for it or DMA addresses?
>
>And another question: why does iram_alloc() return a void __iomem * for
>the virtual address, and the physical address via a pointer argument.
>However, iram_free() take an unsigned long for the address.

Yes, should just be a void *iram_alloc().

>
>It seems rather inconsistent that the parameter for free is returned via
>a pointer argument.
>
>If I convert this to sram-pool, can we change this to:
>
>static inline void *iram_alloc(size_t size, phys_addr_t *phys_addr)
>{
>	return sram_pool_alloc(iram_pool, size, phys_addr);
>}
>
>static void iram_free(void *addr, size_t size)
>{
>	sram_pool_free(iram_pool, addr, size);
>}
>
>and:
>
>int __init iram_init(unsigned long base, unsigned long size)
>
>becomes:
>
>int __init iram_init(phys_addr_t base, size_t size)
>
>?


