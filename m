From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/11] ARM: OMAP: Fix relative includes for fpga.h
Date: Mon, 12 Nov 2012 13:34:55 -0800
Message-ID: <20121112213454.GM6801@atomide.com>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
 <20121031215252.GB15766@atomide.com>
 <50A0D3C6.4070206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65292 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754043Ab2KLVe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 16:34:59 -0500
Content-Disposition: inline
In-Reply-To: <50A0D3C6.4070206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Benoit Cousson <b-cousson@ti.com> [121112 02:49]:
> Hi Tony,
> 
> After rebasing on top of your omap-for-v3.8/tmp-merge, I realized that this patch is generating a build break due to removal of the fpga.h include from debug-leds.c.
> 
> arch/arm/plat-omap/debug-leds.c: In function 'fpga_probe':
> arch/arm/plat-omap/debug-leds.c:114:9: error: 'H2P2_DBG_FPGA_SIZE' undeclared (first use in this function)
> arch/arm/plat-omap/debug-leds.c:114:9: note: each undeclared identifier is reported only once for each function it appears in
> 
> It does not appear with the omap2plus_config but will appear if you enable the NEW_LEDS support that enable OMAP_DEBUG_LEDS.
> 
> I'm not sure why the size is still hard coded. In theory, assuming the resource is properly initialized, resource_size should be usable.
> The patch below is fixing that.

Thanks looks like I missed that one. Applying into
omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3.

Regards,

Tony
