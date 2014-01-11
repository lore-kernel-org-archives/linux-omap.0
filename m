From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Sat, 11 Jan 2014 11:54:45 +0200
Message-ID: <52D114E5.7060503@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com> <20140109222322.7168.74522@quantum> <20140110185305.GN31323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41277 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbaAKJzP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Jan 2014 04:55:15 -0500
In-Reply-To: <20140110185305.GN31323@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@linaro.org>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 01/10/2014 08:53 PM, Tony Lindgren wrote:
> * Mike Turquette <mturquette@linaro.org> [140109 14:25]:
>> Quoting Tero Kristo (2014-01-09 06:00:11)
>>> Hi,
>>>
>>> So, bad luck number release for this, as v12 wasn't sufficient still.
>>>
>>> Changes compared to previous version:
>>> - Dropped any changes to generic clock drivers, as it seems impossible
>>>    to agree anything in short term, this means the patch set shrank in
>>>    size from 49 patches to 40 (first 9 patches were dropped).
>>> - Copy pasted implementation for clk-divider and clk-mux from drivers/clk
>>>    to drivers/clk/ti, and made the modifications needed to the TI version
>>>    of the clock drivers only (based on discussions with Mike, this is fine)
>>> - Changed name of clk_ll_ops to ti_clk_ll_ops so that this doesn't conflict
>>>    with any generic implementation we might have at some point, migrating
>>>    this to the generic version should be easy enough also.
>>> - Fixed trace_clk_div_div_ck for omap4, this node was broken in previous
>>>    versions and resulted into an orphan clock node
>>> - Fixed compile problem for omap5 only build reported by Felipe
>>> - Fixed a couple of sparse warnings
>>> - changed the mach-omap2/clock.c to use readl_relaxed / writel_relaxed
>>>    instead of __raw_readl / __raw_writel
>>
>> Hi Tero,
>>
>> This approach takes care of all of my concerns with this series. Thanks
>> for your long suffering patience on it.
>>
>> It seems some build errors are cropping up, so once those are fixed then
>> I'll be happy to merge clk-next-dt-clks-v13 into clk-next for 3.14.
>
> I'm fine with Mike merging these all via the clock tree assuming no more
> pending comments. For the patches changed from the last time around,
> please feel free to add:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

How about the dts data patches? Should these also go via Mike's tree? 
Otherwise we will have boot failures until the dts patches are merged.

-Tero

