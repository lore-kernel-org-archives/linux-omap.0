From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4] OMAP: DSS2: Have separate irq handlers for DISPC
 and DSI
Date: Wed, 23 Feb 2011 12:11:44 +0200
Message-ID: <1298455904.29392.9.camel@deskari>
References: <1298450463-31087-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42132 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331Ab1BWKLs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 05:11:48 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1NABmgR017414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 04:11:48 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1NABliw019970
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 04:11:47 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1NABlWt019246
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 04:11:47 -0600 (CST)
In-Reply-To: <1298450463-31087-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

On Wed, 2011-02-23 at 02:41 -0600, Taneja, Archit wrote:
> Currently, the core DSS platform device requests for an irq line for OMAP2 and
> OMAP3. Make DISPC and DSI platform devices request for a shared IRQ line.
> 
> On OMAP3, the logical OR of DSI and DISPC interrupt lines goes to the MPU. There
> is a register DSS_IRQSTATUS which tells if the interrupt came from DISPC or DSI.
> 
> On OMAP2, there is no DSI, only DISPC interrupts goto the MPU. There is no
> DSS_IRQSTATUS register.
> 
> Hence, it makes more sense to have separate irq handlers corresponding to the
> DSS sub modules instead of having a common handler.
> 
> Since on OMAP3 the logical OR of the lines goes to MPU, the irq line is shared
> among the IRQ handlers.
> 
> The hwmod irq info has been removed for DSS to DISPC and DSI for OMAP2 and OMAP3
> hwmod databases. The Probes of DISPC and DSI now request for irq handlers.

<snip>

> +       r = request_irq(dispc.irq, omap_dispc_irq_handler, IRQF_SHARED,
> +               "OMAP DISPC", dispc.pdev);
> +       if (r < 0) {
> +               DSSERR("request_irq failed\n");
> +               goto fail1;
>         }
> 
>         enable_clocks(1);
> @@ -3361,10 +3388,15 @@ static int omap_dispchw_probe(struct platform_device *pdev)
>         enable_clocks(0);
> 
>         return 0;
> +fail1:
> +       iounmap(dispc.base);
> +fail0:
> +       return r;
>  }
> 
>  static int omap_dispchw_remove(struct platform_device *pdev)
>  {
> +       free_irq(dispc.irq, NULL);

This fails when unloading the DSS module. free_irq() needs the same data
that was used in request_irq, dispc.pdev in this case. And the same
thing in dsi.

I fixed this, and a minor conflict in dsi's fail path. The commit is in
my master branch. Please check the commit to see that I didn't mess
anything up.

Otherwise the patch is good.

 Tomi


