From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 1/8] ARM: OMAP4: suspend: Program all domains to
 retention
Date: Wed, 16 May 2012 11:37:00 +0300
Message-ID: <1337157420.2149.331.camel@sokoban>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
 <1336989796-26594-2-git-send-email-t-kristo@ti.com> <87fwb1jk6p.fsf@ti.com>
Reply-To: t-kristo@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87fwb1jk6p.fsf@ti.com>
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
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2012-05-15 at 12:52 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > From: Rajendra Nayak <rnayak@ti.com>
> >
> > Remove the FIXME's in the suspend sequence since
> > we now intend to support system level RET support.
> 
> minor: this should probably go at the end of the series, after retention
> is supported.  Otherwise, ending up with only this patch applied
> (e.g. during a git bisect) will lead to a broken boot I suspect.

Ok, will move this to the end.

-Tero

> 
> Kevin
> 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-omap2/pm44xx.c |    6 ------
> >  1 files changed, 0 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> > index 8856253..31990d5 100644
> > --- a/arch/arm/mach-omap2/pm44xx.c
> > +++ b/arch/arm/mach-omap2/pm44xx.c
> > @@ -101,12 +101,6 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
> >  	if (!strncmp(pwrdm->name, "cpu", 3))
> >  		return 0;
> >  
> > -	/*
> > -	 * FIXME: Remove this check when core retention is supported
> > -	 * Only MPUSS power domain is added in the list.
> > -	 */
> > -	if (strcmp(pwrdm->name, "mpu_pwrdm"))
> > -		return 0;
> >  
> >  	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
> >  	if (!pwrst)
