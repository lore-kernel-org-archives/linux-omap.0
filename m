From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Fri, 1 Feb 2019 21:20:16 +0000
Message-ID: <20190201212016.xnvllntopo6pg53h@shell.armlinux.org.uk>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
 <20190201101919.GA26637@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190201101919.GA26637@fuggles.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Will,

On Fri, Feb 01, 2019 at 10:19:19AM +0000, Will Deacon wrote:
> Hi Russell,
> 
> On Fri, Jan 25, 2019 at 09:03:57PM +0000, Russell King wrote:
> > Executing loops such as:
> > 
> > 	while (1)
> > 		cpu_relax();
> > 
> > with interrupts disabled results in a livelock of the entire system,
> > as other CPUs are prevented making progress.  This is most noticable
> > as a failure of crashdump kexec, which stops just after issuing:
> > 
> > 	Loading crashdump kernel...
> > 
> > to the system console.  A workaround for this is to use 10 nops in
> > cpu_relax().
> > 
> > We also use wfe() in while (1) loops to avoid burning cycles in a
> > tight loop, giving the CPU a hint that we're not doing anything
> > useful.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> > It's been a while since this was posted, Will's suggestion was to use
> > 10 nops in cpu_relax() last time around.  I still prefer wfe() in
> > these infinite-not-doing-anything-ever loops.
> > 
> >  arch/arm/include/asm/barrier.h   | 2 ++
> >  arch/arm/include/asm/processor.h | 6 +++++-
> >  arch/arm/kernel/machine_kexec.c  | 5 ++++-
> >  arch/arm/kernel/smp.c            | 4 +++-
> >  arch/arm/mach-omap2/prm_common.c | 4 +++-
> >  5 files changed, 17 insertions(+), 4 deletions(-)
> 
> Thanks, this looks good to me and your explanation later in the thread makes
> a lot of sense:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Feel free to put some of the erratum writeup that I shared in the commit
> message, if you like.

I think it may make more sense to use my writeup as a basis for a
better commit log that explains why we're doing what we're doing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
