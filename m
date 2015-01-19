From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: l2c: OMAP4/AM437x: Additional register
 programming support.
Date: Mon, 19 Jan 2015 13:32:54 -0800
Message-ID: <20150119213252.GJ18552@atomide.com>
References: <1420219072-6521-1-git-send-email-nm@ti.com>
 <20150102173859.GE3298@atomide.com>
 <54A6DAE8.90609@ti.com>
 <20150119212808.GI18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150119212808.GI18552@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Santosh <ssantosh@kernel.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150119 13:35]:
> * Nishanth Menon <nm@ti.com> [150102 09:55]:
> > On 01/02/2015 11:38 AM, Tony Lindgren wrote:
> > > * Nishanth Menon <nm@ti.com> [150102 09:20]:
> > >> Hi,
> > >>
> > >> OMAP4 and AM437x ROM code provides services to program PL310's latency
> > >> registers and AM437x provides service for programming Address filter
> > >> registers.
> > >>
> > >> Provide support in the kernel for the same.
> > >>
> > >> This provides some support to the series: http://marc.info/?l=linux-arm-kernel&m=141933190912495&w=2
> > > 
> > > Are these to be applied before Thomasz's series as fixes? If we
> > > don't need these as fixes for the -rc, then probably makes sense
> > > for RMK to merge them all together for v3.20.
> > > 
> > These dont need to go in fixes. Can easily wait till 3.20. Thomaz
> > series wont exercise these path by default until someone modifies the
> > DT properties. Yes, will be nice to have them along with other changes
> > in v3.20. just for the record, i made a couple of typos in v1 of this
> > series and have updated a retested v2 of the series.
> 
> Applying both int omap-for-v3.20/fixes thanks.

Oops actually not applying based on reading the comments in v2
of this series. Please repost if you still want to patch something.

Regards,

Tony
