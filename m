From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Remove unnecessarily .init initializers from OMAP3
 clocks
Date: Mon, 11 Jan 2010 17:16:44 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001111716110.8534@utopia.booyaka.com>
References: <20100110223031.GA15812@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58324 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab0ALAQp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 19:16:45 -0500
In-Reply-To: <20100110223031.GA15812@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Sun, 10 Jan 2010, Russell King - ARM Linux wrote:

> The first thing that omap2_init_clksel_parent() does is check for
> a non-zero .clksel field in the struct clk.  Therefore, it is
> pointless calling this function on clocks where the clksel field
> is unset.
> 
> Remove init calls to omap2_init_clksel_parent() on clocks without
> a clksel field.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks, queuing for .33-rc.


- Paul
