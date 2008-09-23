From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]TWL4030 battery driver madc str fix
Date: Tue, 23 Sep 2008 13:54:47 +0300
Message-ID: <20080923105447.GI5102@atomide.com>
References: <33445.192.168.10.89.1221739110.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64678 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbYIWKyv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 06:54:51 -0400
Content-Disposition: inline
In-Reply-To: <33445.192.168.10.89.1221739110.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

* Madhusudhan Chikkature <madhu.cr@ti.com> [080918 14:58]:
> Hi Tony,
> 
> I am resending the patch after fixing the comment provided by Jagadeesh.

Pushing

Tony

> 
> Regards,
> Madhu
> -------------------------------------------------------------------------
> From: Madhusudhan Chikkature<madhu.cr@ti.com>
> 
> This patch set up the unused madc request structure members to NULL.
> 
> Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> ---
>  drivers/power/twl4030_bci_battery.c |    2 ++
>  1 files changed, 2 insertions(+)
> 
> Index: linux-omap-2.6/drivers/power/twl4030_bci_battery.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/power/twl4030_bci_battery.c	2008-09-10
> 10:16:20.000000000 +0530
> +++ linux-omap-2.6/drivers/power/twl4030_bci_battery.c	2008-09-18
> 17:12:22.000000000 +0530
> @@ -604,7 +604,9 @@
>  	struct twl4030_madc_request req;
> 
>  	req.channels = (1 << 9);
> +	req.do_avg = 0;
>  	req.method = TWL4030_MADC_SW1;
> +	req.active = 0;
>  	req.func_cb = NULL;
>  	twl4030_madc_conversion(&req);
>  	temp = (u16)req.rbuf[9];
> 
> 
