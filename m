From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Free HDQ clocks in error path
Date: Tue, 5 Aug 2008 16:30:01 +0300
Message-ID: <20080805132956.GI7193@atomide.com>
References: <44661.192.168.10.89.1216728238.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54258 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbYHENaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 09:30:10 -0400
Content-Disposition: inline
In-Reply-To: <44661.192.168.10.89.1216728238.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

* Madhusudhan Chikkature <madhu.cr@ti.com> [080722 15:04]:
> Hi,
> 
> This patch provides the fix to free the HDQ clocks in the error path.
> 
> Regards,
> Madhu
> -----------------------------------------------------------------
> 
> From: Madhusudhan Chikkature<madhu.cr@ti.com>
> 
> ARM: OMAP3: Free HDQ clocks when a read is tried with no battery connected

Pushing today.

Tony


> Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> ---
>  drivers/w1/masters/omap_hdq.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> Index: linux-omap-ti.git-07102008/drivers/w1/masters/omap_hdq.c
> ===================================================================
> --- linux-omap-ti.git-07102008.orig/drivers/w1/masters/omap_hdq.c	2008-07-02
> 20:10:38.000000000 +0530
> +++ linux-omap-ti.git-07102008/drivers/w1/masters/omap_hdq.c	2008-07-16
> 12:17:42.000000000 +0530
> @@ -515,8 +515,11 @@ static u8 omap_w1_read_byte(void *data)
>  	int ret;
> 
>  	ret = hdq_read_byte(&val);
> -	if (ret)
> +	if (ret) {
> +		init_trans = 0;
> +		omap_hdq_put();
>  		return -1;
> +	}
> 
>  	/* Write followed by a read, release the module */
>  	if (init_trans) {
> 
> 
