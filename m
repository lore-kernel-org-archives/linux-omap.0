From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] 24xx clock fixes: DSP, 54MHz APLL
Date: Wed, 5 Dec 2007 14:39:56 -0800
Message-ID: <20071205223956.GY4105@atomide.com>
References: <20071203232426.775904267@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071203232426.775904267@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [071203 15:30]:
> Hello,
> 
> these patches clean up the structure of the DSP clocks on the OMAP24xx
> platforms.  They remove redundant clocks and rate structures, and fix
> the DSP driver code to use the correct clock name on 2430.  DSP
> i-clock source selection is moved into a separate clock,
> dsp_irate_ick, to facilitate some of this consolidation.  
> 
> Also, in omap2_clk_fixed_enable(), it turns out that we were looking for
> the wrong IDLEST bit to test if the 54MHz APLL was locked - fix this.
> 
> This series resolves the boot-time clock warnings that appear on
> 2430SDP:
> 
>     clock: Could not find parent clock iva2_1_fck in clksel array of
>     clock iva2_1_ick
> 
>     omapdsp: could not acquire dsp_ick handle
> 
>     Clock apll54_ck didn't enable in 100000 tries
> 
> 
> Boot-tested on N800 and 2430SDP.  Comments welcome.

Pushing today.

Tony
