From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf not capturing stack traces
Date: Sat, 24 Jan 2015 12:12:04 -0300
Message-ID: <20150124151204.GF3073@kernel.org>
References: <20150123195128.GE26557@saruman.tx.rr.com>
 <20150123205959.GD3073@kernel.org>
 <20150123223745.GJ26557@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150123223745.GJ26557@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Em Fri, Jan 23, 2015 at 04:37:45PM -0600, Felipe Balbi escreveu:
> On Fri, Jan 23, 2015 at 05:59:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jan 23, 2015 at 01:51:28PM -0600, Felipe Balbi escreveu:
> > > I'm using v3.19-rc5 on an ARM Cortex A9 board. Unfortunately, perf is
> > > not able to capture any stack traces even though I CONFIG_STACKTRACE,
> > > CONFIG_FRAME_POINTER and CONFIG_ARM_UNWIND all enabled.
> > > 
> > > I wonder if anybody else is facing similar issues.
> > 
> > Did it work with a previous kernel?
> 
> haven't checked with this board. First time I tried to use perf for
> anything.

And it is the first time I've heard about such a problem, not dealing
with ARM myself, so I guess this is a case for looking if there was some
previous kernel where this worked, then trying to bisect where the
problem was introduced :-\

- Arnaldo
