From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH 1/2] regulator: twl6030: do not write to _GRP for
 regulator enable
Date: Sun, 22 May 2011 10:26:28 +0100
Message-ID: <1306056388.3263.4.camel@odin>
References: <1305898432-14939-1-git-send-email-balajitk@ti.com>
	 <1305898432-14939-2-git-send-email-balajitk@ti.com>
	 <20110522065013.GA18955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46101 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab1EVJ0d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 May 2011 05:26:33 -0400
Received: by wya21 with SMTP id 21so3576424wya.19
        for <linux-omap@vger.kernel.org>; Sun, 22 May 2011 02:26:32 -0700 (PDT)
In-Reply-To: <20110522065013.GA18955@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org, lrg@ti.com, gg@slimlogic.co.uk

On Sun, 2011-05-22 at 14:50 +0800, Mark Brown wrote:
> On Fri, May 20, 2011 at 07:03:51PM +0530, Balaji T K wrote:
> > TWL6030: regulator is enabled via VREG_STATE
> > TWL4030: regulator is enabled via VREG_GRP
> > Since there is nothing common, split twlreg_enable similar to other regulator_ops
> > 
> > Signed-off-by: Balaji T K <balajitk@ti.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> but
> 
> >  
> >  	udelay(info->delay);
> 
> all these need to be replaced by implementing get_enable_time().

Both Applied.

Can you fix this incrementally.

Thanks

Liam

