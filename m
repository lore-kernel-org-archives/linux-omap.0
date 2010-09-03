From: "Will Deacon" <will.deacon@arm.com>
Subject: RE: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init
	testing
Date: Fri, 3 Sep 2010 13:23:35 +0100
Message-ID: <36742.6778226674$1283516665@news.gmane.org>
References: <4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161846.GK11597@atomide.com>
	<20100902170830.GW26319@n2100.arm.linux.org.uk>
	<20100902174244.GU11597@atomide.com>
	<20100902192659.GW11597@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A8@dbde02.ent.ti.com>
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
To: "'Shilimkar, Santosh'" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>
List-Id: linux-omap@vger.kernel.org

Santosh,

> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index 8db3512..82bc488 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -39,4 +39,11 @@ static inline int cache_ops_need_broadcast(void)
>  #define UP(instr...)	_str(instr)
>  #endif
> 
> +static inline int smp_cpu(void)
> +{
> +        u32 mpidr;
> +        asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
> +        return (mpidr >> 31) ? !(mpidr >> 30) : 0;
> +}
> +
> Will this be called on UP machines ?? if yes, then mpidr register is not
> available on those

The multiprocessor affinity register (MPIDR) is defined as part of ARMv7.
ARM recommends that it returns 0 on UP systems. If bit 31 is set, then the
multiprocessing extensions are available.

The quirk (as discussed early) is that that 11MPCore has the CPUID register
at this location in the coprocessor space, with bit 31 set to 0. This means
that we have to check for it explicitly otherwise we will identify it as a
UP machine.

Will
