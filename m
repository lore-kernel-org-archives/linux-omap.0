From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/18] omap2: convert clock.c to use new PRCM functions
	and symbolic constants
Date: Fri, 25 May 2007 11:53:39 -0700
Message-ID: <20070525185339.GL19506@atomide.com>
References: <20070525082322.168056647@pwsan.com>
	<20070525082502.202115234@pwsan.com>
	<1180083554.3640.37.camel@Dogbert.NOE.nokia.com>
	<1180083839.3640.43.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1180083839.3640.43.camel@Dogbert.NOE.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: ext Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Igor Stoppa <igor.stoppa@nokia.com> [070525 02:04]:
> Sorry, I accidentally pressed send before completing 
> 
> 
> On Fri, 2007-05-25 at 11:59 +0300, Igor Stoppa wrote:
> > Hi,
> > 
> > On Fri, 2007-05-25 at 02:23 -0600, ext Paul Walmsley wrote:
> > > 
> > >  	long long dpll_clk;
> > >  	int dpll_mult, dpll_div, amult;
> > > +	u32 dpll;
> > > +
> > > +	dpll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
> > > +	dpll_mult = dpll & OMAP24XX_DPLL_MULT_MASK;
> > > +	dpll_mult >>= OMAP24XX_DPLL_MULT_SHIFT;		/* 10 bits */
> > > +	dpll_div = dpll & OMAP24XX_DPLL_DIV_MASK;
> > > +	dpll_div >>= OMAP24XX_DPLL_DIV_SHIFT;		/* 4 bits */
> > 
> > 
> > 
> 
> Why not this?
> 
> #define OMAP24XX_DPLL_MULT_LEN	10
> #define OMAP24XX_DPLL_MULT_OFFS	12
> 
> #define get_bitfield(value, name)\
> (((value) >> name##_OFFS) & ((1 << name##_LEN) - 1))
> 
> dpll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
> dpll_mult = get_bitfield(dpll, OMAP24XX_DPLL_MULT);
> dpll_div = get_bitfield(dpll, OMAP24XX_DPLL_DIV);

That could be cleaned up further, but I'll push Paul's patches
today. We can always do additional clean-up, but let's first
wait and make sure things still work for all omap2 boards.

Regards,

Tony
