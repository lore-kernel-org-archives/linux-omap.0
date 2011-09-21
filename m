From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 15/26] gpio/omap: remove bank->method & METHOD_*
 macros
Date: Wed, 21 Sep 2011 08:05:33 -0700
Message-ID: <20110921150533.GA2937@atomide.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
 <1315918979-26173-16-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24484 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752005Ab1IUPFe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 11:05:34 -0400
Content-Disposition: inline
In-Reply-To: <1315918979-26173-16-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:30]:
> From: Charulatha V <charu@ti.com>
> 
> The only bank->type (method) used in the OMAP GPIO driver is MPUIO type as they
> need to be handled separately. Identify the same using a flag and remove all
> METHOD_* macros.
> 
> mpuio_init() function is defined under #ifdefs. It is required only in case
> of MPUIO bank type and only when PM operations are supported by it.
> This is applicable only in case of OMAP16xx SoC's MPUIO GPIO bank type.
> For all the other cases it is a dummy function. Hence clean up the same
> and remove all the OMAP SoC specific #ifdefs.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
