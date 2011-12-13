From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv11 8/8] ARM: OMAP: mux: add support for selecting
 mpu_irq for each wakeup pad
Date: Mon, 12 Dec 2011 16:25:56 -0800
Message-ID: <20111213002555.GO32251@atomide.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-9-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60345 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753759Ab1LMAZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 19:25:57 -0500
Content-Disposition: inline
In-Reply-To: <1323713733-13115-9-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [111212 09:44]:
> By default all registered pads will trigger mpu_irqs[0]. Now there is
> an API for selecting used mpu_irq on pad basis, which can be used to
> trigger different irq handlers for different pads in the same hwmod.
> Each pad that requires its interrupt to be re-routed this way must
> have a separate call to omap_hwmod_pad_route_irq(hwmod, pad, irq).
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
