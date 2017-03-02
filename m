From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/15] clk: ti: cleanups / fixes for preparation of
 clkctrl clocks
Date: Thu, 2 Mar 2017 09:51:16 -0800
Message-ID: <20170302175116.GQ20572@atomide.com>
References: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@baylibre.com, linux-omap@vger.kernel.org, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170213 01:36]:
> Hi,
> 
> This series provides a number of cleanups and fixes for TI clock drivers.
> There patches are mostly independent of anything else, but are required
> for the upcoming clkctrl support also. Targeted for 4.12 merge window.
> 
> Main features provided by this series:
> - Dropped a few obsolete definitions
> - Cleanups for clock alias generation; after this most of the clock aliases
>   can be removed from the drivers/clk/ti/clk-xyz.c files. As a sample,
>   patch #08 is provided for cleaning up omap4 clock aliases, but this can
>   be done for all.
> - Convert mux/divider to use TI clock specific internal representation,
>   instead of re-using the generic clk_divider / clk_mux. This allows
>   better control over the contents of the struct and cleaning up the
>   register access code to be more readable.
> - Convert to use proper register definition instead of the overloaded
>   void *ptr which is dynamically cast into a bitmask (Patch #15.)
> 
> Some of the patches touch mach-omap2 code, so Ack from Tony is needed for
> patch #5, #6 and patch #15.

This series looks good to me, needs to be reposted after -rc1 is out
to apply though. Would be good to have this in Linux next early rather
than around -rc6 time. Please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
