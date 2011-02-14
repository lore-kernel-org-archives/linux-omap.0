From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH RESEND v6 2/4] TI816X: Update common OMAP machine specific sources
Date: Mon, 14 Feb 2011 15:27:35 -0800
Message-ID: <87tyg6xkm0.fsf@ti.com>
References: <1297695819-27027-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50529 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752147Ab1BNX1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 18:27:44 -0500
Received: by gyf1 with SMTP id 1so3110884gyf.7
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 15:27:40 -0800 (PST)
In-Reply-To: <1297695819-27027-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Mon, 14 Feb 2011 20:33:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Hemant Pedanekar <hemantp@ti.com> writes:

[...]

> @@ -402,7 +422,7 @@ void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
>  
>  	omap_hwmod_late_init();
>  
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> +	if (omap3_has_sdrc()) {
>  		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
>  		_omap2_init_reprogram_sdrc();
>  	}

At first glance, this one doesn't look quite right.  Will 
omap3_has_sdrc()  be true on 24xx?   Please confirm.

Kevin


