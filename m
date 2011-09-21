From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 04/26] gpio/omap: fix pwrdm_post_transition call
 sequence
Date: Wed, 21 Sep 2011 07:47:20 -0700
Message-ID: <20110921144720.GP2937@atomide.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
 <1315918979-26173-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:43392 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751480Ab1IUOrX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 10:47:23 -0400
Content-Disposition: inline
In-Reply-To: <1315918979-26173-5-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> From: Charulatha V <charu@ti.com>
> 
> The context lost count is modified in omap_sram_idle() path when
> pwrdm_post_transition() is called. But pwrdm_post_transition() is called
> only after omap_gpio_resume_after_idle() is called. Correct this so that
> context lost count is modified before calling omap_gpio_resume_after_idle().
> 
> This would be useful when OMAP GPIO save/restore context is called by
> the OMAP GPIO driver itself.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

This should be acked by Kevin, looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>

