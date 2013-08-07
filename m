From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: fix wrong address when loading
 PRM_FRAC_INCREMENTOR_DENUMERATOR_RELOAD
Date: Wed, 7 Aug 2013 04:09:45 -0700
Message-ID: <20130807110945.GL7656@atomide.com>
References: <1375356474-24203-1-git-send-email-baozich@gmail.com>
 <C635EF21-CD18-4633-AA39-16209F8EE231@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C635EF21-CD18-4633-AA39-16209F8EE231@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Baozi <baozich@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Chen Baozi <baozich@gmail.com> [130805 08:33]:
> ping?
> 
> On Aug 1, 2013, at 7:27 PM, Chen Baozi <baozich@gmail.com> wrote:
> 
> > The denominator should be load from INCREMENTOR_DENUMERATOR_RELOAD_OFFSET
> > rather than INCREMENTER_NUMERATOR_OFFSET.

Maybe describe what exactly happens without this fix?

Also we should get few acks for this for the -rc series.

Regards,

Tony

> > Signed-off-by: Chen Baozi <baozich@gmail.com>
> > ---
> > arch/arm/mach-omap2/timer.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> > index b37e1fc..9265e03 100644
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -537,7 +537,7 @@ static void __init realtime_counter_init(void)
> > 	reg |= num;
> > 	__raw_writel(reg, base + INCREMENTER_NUMERATOR_OFFSET);
> > 
> > -	reg = __raw_readl(base + INCREMENTER_NUMERATOR_OFFSET) &
> > +	reg = __raw_readl(base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET) &
> > 			NUMERATOR_DENUMERATOR_MASK;
> > 	reg |= den;
> > 	__raw_writel(reg, base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET);
> > -- 
> > 1.8.1.4
> > 
> 
