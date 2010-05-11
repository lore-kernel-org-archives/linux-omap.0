From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv4 1/4] procfs: Introduce socinfo under /proc
Date: Tue, 11 May 2010 07:21:31 +0100
Message-ID: <20100511062131.GA24401@n2100.arm.linux.org.uk>
References: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com> <1273487857-32281-3-git-send-email-eduardo.valentin@nokia.com> <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com> <1273487857-32281-2-git-send-email-eduardo.valentin@nokia.com> <20100510111259.GA14680@linux-sh.org> <20100510123514.GA11804@besouro.research.nokia.com> <20100510123902.GA15293@linux-sh.org> <20100510125548.GB11804@besouro.research.nokia.com> <20100511031447.GB20453@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100511031447.GB20453@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Ambresh <a0393775@ti.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 11, 2010 at 12:14:47PM +0900, Paul Mundt wrote:
> On Mon, May 10, 2010 at 03:55:49PM +0300, Eduardo Valentin wrote:
> > On Mon, May 10, 2010 at 02:39:02PM +0200, ext Paul Mundt wrote:
> > > Note that in the cpuinfo case there is often special handling for the
> > > single (or boot CPU) case, such as printing out a descriptor for the
> > > machine type and so on. You might be better off just extending cpuinfo
> > > rather than introducing another /proc abstraction, presumably your
> > > socinfo string will be fixed regardless of whether it's SMP or not.
> > 
> > Yeah, I wouldn't expect it to change if it SMP or not. It should be fixed.
> > Previous version of this change was actually extending ARM cpuinfo. The previous
> > thread starts here:
> > http://marc.info/?l=linux-omap&m=127304890312365&w=2
> > 
> > But, the point of moving that to specific file was that soc info is not really cpu info.
> > 
> It's up to you of course, but adding an extra file because of SoC/CPU
> ambiguity seems pretty ugly. Almost all architectures already include
> machine type descriptors in their cpuinfo output (as ARM does also) and
> if you can justify that then certainly adding in some SoC-specific bits
> isn't exactly much of a stretch.
> 
> These days you should have a pretty strong justification for adding new
> procfs files, and this is certainly not one of them.

I disagree.
