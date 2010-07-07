From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/9] omap: move generic omap3 features to generic
Date: Wed, 7 Jul 2010 15:30:03 +0300
Message-ID: <20100707123002.GS1920@atomide.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>
 <1277259375-18521-7-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62768 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab0GGMaL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 08:30:11 -0400
Content-Disposition: inline
In-Reply-To: <1277259375-18521-7-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Venkatraman S <svenkatr@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Vishwanath S <vishwa.s@ti.com>

* Nishanth Menon <nm@ti.com> [100623 05:15]:
> @@ -354,11 +354,11 @@ static void __init omap3_cpuinfo(void)
>  	/* Print verbose information */
>  	pr_info("%s ES%s (", cpu_name, cpu_rev);
>  
> -	OMAP_SHOW_FEATURE(3, l2cache);
> -	OMAP_SHOW_FEATURE(3, iva);
> -	OMAP_SHOW_FEATURE(3, sgx);
> -	OMAP_SHOW_FEATURE(3, neon);
> -	OMAP_SHOW_FEATURE(3, isp);
> +	OMAP_SHOW_FEATURE(, l2cache);
> +	OMAP_SHOW_FEATURE(, iva);
> +	OMAP_SHOW_FEATURE(, sgx);
> +	OMAP_SHOW_FEATURE(, neon);
> +	OMAP_SHOW_FEATURE(, isp);
>  	OMAP_SHOW_FEATURE(3, 192mhz_clk);

Then you can simplify OMAP_SHOW_FEATURE too as
the "3, " should not be needed?

Tony
