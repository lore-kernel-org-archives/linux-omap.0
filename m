From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: use correct timer function for AM43XX and
 TI81XX
Date: Thu, 19 Nov 2015 10:33:45 -0800
Message-ID: <20151119183345.GT2498@atomide.com>
References: <4016134.4bReocePei@wuerfel> <87egfplka4.fsf@saruman.tx.rr.com>
 <6973517.kQfhdpsmVt@wuerfel> <87io4yezi9.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87io4yezi9.fsf@saruman.tx.rr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [151119 08:16]:
> 
> Hi,
> 
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Monday 16 November 2015 15:13:55 Felipe Balbi wrote:
> >> Arnd Bergmann <arnd@arndb.de> writes:
> >> > AM43XX and TI81XX use omap3_gptimer_timer_init(), but that is only
> >> > built into the kernel for OMAP3 and AM33XX, otherwise we get:
> >> >
> >> > arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x124): undefined reference to `omap3_gptimer_timer_init'
> >> >
> >> > This changes the Kconfig logic for building the function to
> >> > match the callers. Consequently, we no longer need to build
> >> > the omap3_secure_sync32k_timer_init and omap4_local_timer_init
> >> > for the platforms that have been moved over to other functions.
> >> >
> >> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> no, AM43xx uses omap4_local_timer_init(), there's already a fix in
> >> Tony's tree IIRC.
> > ...
> >  
> >> care to provide a defconfig which would cause a build error ?
> >
> > My mistake, the code has changed several times and I adapted it to
> > the latest version each time, but the version I sent out is indeed
> > useless.
> >
> > The only hunk that still makes sense is
> >
> > diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> > index b18ebbefae09..b7ab09cc5ca2 100644
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -494,7 +494,7 @@ void __init omap_init_time(void)
> >  		clocksource_probe();
> >  }
> >  
> > -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
> > +#if defined(CONFIG_ARCH_OMAP3)
> >  void __init omap3_secure_sync32k_timer_init(void)
> >  {
> >  	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
> >
> >
> > but that is harmless as it does not cause a build error, just a few extra
> > bytes for an unused function in a AM43XX-only configuration.
> 
> I think that's still useful. Tony ?

Yeah makes sense to me. We already have omap4_sync32k_timer_init() when
am437x PM gets enabled.

Regards,

Tony
