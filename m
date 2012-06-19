From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH 09/29] ARM: omap: clk: Nuke plat/clock.c & reuse struct
 clk as clk_hw_omap
Date: Mon, 18 Jun 2012 18:38:12 -0700
Message-ID: <20120619013812.GC4402@gmail.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-10-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:54631 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753305Ab2FSBiS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 21:38:18 -0400
Received: by dakp5 with SMTP id p5so9524244dak.14
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 18:38:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339678038-23082-10-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 20120614-18:16, Rajendra Nayak wrote:
> plat/clock.c which has most of usecounting/locking infrastructure will
> be used only for OMAP1 until that is moved to use COMMON clk.
> 
> reuse most of what plat/clock.h has while we move to common clk, and
> move most of what 'struct clk' was as 'struct clk_hw_omap' which
> will then be used to define platform specific parameters.
> All usecounting/locking related variables from 'struct clk' are
> dropped as they will not be used with 'struct clk_hw_omap'.
> 
> Based on the original changes from Mike Turquette.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Looks good to me Rajendra.

Reviewed-by: Mike Turquette <mturquette@linaro.org>

> +unsigned long omap_fixed_divisor_recalc(struct clk_hw *hw,
> +		unsigned long parent_rate);

Would be nice to get rid of this.  I think only iva1_mpu_int_ifck from
OMAP2 uses it.  If so it would be nice to convert that clock over to the
fixed factor type (if possible) and drop this bit of glue code.
Probably something for the future though, no reason to block this patch
on it.

Regards,
Mike
