From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/2] clk: ti: divider: try to fix ti_clk_register_divider
Date: Fri, 21 Apr 2017 18:58:20 -0700
Message-ID: <20170422015820.GZ7065@codeaurora.org>
References: <20170419174507.4055014-1-arnd@arndb.de>
 <7f0c996e-df53-ffb7-2c02-2f7fa66d2b94@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7f0c996e-df53-ffb7-2c02-2f7fa66d2b94@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Turquette <mturquette@baylibre.com>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/20, Tero Kristo wrote:
> On 19/04/17 20:44, Arnd Bergmann wrote:
> >The newly introduced function is entirely bogus as I found when looking
> >at this warning:
> >
> >drivers/clk/ti/divider.c: In function 'ti_clk_register_divider':
> >drivers/clk/ti/divider.c:460:8: error: 'reg' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >
> >Treating a 'u32' variable as a structure leads to a stack overflow here,
> >and the register address we pass down is never initialized.
> >
> >As the code in its original form makes no sense, I can only guess what
> >the intention was, and change it to take the address from div->reg.ptr
> >instead.
> 
> Actually, I believe the code you are fixing works before this commit:
> 
> commit 6c0afb503937a12a8d20a805fcf263e31afa9871
> Author: Tero Kristo <t-kristo@ti.com>
> Date:   Thu Feb 9 11:24:37 2017 +0200
> 
>     clk: ti: convert to use proper register definition for all accesses
> 
> 
> ... it attempted to convert all the register accesses to the new
> format and change the size of the clk_omap_reg in bulk but I missed
> converting this one. Previously the size of the clk_omap_reg
> definition was u32, but this was confusing and bug prone so I
> changed it.
> 
> The failing piece of code is only executed for legacy boot mode
> OMAP3 right now, which could be potentially stripped out of the
> kernel already (I think Tony removed the support for non-DT boot
> OMAP3 boards already...?) This explains why I didn't notice the
> issue in my local testing either.
> 
> >
> >Fixes: d96f774b2538 ("clk: ti: divider: add support for legacy divider init")
> >Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> So, this patch itself is fine, but the desc should be updated to
> reflect the above somehow.
> 
> And the "Fixes:" line should be updated to point to the commit
> mentioned above also.
> 

Waiting for Arnd to agree. I can also rename reg_setup to reg.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
