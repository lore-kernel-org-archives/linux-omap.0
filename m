From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Thu, 09 Jan 2014 14:23:22 -0800
Message-ID: <20140109222322.7168.74522@quantum>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2014-01-09 06:00:11)
> Hi,
> 
> So, bad luck number release for this, as v12 wasn't sufficient still.
> 
> Changes compared to previous version:
> - Dropped any changes to generic clock drivers, as it seems impossible
>   to agree anything in short term, this means the patch set shrank in
>   size from 49 patches to 40 (first 9 patches were dropped).
> - Copy pasted implementation for clk-divider and clk-mux from drivers/clk
>   to drivers/clk/ti, and made the modifications needed to the TI version
>   of the clock drivers only (based on discussions with Mike, this is fine)
> - Changed name of clk_ll_ops to ti_clk_ll_ops so that this doesn't conflict
>   with any generic implementation we might have at some point, migrating
>   this to the generic version should be easy enough also.
> - Fixed trace_clk_div_div_ck for omap4, this node was broken in previous
>   versions and resulted into an orphan clock node
> - Fixed compile problem for omap5 only build reported by Felipe
> - Fixed a couple of sparse warnings
> - changed the mach-omap2/clock.c to use readl_relaxed / writel_relaxed
>   instead of __raw_readl / __raw_writel

Hi Tero,

This approach takes care of all of my concerns with this series. Thanks
for your long suffering patience on it.

It seems some build errors are cropping up, so once those are fixed then
I'll be happy to merge clk-next-dt-clks-v13 into clk-next for 3.14.

Regards,
Mike

> 
> Testing done:
> - omap3-beagle: boot / suspend-resume (RET) / suspend-resume (OFF)
> - omap4-panda-es: boot / suspend-resume (RET)
> - omap5-uevm: boot
> - am335x-bone: boot
> - dra7-evm: boot
> 
> Maintainer friendly branches also available:
> 
> tree: https://github.com/t-kristo/linux-pm.git
> 
> clk driver only (Mike): clk-next-dt-clks-v13
> DTS data only (Benoit): dts_for_3.14-dt-clks-v13
> full-branch (Tony/Paul): 3.13-rc7-dt-clks-v13
> 
> -Tero
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
