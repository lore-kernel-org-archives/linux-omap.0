From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch 2.6.27-rc3-omap1] tweak musb_hdrc SOC init code
Date: Tue, 2 Sep 2008 22:39:23 +0300
Message-ID: <20080902193920.GE6814@frodo>
References: <200809021205.00376.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43475 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbYIBTjq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 15:39:46 -0400
Content-Disposition: inline
In-Reply-To: <200809021205.00376.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Tue, Sep 02, 2008 at 12:05:00PM -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Minor cleanups to omap 2430/34xx/35x musb_hdrc init:
> 
>  - num_eps is 16; here, each one is bidirectional
>  - use DMA_32BIT_MASK to prevent confusion/errors
>  - initialize root port power to reflect 100 mA limit
> 
> This still hard-wires some board-specific data, since there
> are no hooks through which different boards can provide the
> right data to the init code.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> +
> +	/* REVISIT charge pump on TWL4030 can supply up to
> +	 * 100 mA ... but this value is board-specific, like
> +	 * "mode", and should be passed to usb_musb_init().
> +	 */
> +	.power		= 50,			/* up to 100 mA */

We can add some parameters to usb_musb_init();
Something similar should be done to hsmmc_init(), as of now it only
registers one slot and some boards have more than one.

-- 
balbi
