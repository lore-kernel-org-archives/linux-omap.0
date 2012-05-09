From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM
	address space.
Date: Wed, 9 May 2012 13:23:48 +0100
Message-ID: <20120509122348.GA30632@n2100.arm.linux.org.uk>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com> <20120508124116.GE17798@arm.com> <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com> <20120508215554.GA18980@n2100.arm.linux.org.uk> <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43082 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757958Ab2EIMYM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 08:24:12 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>

On Wed, May 09, 2012 at 02:20:28PM +0530, Shilimkar, Santosh wrote:
> The only change done common code is  clearing 'XN' bit for DRAM
> region in page table entries. The other change of setting the DACR
> register is done in ARMv7 specific code.

Yes, XN is an ARMv6+ thing.  Before ARMv5, it was implementation defined.

Some implementations used the bit to mean "allow writes to update the
cache".  Other implementations labelled this bit as "should be zero"
while others labelled it as "should be one".

The upshot of this is, we know that having this bit as '1' means that
all the CPUs we support today work.  I would be _very_ concerned to
change this bit to zero as we _really_ don't know how the pre-ARMv6
CPUs would react.

The solution to this is pretty simple - if ARMv6+ needs a different
base section mapping value, then we need to extract that from the code
and pass in the base section mapping value.

I'll sort out a patch later today for this.
