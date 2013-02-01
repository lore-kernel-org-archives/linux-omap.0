From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix the use of uninitialized dma_lch_count
Date: Fri, 1 Feb 2013 14:40:32 -0800
Message-ID: <20130201224032.GD22517@atomide.com>
References: <50EE9815.2080402@asianux.com>
 <50EE9C87.6060407@ti.com>
 <50EFA586.5010508@asianux.com>
 <50EFF99B.7040602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:13250 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757888Ab3BAWki (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 17:40:38 -0500
Content-Disposition: inline
In-Reply-To: <50EFF99B.7040602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Chen Gang <gang.chen@asianux.com>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130111 03:40]:
> On Friday 11 January 2013 11:09 AM, Chen Gang wrote:
> >
> >   'omap_dma_reserve_channels' when used is suppose to be from command.
> >     so, it alreay has value before 1st call of omap_system_dma_probe.
> >     and it will never be changed again during running (not from ioctl).
> >
> >   but 'dma_lch_count' is zero before 1st call of omap_system_dma_probe.
> >     so it will be failed for omap_dma_reserve_channels, when 1st call.
> >
> >   so, need use 'd->lch_count' instead of 'dma_lch_count' for judging.
> >
> >Signed-off-by: Chen Gang <gang.chen@asianux.com>
> >Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >---
> Looks fine to me.
> 
> Tony,
> If you are ok with the patch, can you pick this fix in your
> non-critical fixes branch ?

Yes applying thanks.

Tony
