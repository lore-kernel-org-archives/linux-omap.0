From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Sun, 28 Jul 2013 05:38:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307280527430.8385@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724142059.GJ11072@mudshark.cambridge.arm.com> <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com>
 <20130727122221.GB6618@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39702 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab3G1FiI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 01:38:08 -0400
In-Reply-To: <20130727122221.GB6618@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Will,

On Sat, 27 Jul 2013, Will Deacon wrote:

> That's very odd -- I *suspect* your bootloader is up to no good (iirc, we've
> had issues with the bootloader on this machine in the past, since it enters
> the kernel in ABT mode or something).

Maybe you're thinking of the (2420-based) Nokia N800?  The 2430SDP here 
uses u-boot:

http://www.pwsan.com/omap/testlogs/test_v3.10-rc7/20130630191558/boot/2430sdp/

> Can you try this quick hack please? It clobbers the I-cache as soon as we
> enter the kernel, so it should tell us whether my theory is correct.

Tried it and still hangs.  Spent some time debugging - turns out it's due 
to the extended CP15 register read in cache_ops_need_broadcast().. the 
extended regs aren't present on ARM1136 r0* and trigger an undefined 
instruction abort :-(  Sorry about that, should have taken the time to 
send along an earlyprintk trace.  Patches in a few moments -


- Paul
