From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/12] ARM: OMAP2 DT clock conversion
Date: Mon, 3 Mar 2014 10:16:58 +0200
Message-ID: <53143A7A.9020703@ti.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com> <5310B271.5040708@ti.com> <20140228180112.GC15399@atomide.com> <5310D2FE.5090209@ti.com> <20140228183313.GD15399@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53350 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbaCCIR1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Mar 2014 03:17:27 -0500
In-Reply-To: <20140228183313.GD15399@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 02/28/2014 08:33 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [140228 10:21]:
>>
>> Hmm, some clock node is broken, might be missing a name or parent
>> name for some reason. Can you try to boot with DEBUG enabled so you
>> get pr_debug:s out and see which clock is being initialized during
>> the crash?
>
> ...
> [    0.000000] ti_dt_clk_init_provider: ti_dt_clk_init_provider: initializing: core_d18_ck
> [    0.000000] ti_dt_clk_init_provider: ti_dt_clk_init_provider: initializing: vlynq_mux_fck
> [    0.000000] ti_dt_clk_init_provider: ti_dt_clk_init_provider: initializing: vlynq_fck
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> ...
>
> We really should be registering the clocks lazily as needed BTW. That
> leaves out the dependency to DEBUG_LL for seeing any kind of decent
> error messages during the booting.
>
> Regards,
>
> Tony
>

Hey Tony,

Can you retry with the branch? I just pushed one patch there, seems the 
parents for the vlynq_mux_fck were somewhat broken (there are holes in 
the valid mux values list, which hasn't happened with any other 
mux-clock so far.)

If this works, I will rework the series a bit and send v2 out. 
Alternatively I need to add extra debug info.

-Tero

