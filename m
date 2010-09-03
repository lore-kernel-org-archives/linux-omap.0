From: "Will Deacon" <will.deacon@arm.com>
Subject: RE: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init
	testing
Date: Fri, 3 Sep 2010 09:58:23 +0100
Message-ID: <45369.049817282$1283504354@news.gmane.org>
References: <20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161846.GK11597@atomide.com>
	<20100902170830.GW26319@n2100.arm.linux.org.uk>
	<20100902174244.GU11597@atomide.com>
	<20100902192659.GW11597@atomide.com>
	<20100903000817.GG11597@atomide.com>
	<20100903022201.GI11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100903022201.GI11597@atomide.com>
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
To: 'Tony Lindgren' <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: 03 September 2010 03:22
> To: Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Bryan Wu; Will Deacon
> Subject: Re: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init testing
> 
> * Tony Lindgren <tony@atomide.com> [100902 17:00]:
> > * Tony Lindgren <tony@atomide.com> [100902 12:20]:
> >
> > Heh, turns out there's a bit of a bug in the code snippet above :) It should
> > be !((mpidr >> 30) & 1) instead, otherwise it always returns 0.

Gah! Well spotted! I think I was getting away with this because the platforms
I was using for testing didn't need tlb ops to be broadcast.

> This too can check for value of 2. Also we probably want to do the
> CPU type checks too. Updated patch below.

Your patches are turning up as attachments here, so I can't comment
inline. The only problem I can see is for SMP v6 platforms (ARM11MPCore)
where the MPIDR is actually the `CPU ID register' with bits 31:12 set to
zero, so we'll say it's a UP core.

Since 11MPCore is the only ARM SMP v6 processor and you're checking
the implementor ID anyway, it might be easier to check for the 11MPCore
explicitly, ((read_cpuid_id() & 0xfff0) == 0xB020) rather than check for v6/v7.

Or we could just ignore v6 for now.

Will
