From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2 3/5] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Thu, 13 Dec 2012 10:51:09 +0000
Message-ID: <20121213105109.GB26540@mudshark.cambridge.arm.com>
References: <20120919134658.GA2111@linaro.org>
 <20120920102514.GD4588@e102568-lin.cambridge.arm.com>
 <20120920110439.GB2117@linaro.org>
 <Pine.LNX.4.64.1212111655050.29758@axis700.grange>
 <20121211163313.GG16759@mudshark.cambridge.arm.com>
 <20121211163843.GH16759@mudshark.cambridge.arm.com>
 <50C7C16B.7050106@codeaurora.org>
 <20121212103338.GB23022@e102568-lin.cambridge.arm.com>
 <20121212133650.GJ6195@mudshark.cambridge.arm.com>
 <Pine.LNX.4.64.1212130909190.18586@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1212130909190.18586@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Dave Martin <dave.martin@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Simon Horman <horms@verge.net.au>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Colin Cross <ccross@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Wenzeng Chen <wzch@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 13, 2012 at 08:09:33AM +0000, Guennadi Liakhovetski wrote:
> On Wed, 12 Dec 2012, Will Deacon wrote:
> > Back to the case in hand.... Lorenzo just pointed out to me that the
> > finished in question (sh7372_do_idle_sysc) calls v7_flush_dcache_all, so
> > the louis stuff should be irrelevant. The problem may actually be that the
> > finisher disables the L2 cache prior to cleaning/invalidating it, which is
> > the opposite order to that described by the A8 TRM.
> > 
> > Guennadi -- can you try moving the kernel_flush call before the L2 disable
> > in sh7372_do_idle_sysc please?
> 
> Yes, this works too.

That's good to know. Please can you send a patch for that? The sequence
currently being used by the finisher *is* buggy, and should be fixed
independently of the louis stuff.

Cheers,

Will
