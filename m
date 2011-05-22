From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] regulator: twl6030: do not write to _GRP for
 regulator enable
Date: Sun, 22 May 2011 14:50:24 +0800
Message-ID: <20110522065013.GA18955@opensource.wolfsonmicro.com>
References: <1305898432-14939-1-git-send-email-balajitk@ti.com>
 <1305898432-14939-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57454 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751788Ab1EVGuZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 May 2011 02:50:25 -0400
Content-Disposition: inline
In-Reply-To: <1305898432-14939-2-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, lrg@ti.com, gg@slimlogic.co.uk

On Fri, May 20, 2011 at 07:03:51PM +0530, Balaji T K wrote:
> TWL6030: regulator is enabled via VREG_STATE
> TWL4030: regulator is enabled via VREG_GRP
> Since there is nothing common, split twlreg_enable similar to other regulator_ops
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but

>  
>  	udelay(info->delay);

all these need to be replaced by implementing get_enable_time().
