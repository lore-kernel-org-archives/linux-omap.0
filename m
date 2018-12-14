From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 9/9] ARM: smp: remove arch-provided "pen_release"
Date: Fri, 14 Dec 2018 13:12:00 +0000
Message-ID: <20181214131200.GL9507@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVIY-0008DI-MU@rmk-PC.armlinux.org.uk>
 <20181214043923.2gusomvei424vw7m@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181214043923.2gusomvei424vw7m@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Barry Song <baohua@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-oxnas@groups.io, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <vireshk@kernel.org>, linux-omap@vger.kernel.org, linux-soc@vger.kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 14, 2018 at 10:09:23AM +0530, Viresh Kumar wrote:
> On 13-12-18, 18:01, Russell King wrote:
> > diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
> > index 909b97c0b237..815333fc320c 100644
> > --- a/arch/arm/mach-spear/generic.h
> > +++ b/arch/arm/mach-spear/generic.h
> > @@ -20,6 +20,8 @@
> >  
> >  #include <asm/mach/time.h>
> >  
> > +extern volatile int prima2_pen_release;
> 
>                        prima2 ?
> 
> I haven't tried but this may cause build regressions as well, I am
> surprised on how this passed for you.

Thanks.

These patches aren't all build tested - I don't see the point of wasting
hours build testing when these platforms /really/ need something better.

This is not supposed to be a finished patch, but a patch to get folk
to do something about this issue.

Please fix this issue properly.  I can't give you a patch to do that,
you need to sort it yourself, but failure to do anything _will_ result
in an updated version of this patch being merged.

> >  extern void spear13xx_timer_init(void);
> >  extern void spear3xx_timer_init(void);
> >  extern struct pl022_ssp_controller pl022_plat_data;
> > diff --git a/arch/arm/mach-spear/headsmp.S b/arch/arm/mach-spear/headsmp.S
> > index c52192dc3d9f..6e250b6c0aa2 100644
> > --- a/arch/arm/mach-spear/headsmp.S
> > +++ b/arch/arm/mach-spear/headsmp.S
> > @@ -43,5 +43,5 @@ pen:	ldr	r7, [r6]
> >  
> >  	.align
> >  1:	.long	.
> > -	.long	pen_release
> > +	.long	spear_pen_release
> >  ENDPROC(spear13xx_secondary_startup)
> > diff --git a/arch/arm/mach-spear/hotplug.c b/arch/arm/mach-spear/hotplug.c
> > index 12edd1cf8a12..0dd84f609627 100644
> > --- a/arch/arm/mach-spear/hotplug.c
> > +++ b/arch/arm/mach-spear/hotplug.c
> > @@ -16,6 +16,8 @@
> >  #include <asm/cp15.h>
> >  #include <asm/smp_plat.h>
> >  
> > +#include "generic.h"
> > +
> >  static inline void cpu_enter_lowpower(void)
> >  {
> >  	unsigned int v;
> > @@ -57,7 +59,7 @@ static inline void spear13xx_do_lowpower(unsigned int cpu, int *spurious)
> >  	for (;;) {
> >  		wfi();
> >  
> > -		if (pen_release == cpu) {
> > +		if (spear_pen_release == cpu) {
> >  			/*
> >  			 * OK, proper wakeup, we're done
> >  			 */
> > diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
> > index 39038a03836a..b1ff4bb86f6d 100644
> > --- a/arch/arm/mach-spear/platsmp.c
> > +++ b/arch/arm/mach-spear/platsmp.c
> > @@ -20,16 +20,21 @@
> >  #include <mach/spear.h>
> >  #include "generic.h"
> >  
> > +/* XXX spear_pen_release is cargo culted code - DO NOT COPY XXX */
> > +volatile int spear_pen_release = -1;
> > +
> >  /*
> > - * Write pen_release in a way that is guaranteed to be visible to all
> > - * observers, irrespective of whether they're taking part in coherency
> > + * XXX CARGO CULTED CODE - DO NOT COPY XXX
> > + *
> > + * Write spear_pen_release in a way that is guaranteed to be visible to
> > + * all observers, irrespective of whether they're taking part in coherency
> >   * or not.  This is necessary for the hotplug code to work reliably.
> >   */
> > -static void write_pen_release(int val)
> > +static void spear_write_pen_release(int val)
> >  {
> > -	pen_release = val;
> > +	spear_pen_release = val;
> >  	smp_wmb();
> > -	sync_cache_w(&pen_release);
> > +	sync_cache_w(&spear_pen_release);
> >  }
> >  
> >  static DEFINE_SPINLOCK(boot_lock);
> > @@ -42,7 +47,7 @@ static void spear13xx_secondary_init(unsigned int cpu)
> >  	 * let the primary processor know we're out of the
> >  	 * pen, then head off into the C entry point
> >  	 */
> > -	write_pen_release(-1);
> > +	spear_write_pen_release(-1);
> >  
> >  	/*
> >  	 * Synchronise with the boot thread.
> > @@ -64,17 +69,17 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
> >  	/*
> >  	 * The secondary processor is waiting to be released from
> >  	 * the holding pen - release it, then wait for it to flag
> > -	 * that it has been released by resetting pen_release.
> > +	 * that it has been released by resetting spear_pen_release.
> >  	 *
> > -	 * Note that "pen_release" is the hardware CPU ID, whereas
> > +	 * Note that "spear_pen_release" is the hardware CPU ID, whereas
> >  	 * "cpu" is Linux's internal ID.
> >  	 */
> > -	write_pen_release(cpu);
> > +	spear_write_pen_release(cpu);
> >  
> >  	timeout = jiffies + (1 * HZ);
> >  	while (time_before(jiffies, timeout)) {
> >  		smp_rmb();
> > -		if (pen_release == -1)
> > +		if (spear_pen_release == -1)
> >  			break;
> >  
> >  		udelay(10);
> > @@ -86,7 +91,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
> >  	 */
> >  	spin_unlock(&boot_lock);
> >  
> > -	return pen_release != -1 ? -ENOSYS : 0;
> > +	return spear_pen_release != -1 ? -ENOSYS : 0;
> >  }
> >  
> >  /*
> > -- 
> > 2.7.4
> 
> -- 
> viresh
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
