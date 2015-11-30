From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] ARM: OMAP4: execute initcall to reserve SRAM for I688
 only on OMAP4
Date: Mon, 30 Nov 2015 18:27:11 +0100
Message-ID: <1448904431.8275.36.camel@pengutronix.de>
References: <1447673117-32719-1-git-send-email-l.stach@pengutronix.de>
 <5649CB16.2030706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5649CB16.2030706@ti.com>
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
Cc: "Menon, Nishanth" <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, patchwork-lst@pengutronix.de, kernel@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Am Montag, den 16.11.2015, 14:24 +0200 schrieb Grygorii Strashko:
> On 11/16/2015 01:25 PM, Lucas Stach wrote:
> > omap_interconnect_sync() is the only user of the SRAM scratch area
> > allocated in the omap4_sram_init initcall. The interconnect sync is
> > used exclusively in the OMAP4 specific WFI implementation, so there
> > is no point in allocating the SRAM scratch on other SoC types.
> > 
> > Bail out of the initcall if the kernel is not running on OMAP4 to
> > avoid a confusing warning about being unable to allocate the SRAM
> > needed for I688 handling.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Tested-by: Bastian Stender <bst@pengutronix.de>
> > ---
> >   arch/arm/mach-omap2/omap4-common.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> > index 949696b6f17b..6db393a30a28 100644
> > --- a/arch/arm/mach-omap2/omap4-common.c
> > +++ b/arch/arm/mach-omap2/omap4-common.c
> > @@ -131,6 +131,9 @@ static int __init omap4_sram_init(void)
> >   	struct device_node *np;
> >   	struct gen_pool *sram_pool;
> >   
> > +	if (!cpu_is_omap44xx())
> > +		return 0;
> 
> This one affects on am43xx also
> 
So you are saying this erratum is also present on AM43xx? I wasn't able
to deduce this from the information provided by Richard Woodruff.

> 
> > +
> >   	np = of_find_compatible_node(NULL, NULL, "ti,omap4-mpu");
> >   	if (!np)
> >   		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
> 
> Since all OMAP4+ platforms are now DT based why can't we just return from here silently?
> 
If we are unable to allocate the SRAM needed to work around I688 this is
a real error on platforms that expose this erratum, so silently bailing
out at this point may obscure a real issue.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
