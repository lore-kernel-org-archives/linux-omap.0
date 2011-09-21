From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 05/26] gpio/omap: handle save/restore context in
 GPIO driver
Date: Wed, 21 Sep 2011 07:48:27 -0700
Message-ID: <20110921144826.GQ2937@atomide.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
 <1315918979-26173-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:45986 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751708Ab1IUOs2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 10:48:28 -0400
Content-Disposition: inline
In-Reply-To: <1315918979-26173-6-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> From: Charulatha V <charu@ti.com>
> 
> Modify omap_gpio_prepare_for_idle() & omap_gpio_resume_after_idle() functions
> to handle save context & restore context respectively in the OMAP GPIO driver
> itself instead of calling these functions from pm specific files.
> For this, in gpio_prepare_for_idle(), call *_get_context_loss_count() and in
> gpio_resume_after_idle() call it again. If the count is different, do restore
> context. The workaround_enabled flag is no more required and is removed.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

This to should be also acked by Kevin, looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
