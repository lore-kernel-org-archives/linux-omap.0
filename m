From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/20] Move rfbi init to rfbi probe
Date: Thu, 26 Aug 2010 16:54:11 -0700
Message-ID: <87zkw9rkv0.fsf@deeprootsystems.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	<1282579089-10487-2-git-send-email-svadivu@ti.com>
	<1282579089-10487-3-git-send-email-svadivu@ti.com>
	<1282579089-10487-4-git-send-email-svadivu@ti.com>
	<1282579089-10487-5-git-send-email-svadivu@ti.com>
	<1282579089-10487-6-git-send-email-svadivu@ti.com>
	<1282579089-10487-7-git-send-email-svadivu@ti.com>
	<1282579089-10487-8-git-send-email-svadivu@ti.com>
	<1282579089-10487-9-git-send-email-svadivu@ti.com>
	<1282579089-10487-10-git-send-email-svadivu@ti.com>
	<1282579089-10487-11-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49146 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab0HZXyO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 19:54:14 -0400
Received: by pvg2 with SMTP id 2so849121pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 16:54:14 -0700 (PDT)
In-Reply-To: <1282579089-10487-11-git-send-email-svadivu@ti.com> (Guruswamy
	Senthilvadivu's message of "Mon, 23 Aug 2010 21:27:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com

Guruswamy Senthilvadivu <svadivu@ti.com> writes:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>
> RFBI init and exit moved to rfbi probe and remove.
>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>

[...]

> @@ -357,11 +348,21 @@ static int omap_dsi1hw_remove(struct platform_device *pdev)
>  /* RFBI HW IP initialisation */
>  static int omap_rfbihw_probe(struct platform_device *pdev)
>  {
> -	return 0;
> +	int r;

minor: missing blank line

> +	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
> +	r = rfbi_init();
> +	if (r) {
> +		DSSERR("Failed to initialize rfbi\n");
> +		goto err_rfbi;
> +	}

here too

> +err_rfbi:
> +	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
> +	return r;
>  }
>  
>  static int omap_rfbihw_remove(struct platform_device *pdev)
>  {
> +	rfbi_exit();
>  	return 0;
>  }

Kevin
