From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/13] ARM: OMAP5: l3: Add l3 error handler support for
 omap5.
Date: Fri, 4 May 2012 15:51:54 -0700
Message-ID: <20120504225153.GZ5613@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-8-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29436 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760555Ab2EDWv4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 18:51:56 -0400
Content-Disposition: inline
In-Reply-To: <1336029982-31898-8-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

* R Sricharan <r.sricharan@ti.com> [120503 00:30]:
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -85,7 +85,7 @@ static int __init omap4_l3_init(void)
>  	 * To avoid code running on other OMAPs in
>  	 * multi-omap builds
>  	 */
> -	if (!(cpu_is_omap44xx()))
> +	if ((!(cpu_is_omap44xx())) && (!cpu_is_omap54xx()))
>  		return -ENODEV;
>  
>  	for (i = 0; i < L3_MODULES; i++) {

Isn't there some unnecessary parens here?

Tony

