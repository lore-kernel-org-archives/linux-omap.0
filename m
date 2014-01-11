From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Sat, 11 Jan 2014 17:35:23 +0100
Message-ID: <CAGhQ9Vz8i2EEG+GgFwXFj3vgeV_Eg0dDfRvKn-XRRVBjwJkDXQ@mail.gmail.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:48675 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbaAKQf0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Jan 2014 11:35:26 -0500
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, devicetree@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 9 January 2014 15:00, Tero Kristo <t-kristo@ti.com> wrote:
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

I tested 3.13-rc7-dt-clks-v13 on top of a next branch I am working on
with a OMAP4460 and it's working fine.

A couple of things I noticed in the boot log:
[ 0.000000] ti_dt_clocks_register: failed to lookup clock node bandgap_fclk
[ 0.000000] smp_twd: clock not found -2

I am get the bandgap_fclk clock lookup fail since it doesn't exist on
4460 and I guess the bandgap_ts_fclk clock will fail the same way on
4430. So maybe you need to differentiate between 4460 and 4430 in
clk-44xx.c to get rid of this warning.

As for the smp_twd clock I assume we can add "clocks =
<&mpu_periphclk>" to local-timer@48240600 in omap4.dtsi to get rid of
the warning. I can cook up a patch here if it is the right thing to
do.
I think the smp_twd warning existed before I applied this patch set.

regards
Joachim Eastwood
