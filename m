From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/16] ARM: omap: preemptively fix section mismatch in
 omap4_sdp4430_wifi_mux_init()
Date: Wed, 8 Feb 2012 10:48:16 -0800
Message-ID: <20120208184816.GI29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAXi-0006HN-9X@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62392 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913Ab2BHSsT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:48:19 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAXi-0006HN-9X@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:07]:
> Found by review.
> 
> omap4_sdp4430_wifi_mux_init() is called by an __init marked function,
> and only calls omap_mux_init_gpio() and omap_mux_init_signal() which
> are both also an __init marked functions.
> 
> The only reason this doesn't issue a warning is because the compiler
> inlines omap4_sdp4430_wifi_mux_init() into omap4_sdp4430_wifi_init().
> 
> So, lets add the __init annotation to ensure this remains safe should
> the compiler choose not to inline.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
