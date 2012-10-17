From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: move plat-omap/include/plat/sdrc.h into
 mach-omap2/sdrc.h
Date: Wed, 17 Oct 2012 10:38:37 -0700
Message-ID: <20121017173837.GU15569@atomide.com>
References: <alpine.DEB.2.00.1210170038200.9767@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19940 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757419Ab2JQRil (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 13:38:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210170038200.9767@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121016 17:48]:
> 
> Remove arch/arm/plat-omap/include/plat/sdrc.h by folding its contents
> into arch/arm/mach-omap2/sdrc.h.  The objective is to assist Tony in
> cleaning out arch/arm/plat-omap/, as his upstreams request.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> 
> This has a dependency on Tomi's "OMAP: VRFB: convert to platform device" 
> series.

Thanks applying this into omap-for-v3.8/cleanup-headers-dss.

Regards,

Tony
