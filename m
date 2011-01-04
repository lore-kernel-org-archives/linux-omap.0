From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFT/PATCH 01/10] cbus: retu: give it a context structure
Date: Mon, 3 Jan 2011 17:40:16 -0800
Message-ID: <20110104014016.GW7771@atomide.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
 <1294040988-21191-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:16318 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1ADBkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 20:40:19 -0500
Content-Disposition: inline
In-Reply-To: <1294040988-21191-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110102 23:49]:
> This is pretty much a cleanup patch just
> adding a context structure for Retu, to avoid
> all the globals it had.
> 
> Note that this breaks retu-user.c due to moving
> the lock around, but that retu-user.c has to
> go anyway as it's completely non-standard way
> of accessing Retu children.

FYI, this one alone fails to compile with:

drivers/cbus/retu-user.c: In function 'retu_user_write_with_mask':
drivers/cbus/retu-user.c:208: error: 'retu_lock' undeclared (first use in this function)
drivers/cbus/retu-user.c:208: error: (Each undeclared identifier is reported only once
drivers/cbus/retu-user.c:208: error: for each function it appears in.)

Regards,

Tony
