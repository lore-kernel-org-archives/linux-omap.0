From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Thu, 07 Aug 2008 17:01:29 +0100
Message-ID: <1218124889.7718.22.camel@pc1117.cambridge.arm.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
	 <1218016428.25235.11.camel@pc1117.cambridge.arm.com>
	 <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com>
	 <20080807073035.GA10255@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:54870 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752489AbYHGQCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 12:02:36 -0400
In-Reply-To: <20080807073035.GA10255@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Thu, 2008-08-07 at 08:30 +0100, Russell King - ARM Linux wrote:
> What we don't do is mark DMA memory ask being normal uncached memory,
> thereby allowing that to be reordered with device accesses - we make
> it strongly ordered.  The reason being that the kernel doesn't have
> barriers necessary to ensure that writes to DMA memory hit physical
> memory before the device access to enable DMA hits the DMA controller.

We have mb() and related which provides the ordering (there is also
mmiowb() but my understanding is that we don't need this on ARM).

http://lwn.net/Articles/283776/

> Those kinds of bugs can be absolute hell to track down - think about
> a DMA controller accessing an uninitialised DMA descriptor, resulting
> in it scribbing over random bits of memory.

Yes, indeed, but ARM is not the only architecture with a weak memory
ordering model so drivers should be fixed, in theory.

> Linux presently - and quite rightly - assumes that accesses to DMA
> coherent memory _are_ coherent with DMA.  If not, the API would be
> a joke.

As I understand it, the DMA mapping doesn't guarantee any ordering,
drivers must use barriers. According to Documentation/DMA-mapping.txt:

- Consistent DMA mappings which are usually mapped at driver
  initialization, unmapped at the end and for which the hardware should
  guarantee that the device and the CPU can access the data
  in parallel and will see updates made by each other without any
  explicit software flushing.

[...]

  IMPORTANT: Consistent DMA memory does not preclude the usage of
             proper memory barriers.  The CPU may reorder stores to
	     consistent memory just as it may normal memory.

-- 
Catalin

