From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Thu, 20 Sep 2012 12:04:39 +0100
Message-ID: <20120920110439.GB2117@linaro.org>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20120919134658.GA2111@linaro.org>
 <20120920102514.GD4588@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33545 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab2ITLEp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 07:04:45 -0400
Received: by eekc1 with SMTP id c1so857355eek.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 04:04:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120920102514.GD4588@e102568-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Thu, Sep 20, 2012 at 11:25:14AM +0100, Lorenzo Pieralisi wrote:
> On Wed, Sep 19, 2012 at 02:46:58PM +0100, Dave Martin wrote:
> > On Tue, Sep 18, 2012 at 05:35:33PM +0100, Lorenzo Pieralisi wrote:
> > > In processors like A15/A7 L2 cache is unified and integrated within the
> > > processor cache hierarchy, so that it is not considered an outer cache
> > > anymore. For processors like A15/A7 flush_cache_all() ends up cleaning
> > > all cache levels up to Level of Coherency (LoC) that includes
> > > the L2 unified cache.
> > > 
> > > When a single CPU is suspended (CPU idle) a complete L2 clean is not
> > > required, so generic cpu_suspend code must clean the data cache using the
> > > newly introduced cache LoUIS function.
> > 
> > For patches 3-5 in this series, we know that the assumption that
> > flushing LoUIS is sufficient for safely powering the CPU down is not
> > valid in the general case, though we've agreed it's a sensible
> > compromise for the CPU variants we know about today.
> 
> I agree, but we should also keep in mind that there are suspend and
> hotplug finishers where platform specific code can (and should sometimes)
> carry out the required operations, if flushing to LoUIS is not sufficient.
> 
> Patch 3-5 are there to avoid carrying out heavy cache operations that
> are not needed, not to define LoUIS as a sufficient cache level for
> powering down a CPU.
> 
> Your concern is shared, though.
> 
> > 
> > I think we do need to document this assumption, though.
> > 
> > At this point I don't mind whether it appears in code comments or in the
> > commit messages.
> 
> It is a fair point. I will improve comments in the code and commit logs
> for next version.

That should be fine.

Since the commit messages use quite precise terminology, I was worried
that they could be misinterpreted as stating the correct architectural
solution unless we point out that platform code maintainers still need
to pay attention to ensure that the correct levels are flushed for their
hardware.

Cheers
---Dave
