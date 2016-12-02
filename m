From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: omap: timers: reduce rating of gp_timer
 clocksource
Date: Fri, 2 Dec 2016 08:47:14 -0800
Message-ID: <20161202164714.GB4705@atomide.com>
References: <1479968355-18860-1-git-send-email-j-keerthy@ti.com>
 <1479968355-18860-2-git-send-email-j-keerthy@ti.com>
 <d3a71d3d-3015-bb1f-80a4-4bb9adecaa4c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <d3a71d3d-3015-bb1f-80a4-4bb9adecaa4c@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [161129 08:43]:
> 
> 
> On 11/24/2016 12:19 AM, Keerthy wrote:
> > From: Grygorii Strashko <grygorii.strashko@ti.com>
> > 
> > Now ARM Global timer (rating 300) will not be selected as clocksource,
> > because it's initialized after OMAP GP Timer (rating 300) and
> > Timekeeping core will not allow to replace clocksource with new one if
> > both of them have the same rating.
> > 
> > Reduce rating of OMAP GP Timer (300->290) when it's used as
> > clocksource device - this will allow to select ARM Global timer (300)
> > as clocksource when enabled.
> > 
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> 
> Unfortunately, this patch has dependency [1] and can't be used alone as
> it will cause ARM Global timer to be selected as clocksource
> always on am437x and this will kill cpuidle, because ARM Global timer
> is not in always_on domain.
> 
> The intention of enabling ARM Global timer is only for non-pm aware use
> cases for RT-kernel latency improvement - where deep cpuidle states are not
> enabled.

Yeah we need to fix up things to be able to change the clocksource
in addition to clockevent. However, currently only cpuidle_coupled
knows when the whole system is idle, so quite a bit of work is
needed to do that in a sane way.

What about the first patch in this series?

Regards,

Tony


> [1] https://patchwork.kernel.org/patch/8940051/
> 
> > ---
> >  arch/arm/mach-omap2/timer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> > index b2f2448..a0dbb0b 100644
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -376,7 +376,7 @@ static cycle_t clocksource_read_cycles(struct clocksource *cs)
> >  }
> > 
> >  static struct clocksource clocksource_gpt = {
> > -	.rating		= 300,
> > +	.rating		= 290,
> >  	.read		= clocksource_read_cycles,
> >  	.mask		= CLOCKSOURCE_MASK(32),
> >  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> > 
> 
> -- 
> regards,
> -grygorii
