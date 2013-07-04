From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: initialize before using oh_name
Date: Thu, 4 Jul 2013 04:47:37 -0700
Message-ID: <20130704114736.GC5523@atomide.com>
References: <1369722288-15592-1-git-send-email-afzal@ti.com>
 <51A51FAC.5090606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51A51FAC.5090606@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jgchunter@gmail.com>
Cc: Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Jon Hunter <jgchunter@gmail.com> [130528 14:26]:
> 
> On 28/05/13 07:24, Afzal Mohammed wrote:
> > of_property_read_string_index(...,&oh_name) in omap_dm_timer_init_one
> > does not alter the value of 'oh_name' even if the relevant function
> > fails and as 'oh_name' in stack may have a non-zero value, it would
> > be misunderstood by timer code that DT has specified "ti,hwmod"
> > property for timer. 'oh_name' in this scenario would be a junk value,
> > this would result in module not being enabled by hwmod API's for
> > timer, and in turn crash.
> > 
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > ---
> >  arch/arm/mach-omap2/timer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> > index f8b23b8..8e0c390 100644
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -220,7 +220,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
> >  					 int posted)
> >  {
> >  	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
> > -	const char *oh_name;
> > +	const char *oh_name = NULL;
> >  	struct device_node *np;
> >  	struct omap_hwmod *oh;
> >  	struct resource irq, mem;
> 
> Thanks!
> 
> Acked-by: Jon Hunter <jgchunter@gmail.com>

Thanks, applying into omap-for-v3.11/fixes.

Tony 
