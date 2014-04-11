From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: don't try to register the main clock
 twice.
Date: Fri, 11 Apr 2014 18:33:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404111829520.14347@utopia.booyaka.com>
References: <1396007435-20100-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60452 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbaDKSdy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2014 14:33:54 -0400
In-Reply-To: <1396007435-20100-1-git-send-email-wsa@the-dreams.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@sang-engineering.com>

Hi Wolfram, Neil,

On Fri, 28 Mar 2014, Wolfram Sang wrote:

> From: NeilBrown <neilb@suse.de>
> 
> If omap_device_alloc is given 2 or more "struct omap_hwmod" it will try
> to register the 'main_clk' of each of them with the same alias - "fck" -
> against the same device.  This fails. So to avoid a warning, don't even
> try.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> [wsa: ported to top-of-tree]
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>

What devices and hwmods cause this warning on AM335x?   Ideally, there 
should only be one hwmod per device.  Usually when multiple hwmods are 
stacked up for a device, it means that something isn't right - either the 
hwmod data, or the device driver itself. 

In the specific context of this patch, the problem would be: what if the 
two hwmods have different main_clk entries?  Which one should be 
associated with the "fck" alias?


- Paul
