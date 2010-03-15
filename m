From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/6 Revised] SPI omap2_mcspi: Add
 max_clk_div field to mcspi platform config
Date: Mon, 15 Mar 2010 14:02:36 -0700
Message-ID: <20100315210236.GE2900@atomide.com>
References: <1268407307.14445.51.camel@quad>
	<20100312172148.GG2900@atomide.com>
	<1268587548.30878.11.camel@quad>
	<20100315163246.GT2900@atomide.com>
	<1268685022.8594.130.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1268685022.8594.130.camel@quad>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Scott Ellis <scott-oZqG5KApg2M/jFmSBShxMA@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Aaro Koskinen <Aaro.Koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Scott Ellis <scott-oZqG5KApg2M/jFmSBShxMA@public.gmane.org> [100315 13:27]:
> > Hmm now it looks like you're missing 3630 handling?
> > 
> > If the max_clk_div is 0x0f for 2420 and 2430, then you
> > can just check for cpu_is_omap24xx(). If it's only
> > different for 2420, then you can check for cpu_is_omap2420().
> > 
> > That way it should be more future proof, and you don't
> > need to change it for new processors.
> > 
> Anand Gadiyar <gadiyar <at> ti.com> verified 0x0f for the 2430.
> 
> I think SWPU177D is the correct TRM for the omap3630 and if so then 0x0c
> is the correct value.
> 
> I did not verify the omap44xx value and just assumed similar to the
> omap3's. My bad.
> 
> Can you or someone point me to links for the omap2420 and the omap44xx
> TRMs? I'm not having any luck finding them.

I don't think those are publicly available yet for 4430 and still for
2420..

But looks like 2420, 2430 and 4430 TRMs says that 0xf = 32768
max divider for CLKD.

Only 3430 and 3630 TRMs says 0xd, 0xe, 0xf = Division not supported.

But then again, the TRMs can have errors.

> Then it can be verified whether a cpu_is_omap24xx() check is sufficient.
> It probably is.

Then the 4430 TRM must have an error.. Can somebody from TI
confirm the CLKD max value for 4430 please?
 
> Or if someone with access to those manuals could do a quick check...
> 
> It's the max value of the MCSPI_CHxCONF.CLKD register field.

Regards,

Tony

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
