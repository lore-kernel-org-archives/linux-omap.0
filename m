From: Matthew Percival <matthew@capgo.com>
Subject: Re: [PATCH] dmtimer.c omap1 register fix...
Date: Fri, 22 Dec 2006 10:13:26 +1100
Message-ID: <1166742806.8156.1.camel@localhost.localdomain>
References: <1165539159.5155.2.camel@localhost.localdomain>
	<20061221225219.GF10399@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20061221225219.GF10399@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2006-12-21 at 14:52 -0800, Tony Lindgren wrote:
> * Matthew Percival <matthew@capgo.com> [061207 16:54]:
> > G'Day,
> > 
> > 	When I went to use dmtimer7 it did not seem to work.  I noticed that
> > the base addresses for dmtimers 7 and 8 were set wrong.  A simple patch
> > to correct a small error.  Confirmed to fix the problem on an OSK.
> > 
> > 	-- Matthew
> 
> > --- a/arch/arm/plat-omap/dmtimer.c	2006-12-06 11:40:06.000000000 +1100
> > +++ b/arch/arm/plat-omap/dmtimer.c	2006-12-08 11:47:33.000000000 +1100
> > @@ -90,8 +90,8 @@
> >  	{ .phys_base = 0xfffb2c00, .irq = INT_1610_GPTIMER4 },
> >  	{ .phys_base = 0xfffb3400, .irq = INT_1610_GPTIMER5 },
> >  	{ .phys_base = 0xfffb3c00, .irq = INT_1610_GPTIMER6 },
> > -	{ .phys_base = 0xfffb4400, .irq = INT_1610_GPTIMER7 },
> > -	{ .phys_base = 0xfffb4c00, .irq = INT_1610_GPTIMER8 },
> > +	{ .phys_base = 0xfffb7400, .irq = INT_1610_GPTIMER7 },
> > +	{ .phys_base = 0xfffbd400, .irq = INT_1610_GPTIMER8 },
> >  };
> >  
> >  #elif defined(CONFIG_ARCH_OMAP2)
> 
> Good catch, can you please reply to this thread with your Signed-off-by?
> 
> Tony

Signed-off-by: Matthew Percival <matthew at capgo.com>
