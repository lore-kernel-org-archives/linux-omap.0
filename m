From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv12 0/9] OMAP3+: PRCM chain handler
Date: Fri, 16 Dec 2011 14:57:22 +0200
Message-ID: <1324040242.18394.12.camel@sokoban>
References: <20111215213358.26632.44165.stgit@dusk>
	 <alpine.DEB.2.00.1112152207440.12660@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33373 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953Ab1LPM53 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 07:57:29 -0500
In-Reply-To: <alpine.DEB.2.00.1112152207440.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 2011-12-15 at 22:10 -0700, Paul Walmsley wrote:
> Hi
> 
> This series was boot-tested on a 4430 ES2 Panda also.  It generates the 
> following message on boot:
> 
> PRCM: failed to allocate irq descs: -12
> 
> which is an -ENOMEM coming from irq_alloc_descs().  This is probably 
> because OMAP hasn't been converted to use sparse IRQs yet.

You should be able to enable SPARSE_IRQ from the config and this
probably fixes it, this is what I saw with OMAP4 testing, not sure if it
was enabled on your config.

> Until that happens, this message should be harmless.

Currently I guess it is harmless as we don't have OMAP4 PM support
anyway, so nobody can use the PRCM interrupts on that platform anyway.
The error message itself indicates that PRCM interrupt support does not
work at all.

Other than that, the set looks good to me after your changes.

-Tero


