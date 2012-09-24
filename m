From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix PMU interrupt definitions
Date: Mon, 24 Sep 2012 21:38:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209242137120.3221@utopia.booyaka.com>
References: <1348522362-912-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39846 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab2IXViN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 17:38:13 -0400
In-Reply-To: <1348522362-912-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Mon, 24 Sep 2012, Jon Hunter wrote:

> Commit 7d7e1eb (ARM: OMAP2+: Prepare for irqs.h removal) and commit ec2c082
> (ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ) updated the way
> interrupts for OMAP2/3 devices are defined in the HWMOD data structures to
> being an index plus a fixed offset (defined by OMAP_INTC_START). The definition
> of the PMU interrupts on OMAP2/3 devices is missing the OMAP_INTC_START offset
> and so this is causing the allocation of PMU interrupts to fail on OMAP2/3
> devices. So add the offset to fix this.
> 
> This is patch is based upon the Tony's master branch for OMAP.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks, looks like I missed that when the patch was rebased.  Queued into 
devel-late-fixes.


- Paul
