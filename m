From: "Will Deacon" <will.deacon@arm.com>
Subject: RE: [PATCH 1/6] ARM: Add inline function smp_cpu() for early
	init	testing
Date: Fri, 3 Sep 2010 10:07:20 +0100
Message-ID: <47263.8991698206$1283504881@news.gmane.org>
References: <20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161846.GK11597@atomide.com>
	<20100902170830.GW26319@n2100.arm.linux.org.uk>
	<20100902174244.GU11597@atomide.com>
	<20100902192659.GW11597@atomide.com>
	<20100903000817.GG11597@atomide.com>
	<20100903022201.GI11597@atomide.com>
	<004601cb4b46$2bf3c120$83db4360$@deacon@arm.com>
	<20100903090241.GI26319@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100903090241.GI26319@n2100.arm.linux.org.uk>
Content-Language: en-gb
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Cc: 'Tony Lindgren' <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>
List-Id: linux-omap@vger.kernel.org

> On Fri, Sep 03, 2010 at 09:58:23AM +0100, Will Deacon wrote:
> > Your patches are turning up as attachments here, so I can't comment
> > inline. The only problem I can see is for SMP v6 platforms (ARM11MPCore)
> > where the MPIDR is actually the `CPU ID register' with bits 31:12 set to
> > zero, so we'll say it's a UP core.
> >
> > Since 11MPCore is the only ARM SMP v6 processor and you're checking
> > the implementor ID anyway, it might be easier to check for the 11MPCore
> > explicitly, ((read_cpuid_id() & 0xfff0) == 0xB020) rather than check for v6/v7.
> >
> > Or we could just ignore v6 for now.
> 
> We can't.  We need to get this correct so the head.S code can also get it
> right.

Damn. Then I guess we assume a core is UP unless it's an 11MPCore or a v7
with the relevant mpidr bits set. Actually, special casing the 11MPCore
means that we can use cpu_architecture() to check for v7 rather than masking
out fields from the cpuid ourselves.

Will
