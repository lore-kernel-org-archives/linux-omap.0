From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Wed, 6 Aug 2008 07:28:48 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361F4E50C@dlee02.ent.ti.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
	 <20080805114920.GC27299@trinity.fluff.org>
	 <13B9B4C6EF24D648824FF11BE89671620361EE1A9C@dlee02.ent.ti.com>
 <1218018018.25235.23.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55980 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760701AbYHFM3c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 08:29:32 -0400
In-Reply-To: <1218018018.25235.23.camel@pc1117.cambridge.arm.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

> > The code need to execute in a non-cached region.
>
> I don't think there is any guarantee that dirty cache line won't be
> evicted to SDRAM even if your code uses uncached memory only. The CPU
> is
> allowed to do speculative reads from the normal cached memory and
> these
> reads may force a dirty cache line to be written back to memory. You
> may
> need to do at least a cache clean operation (invalidate not necessary).

I hope that is not necessary.

As I indicated the code in question is small assembly dealing with hardware registers for clock and power.

This code at one point did make sure use barriers at entry which hopefully stop the ARM from being smart.  Also things like speculative access at the AXI were turned off.

And perhaps you even make my point in 'The CPU is allowed to do speculative reads from normal-cached-memory'.
        !! I don't want some speculative branch prediction to fetch from who knows where when I've temporally shut off the memory controller !!

We spent too long fighting bugs around random crashes here already :) In future chips some of this is moving into hardware sequencers out of ARM control.

Regards,
Richard W.

