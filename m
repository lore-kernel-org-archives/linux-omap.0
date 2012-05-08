From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 6/8] ARM: OMAP4: PM: support ret_logic/mem_off_counters
Date: Tue, 8 May 2012 11:03:24 +0300
Message-ID: <1336464204.2149.265.camel@sokoban>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
 <1334913591-26312-7-git-send-email-t-kristo@ti.com> <87pqafv810.fsf@ti.com>
Reply-To: t-kristo@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87pqafv810.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@gmail.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 2012-05-07 at 17:19 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > From: Axel Haslam <axelhaslam@gmail.com>
> >
> > On OMAP4, there is no support to read previous logic state
> > or previous memory state achieved when a power domain transitions
> > to RET. Instead there are module level context registers.
> >
> > In order to support the powerdomain level logic/mem_off_counters
> > on OMAP4, instead use the previous power state achieved (RET) and
> > the *programmed* logic/mem RET state to derive if a powerdomain lost
> > logic or did not.
> 
> OK, but this also changes the behavior for OMAP3 as well, right?  I
> don't see in the changelog how this affects OMAP3 and whether it is
> still expected to work on OMAP3.  When changing common code like this,
> the changelog should describe the impacts on to all affected SoCs.

Actually this doesn't change the behavior for OMAP3, as OMAP3 has
defined the ops for read_prev_logic_pwrst + read_prev_mem_pwrst. Looking
at the code more closely it might actually make more sense to implement
these for omap4 as well, instead of hacking this function. I'll check
this out and see if this can be done.

-Tero

> As suggested by Vaibhav Bedia, now might be the right time to add this
> function to the SoC specific function pointers (struct pwrdm_ops.)
> 
> Doing that, the existing function could be used for OMAP3 (and OMAP4 if
> the changelog describes that it can/should be used for both.)
> 
> Then, when AM33xx support is added, it will be obvious where they will
> need to plugin support for that SoC.
> 
> Kevin
> 
> > If the powerdomain is programmed to enter RET state and lose logic
> > in RET state, knowing that the powerdomain entered RET is good enough
> > to derive that the logic was lost as well, in such cases.
> >
> > Signed-off-by: Axel Haslam <axelhaslam@gmail.com>
> > [rnayak@ti.com: Updated changelog, updated patch to support mem counters]
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/powerdomain.c |   16 ++++++++++------
> >  1 files changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> > index 96ad3dbe..068f06b 100644
> > --- a/arch/arm/mach-omap2/powerdomain.c
> > +++ b/arch/arm/mach-omap2/powerdomain.c
> > @@ -124,18 +124,22 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
> >  static void _update_logic_membank_counters(struct powerdomain *pwrdm)
> >  {
> >  	int i;
> > -	u8 prev_logic_pwrst, prev_mem_pwrst;
> > +	int logic_pwrst, mem_pwrst;
> > +
> > +	logic_pwrst = pwrdm_read_prev_logic_pwrst(pwrdm);
> > +	if (logic_pwrst == -EINVAL)
> > +		logic_pwrst = pwrdm_read_logic_retst(pwrdm);
> >  
> > -	prev_logic_pwrst = pwrdm_read_prev_logic_pwrst(pwrdm);
> >  	if ((pwrdm->pwrsts_logic_ret == PWRSTS_OFF_RET) &&
> > -	    (prev_logic_pwrst == PWRDM_POWER_OFF))
> > +	    (logic_pwrst == PWRDM_POWER_OFF))
> >  		pwrdm->ret_logic_off_counter++;
> >  
> >  	for (i = 0; i < pwrdm->banks; i++) {
> > -		prev_mem_pwrst = pwrdm_read_prev_mem_pwrst(pwrdm, i);
> > -
> > +		mem_pwrst = pwrdm_read_prev_mem_pwrst(pwrdm, i);
> > +		if (mem_pwrst == -EINVAL)
> > +			mem_pwrst = pwrdm_read_mem_retst(pwrdm, i);
> >  		if ((pwrdm->pwrsts_mem_ret[i] == PWRSTS_OFF_RET) &&
> > -		    (prev_mem_pwrst == PWRDM_POWER_OFF))
> > +		    (mem_pwrst == PWRDM_POWER_OFF))
> >  			pwrdm->ret_mem_off_counter[i]++;
> >  	}
> >  }
