From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Thu, 7 Aug 2008 13:56:40 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
 <1218016428.25235.11.camel@pc1117.cambridge.arm.com>
 <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com>
 <20080807073035.GA10255@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47980 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbYHGS53 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 14:57:29 -0400
In-Reply-To: <20080807073035.GA10255@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>


> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Most of the weak memory attributes in newer ARMs are not exploited
> > today in tree.  I'll guess this was more a correctness and
> capability
> > judgment from Russell.
>
> Not entirely true.  We do as much as is safe to do - which is
> basically
> using 'device' mappings for devices and ioremap, and 'memory' mappings
> for the main memory, module and vmalloc mappings.

Is DEVICE really safe for things other than FIFOs with out the use of barriers?  Accesses are in order but they can be buffered.  The bus is free to post/buffer these writes as long as it preserves the order (and it does). I want to know the write happened before moving on in some code.  Yes some barrier can be added to the code to fix it but its not there in most drivers today.

I recall you gave an explanation on list a while back where MPCORE had to use DEVICE or it wouldn't work.  That restriction is not there for others.

We do in some drivers today get spurious interrupts when DEVICE is used but don't see them when using SO.

Originally the IC-Architect wanted two memory windows per device, one SO for register control and one DEVICE for FIFO access.  Given that we do DMA (which doesn't care about how ARM sees the world) on the performance hungry devices not doing this was ok.

> What we don't do is mark DMA memory ask being normal uncached memory,
> thereby allowing that to be reordered with device accesses - we make
> it strongly ordered.  The reason being that the kernel doesn't have
> barriers necessary to ensure that writes to DMA memory hit physical
> memory before the device access to enable DMA hits the DMA controller.

For an experiment a couple years back we did convert the dma alloc pool addresses as NC.  All worked -except- for OHCI-USB which started failing some tests.

Regards,
Richard W.

