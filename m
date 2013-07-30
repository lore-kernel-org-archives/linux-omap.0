From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: v6: prevent gcc from reordering extended CP15 reads
 above is_smp() test
Date: Tue, 30 Jul 2013 10:58:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307301056220.8953@utopia.booyaka.com>
References: <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com> <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724142059.GJ11072@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com> <20130727122221.GB6618@mudshark.cambridge.arm.com> <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com> <alpine.DEB.2.02.1307282012280.23852@utopia.booyaka.com>
 <20130729100243.GC32383@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33942 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab3G3K6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 06:58:25 -0400
In-Reply-To: <20130729100243.GC32383@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Will

On Mon, 29 Jul 2013, Will Deacon wrote:

> I wouldn't worry about checking for CPU_V6. Besides, we probably need this
> to be re-evaluated across barrier() when we get CPU migration on a
> big-little platform anyway (we should probably also drop the
> __attribute_const__ for that).
> 
> So you can just replace the "cc" (now that Nico kindly explained why those
> aren't needed the other day) with "memory".
> 
> An alternative is to add barrier() between is_smp() and the read_cpuid_ext()
> in all callers, adding a fake read from the stack to the latter (like I did
> for the per-cpu accessor). However, this relies on fixing all callers for
> very little gain, so I don't think it's worth the hassle.
> 
> I can cook a patch if you're tied up with other things -- just let me know.

Makes sense to me.  Have respun the patch and will post it shortly.  
Thanks for the extra compiler research; it's been incorporated into the 
patch description and comments.


- Paul
