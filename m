From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Sat, 11 Jan 2014 16:36:06 -0800
Message-ID: <20140112003605.GP31323@atomide.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <20140109222322.7168.74522@quantum>
 <20140110185305.GN31323@atomide.com>
 <52D114E5.7060503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54043 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750843AbaALAgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Jan 2014 19:36:12 -0500
Content-Disposition: inline
In-Reply-To: <52D114E5.7060503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [140111 01:56]:
> On 01/10/2014 08:53 PM, Tony Lindgren wrote:
> >* Mike Turquette <mturquette@linaro.org> [140109 14:25]:
> >>Quoting Tero Kristo (2014-01-09 06:00:11)
> >>>Hi,
> >>>
> >>>So, bad luck number release for this, as v12 wasn't sufficient still.
> >>>
> >>>Changes compared to previous version:
> >>>- Dropped any changes to generic clock drivers, as it seems impossible
> >>>   to agree anything in short term, this means the patch set shrank in
> >>>   size from 49 patches to 40 (first 9 patches were dropped).
> >>>- Copy pasted implementation for clk-divider and clk-mux from drivers/clk
> >>>   to drivers/clk/ti, and made the modifications needed to the TI version
> >>>   of the clock drivers only (based on discussions with Mike, this is fine)
> >>>- Changed name of clk_ll_ops to ti_clk_ll_ops so that this doesn't conflict
> >>>   with any generic implementation we might have at some point, migrating
> >>>   this to the generic version should be easy enough also.
> >>>- Fixed trace_clk_div_div_ck for omap4, this node was broken in previous
> >>>   versions and resulted into an orphan clock node
> >>>- Fixed compile problem for omap5 only build reported by Felipe
> >>>- Fixed a couple of sparse warnings
> >>>- changed the mach-omap2/clock.c to use readl_relaxed / writel_relaxed
> >>>   instead of __raw_readl / __raw_writel
> >>
> >>Hi Tero,
> >>
> >>This approach takes care of all of my concerns with this series. Thanks
> >>for your long suffering patience on it.
> >>
> >>It seems some build errors are cropping up, so once those are fixed then
> >>I'll be happy to merge clk-next-dt-clks-v13 into clk-next for 3.14.
> >
> >I'm fine with Mike merging these all via the clock tree assuming no more
> >pending comments. For the patches changed from the last time around,
> >please feel free to add:
> >
> >Acked-by: Tony Lindgren <tony@atomide.com>
> 
> How about the dts data patches? Should these also go via Mike's
> tree? Otherwise we will have boot failures until the dts patches are
> merged.

Yes I think that's the way to go, they mostly add new files so there
should not be major conflicts.

Regards,

Tony
