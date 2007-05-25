From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 11/18] omap2: convert clock.c to use new PRCM functions
	and symbolic constants
Date: Fri, 25 May 2007 11:59:14 +0300
Message-ID: <1180083554.3640.37.camel@Dogbert.NOE.nokia.com>
References: <20070525082322.168056647@pwsan.com>
	<20070525082502.202115234@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070525082502.202115234@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, 2007-05-25 at 02:23 -0600, ext Paul Walmsley wrote:
> 
>  	long long dpll_clk;
>  	int dpll_mult, dpll_div, amult;
> +	u32 dpll;
> +
> +	dpll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
> +	dpll_mult = dpll & OMAP24XX_DPLL_MULT_MASK;
> +	dpll_mult >>= OMAP24XX_DPLL_MULT_SHIFT;		/* 10 bits */
> +	dpll_div = dpll & OMAP24XX_DPLL_DIV_MASK;
> +	dpll_div >>= OMAP24XX_DPLL_DIV_SHIFT;		/* 4 bits */




Why not this?

#define OMAP24XX_DPLL_MULT_LEN	10

#define get_bitfield(value, name)\
((value) & name##_MASK) >> name##_SHIFT

-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
