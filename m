From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Mon, 07 Oct 2013 22:40:34 -0700
Message-ID: <20131008054034.7445.48080@quantum>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42862 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab3JHFkh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 01:40:37 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so8444102pab.29
        for <linux-omap@vger.kernel.org>; Mon, 07 Oct 2013 22:40:37 -0700 (PDT)
In-Reply-To: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Quoting Tero Kristo (2013-09-25 01:48:06)
> Hi all,
> 
> Version 7 contains following high level changes:
> - Dropped support for basic bindings from Mike Turquette, instead using
>   vendor specific bindings for all clocks
> - Mux clock + divider clock vendor specific bindings get rid of use
>   of the bit-masks, instead these are generated runtime based on parent
>   clock / divider min/max info, see individual patches for details
> - Added support for dummy_ck nodes, was missing from previous version
> - Fixed support for omap3630
> - Added support for new clock node type: ti,mux-gate-clock (using composite
>   clock type)
> - OMAP4 / OMAP5 only build fixes (compiler flag checks added to some files)
> - most of the of_omap_* calls renamed to of_ti_*
> - Rebased on top of v3.12-rc2

Hi Tero,

I had one really minor request for one of the patches, otherwise I'm
pretty happy with this series and I can take in the clock parts for
3.13. A few general comments:

1) I think I mentioned some time back that it would be
wise to put a disclaimer at the top of each DT binding description
stating something to the effect: "Binding status: Unstable - ABI
compatibility may be broken in the future". Are you OK merging these
bindings as-is without that kind of a disclaimer?

2) I hope to see the clockdomain stuff go away in the future. I'm OK to
take it for now to aid in this DT transition but I would like some
commitment that it will not stay in drivers/clk/omap forever. I guess
for clockdomain you'll need to figure out how to handle those in a
generic driver way.

3) Same concern as above but for the DT clkdev alias stuff. I guess
you'll need to make all of the dependent drivers play nice with DT. Do
you plan to remove it within a reasonable timeframe? It would be a nice
reduction in LoC and more importantly it would mean that drivers were
using clkdev in a more-correct fashion.

Regards,
Mike

> 
> Some detailed comments about patch level changes (if no mention, no major
> changes):
> - Patch #1:
>   * removed use of reg-names property, instead registers mapped using
>     compatible string
>   * removed ti,modes property, instead uses DPLL mode flags now
>   * separated AM33XX DPLLs under their own compatible strings
> - Patch #4 & #5: new patches
> - Patch #6: merged basic gate support from Mike to this patch as vendor
>   specific gate clock support
> - Patch #9 & #10: new patches
> - Patch #11: dummy clocks added, USB / ABE DPLL setup ordering changed
> - Patch #14: dummy clocks added
> - Patch #20: dropped usage of reg-names property
> - Patch #21: dummy clocks added
> - Patch #22 & #23: new patches
> - Patch #30: AM35XX clock data added to this patch
> - Patch #31:
>   * dummy clocks added
>   * added missing 3630 clocks
> 
> Test branch available here:
> https://github.com/t-kristo/linux-pm.git
> branch: mainline-3.12-rc2-ti-dt-clks-v7
> 
> Testing done:
> - am335x-bone : boot only
> - omap5-sevm : boot only
> - dra7-evm : boot only
> - omap3-beagle : boot + suspend/resume (ret + off)
> - omap4-panda-es : boot + suspend/resume
> 
> Nishanth has also been doing some tests with omap3-beagle-xm with some WIP
> versions of this branch, but not with this latest one. Nishanth, maybe you
> can provide test results to this one also?
> 
> -Tero
