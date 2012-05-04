From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] net: davinci_emac: Add pre_open, post_stop platform callbacks
Date: Fri, 04 May 2012 09:44:45 -0700
Message-ID: <87y5p7c2v6.fsf@ti.com>
References: <20120502234718.GA5432@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39882 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752220Ab2EDQoo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 12:44:44 -0400
Received: by dacx6 with SMTP id x6so4782089dac.17
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 09:44:43 -0700 (PDT)
In-Reply-To: <20120502234718.GA5432@animalcreek.com> (Mark A. Greer's message
	of "Wed, 2 May 2012 16:47:18 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, nsekhar@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Mark,

"Mark A. Greer" <mgreer@animalcreek.com> writes:

[...]

> To work around this issue, add platform data callbacks which
> are called at the beginning of the open routine and at the
> end of the stop routine of the davinci_emac driver.  The
> callbacks allow the platform code to issue disable_hlt() and
> enable_hlt() calls appropriately.  Calling disable_hlt()
> prevents cpu_idle from issuing the 'wfi' instruction.

OK, I'm feeling rather dumb for not thinking of this before and
suggesting that you use pdata callbacks.  But there is a better
solution: runtime PM.

I hadn't noticed before that since this driver comes from davinci, it
uses the clock API and not runtime PM which all OMAP drivers have been
(or are being) converted to.

If we replace the clock API usage in this driver with proper runtime PM
usage, we can make this work. Basically, clk_enable() turns into
pm_runtime_get_sync() and clk_disable() turns into pm_runtime_put().
With that, the OMAP PM core will get callbacks whenever the device is
[not] needed and we can use device-specific hooks to call
disable_hlt/enable_hlt.

The only catch though is that in order for this driver to be converted
to runtime PM and still work on davinci devices, the davinci kernel
needs to grow runtime PM support.   I belive Sekhar is already looking
into this, and OMAP1 (mach-omap1/pm_bus.c) will be a good example of how
to get a basic runtime PM implementation working for davinci which just
does basic clock management.

Having worked on the guts of runtime PM for OMAP, I know it pretty well
(which is all the more embarrasing that I didn't think of suggesting it
sooner.)  So, let me know how I can help.

As a quick hack to test my idea will help, you can try simply calling
disable_hlt() after clk_enable() and enable_hlt() after clk_disable() in
teh davinci_emac driver.  That will effectively be what happens after a
runtime PM conversion with device-specific hooks.  The (not even compile
tested) patch below does this.  For starters, can you tell me if this
results in "normal" performance on the EMAC?

Kevin


diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 174a334..c92bc28 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1909,6 +1909,7 @@ static int __devinit davinci_emac_probe(struct platform_device *pdev)
 	netif_napi_add(ndev, &priv->napi, emac_poll, EMAC_POLL_WEIGHT);
 
 	clk_enable(emac_clk);
+	disable_hlt();
 
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, &pdev->dev);
@@ -1929,6 +1930,7 @@ static int __devinit davinci_emac_probe(struct platform_device *pdev)
 
 netdev_reg_err:
 	clk_disable(emac_clk);
+	enable_hlt();
 no_irq_res:
 	if (priv->txchan)
 		cpdma_chan_destroy(priv->txchan);
@@ -1979,6 +1981,7 @@ static int __devexit davinci_emac_remove(struct platform_device *pdev)
 
 	clk_disable(emac_clk);
 	clk_put(emac_clk);
+	enable_hlt();
 
 	return 0;
 }
