From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 02/13] OMAP: DMA: Introduce errata handling feature
Date: Thu, 2 Dec 2010 11:59:57 -0800
Message-ID: <20101202195957.GU17222@atomide.com>
References: <1289225272-9767-1-git-send-email-manjugk@ti.com>
 <1289225272-9767-3-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41231 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282Ab0LBUAJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 15:00:09 -0500
Content-Disposition: inline
In-Reply-To: <1289225272-9767-3-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* G, Manjunath Kondaiah <manjugk@ti.com> [101108 05:58]:
> Implement errata handling to use flags instead of cpu_is_*
> and cpu_class_* in the code.
> 
> The errata flags are initialized at init time and during runtime
> we are using the errata variable (via the IS_DMA_ERRATA macro)
> to execute the required errata workaround.

Applying the first patch and this patch won't compile on omap1:

arch/arm/plat-omap/built-in.o: In function `omap_init_dma':
omap-pm-noop.c:(.init.text+0x604): undefined reference to `omap_type'

Tony
