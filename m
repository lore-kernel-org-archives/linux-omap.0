From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 13/28] ARM: OMAP: Beagle: use new TFP410 platform
 driver
Date: Thu, 28 Mar 2013 13:52:21 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1303281350530.5382@pmeerw.net>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <1364474962-20439-14-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41263 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755662Ab3C1Mw0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:52:26 -0400
In-Reply-To: <1364474962-20439-14-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>


> -static struct omap_dss_device beagle_dvi_device = {
> -	.type = OMAP_DISPLAY_TYPE_DPI,
> -	.name = "dvi",
> -	.driver_name = "tfp410",
> -	.data = &dvi_panel,
> -	.phy.dpi.data_lines = 24,
> +static struct platform_device omap4_panda_tfp410_device = {

omap4_panda? this is omap3_beagle!

-- 

Peter Meerwald
+43-664-2444418 (mobile)
