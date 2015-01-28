From: Tony Lindgren <tony@atomide.com>
Subject: Re: clk: ti: Add support for FAPLL on dm816x
Date: Wed, 28 Jan 2015 08:46:57 -0800
Message-ID: <20150128164657.GN28663@atomide.com>
References: <20150128110514.GA4656@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.ore.mailhop.org ([54.186.10.118]:51251 "EHLO
	smtp5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbbA1U1R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2015 15:27:17 -0500
Content-Disposition: inline
In-Reply-To: <20150128110514.GA4656@mwanda>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-omap@vger.kernel.org

* Dan Carpenter <dan.carpenter@oracle.com> [150128 03:08]:
> Hello Tony Lindgren,
> 
> The patch 163152cbbe32: "clk: ti: Add support for FAPLL on dm816x"
> from Jan 13, 2015, leads to the following static checker warning:
> 
> 	drivers/clk/ti/fapll.c:87 ti_fapll_enable()
> 	warn: double left shift '1 << (1 << (3))'
> 
> drivers/clk/ti/fapll.c
>     82  static int ti_fapll_enable(struct clk_hw *hw)
>     83  {
>     84          struct fapll_data *fd = to_fapll(hw);
>     85          u32 v = readl_relaxed(fd->base);
>     86  
>     87          v |= (1 << FAPLL_MAIN_PLLEN);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> FAPLL_MAIN_PLLEN() is BIT(3).  It's possible that this code is correct
> as is, but as a complete outsider I think it's more likely that the
> code should be:
> 
> 		v |= FAPLL_MAIN_PLLEN;
> 
> 
>     88          writel_relaxed(v, fd->base);
>     89  
>     90          return 0;
>     91  }
>     92  
>     93  static void ti_fapll_disable(struct clk_hw *hw)
>     94  {
>     95          struct fapll_data *fd = to_fapll(hw);
>     96          u32 v = readl_relaxed(fd->base);
>     97  
>     98          v &= ~(1 << FAPLL_MAIN_PLLEN);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Same.
> 
>     99          writel_relaxed(v, fd->base);
>    100  }
>    101  
>    102  static int ti_fapll_is_enabled(struct clk_hw *hw)
>    103  {
>    104          struct fapll_data *fd = to_fapll(hw);
>    105          u32 v = readl_relaxed(fd->base);
>    106  
>    107          return v & (1 << FAPLL_MAIN_PLLEN);
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Same.
> 
>    108  }

Thanks for catching that. Yes that's a bug, I've screwed up
while cleaning up and means the parent PLL will not get disabled
even if all the children are disabled.

Will send a fix shortly.

Regards,

Tony
