From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/16] ARM: omap: fix section mismatch error for
 omap_4430sdp_display_init()
Date: Wed, 8 Feb 2012 10:48:53 -0800
Message-ID: <20120208184852.GK29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAYM-0006HW-IG@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63170 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757276Ab2BHSsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:48:55 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAYM-0006HW-IG@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:08]:
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xb798): Section mismatch in reference from the function omap_4430sdp_display_init() to the function .init.text:omap_display_init()
> The function omap_4430sdp_display_init() references
> the function __init omap_display_init().
> This is often because omap_4430sdp_display_init lacks a __init
> annotation or the annotation of omap_display_init is wrong.
> 
> Fix this by adding __init to omap_4430sdp_display_init().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
