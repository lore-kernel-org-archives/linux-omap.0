From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/16] ARM: omap: resolve nebulous 'Error setting
 wl12xx data'
Date: Wed, 8 Feb 2012 10:56:50 -0800
Message-ID: <20120208185650.GO29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAZf-0006Hm-40@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15451 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913Ab2BHS46 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:56:58 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAZf-0006Hm-40@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:09]:
> It's useful to print the error code when a called function fails so a
> diagnosis of why it failed is possible.  In this case, it fails because
> we try to register some data for the wl12xx driver, but as the driver
> is not configured, a stub function is used which simply returns -ENOSYS.
> 
> Let's do the simple thing for -rc and print the error code.
> 
> Also, the return code from platform_register_device() at each of these
> sites was not being checked.  Add some checking, and again print the
> error code.
> 
> This should be fixed properly for the next merge window so we don't
> issue error messages merely because a driver is not configured.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looks right to me for -rc. Yes let's plan on fixing this for v3.4.

Acked-by: Tony Lindgren <tony@atomide.com>
