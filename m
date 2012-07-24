From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: am3517: USB state in 3.5-rc6
Date: Tue, 24 Jul 2012 17:30:05 +0200
Message-ID: <1343143805.834.3.camel@coredoba.hi.pengutronix.de>
References: <500CF852.4020005@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46723 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab2GXPaH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 11:30:07 -0400
In-Reply-To: <500CF852.4020005@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegor_sub1@visionsystems.de
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mark A. Greer" <mgreer@animalcreek.com>, "Porter, Matt" <mporter@ti.com>

Hi,

On Mon, 2012-07-23 at 09:08 +0200, Yegor Yefremov wrote:
> After getting MMC working I now have following issues: both musb and EHCI make problems.
> 
> musb:
> 
> musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
> musb-am35x musb-am35x: failed to get clock
> musb-am35x: probe of musb-am35x failed with error -2  

I've seen the same problem after merging omap-devel-d-for-3.6 onto v3.5.
(see http://git.kernel.org/?p=linux/kernel/git/pjw/omap-pending.git;a=tag;h=refs/tags/omap-devel-d-for-3.6)

So far I've worked around it like this (I'm not sure this is the correct
approach, but it works):

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 9f3eda9..2184693 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -480,14 +480,14 @@ static int __devinit am35x_probe(struct platform_device *pdev)
                goto err1;
        }
 
-       phy_clk = clk_get(&pdev->dev, "fck");
+       phy_clk = clk_get(&pdev->dev, "hsotgusb_ick");
        if (IS_ERR(phy_clk)) {
                dev_err(&pdev->dev, "failed to get PHY clock\n");
                ret = PTR_ERR(phy_clk);
                goto err2;
        }
 
-       clk = clk_get(&pdev->dev, "ick");
+       clk = clk_get(&pdev->dev, "hsotgusb_fck");
        if (IS_ERR(clk)) {
                dev_err(&pdev->dev, "failed to get clock\n");
                ret = PTR_ERR(clk);


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

