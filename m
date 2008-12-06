From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Bug in linux omap clock framework?
Date: Sat, 6 Dec 2008 16:51:39 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50029 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbYLFXvl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Dec 2008 18:51:41 -0500
In-Reply-To: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi Tomi,

nice test case.

On Fri, 5 Dec 2008, Tomi.Valkeinen@nokia.com wrote:

> I have had strange clk_enable() crashes with DSS2, and now I managed to
> isolate it. With the included patch, on OMAP3 SDP board, with default
> kernel config, I always get the crash below. In this example case it
> happens at specific time on boot, but with DSS2 it happens randomly at
> runtime, when I enable the DSS clocks.

Looks like there's some problem with the DSS driver's usage of 
dss_tv_fclk.  Enabling dss_tv_fclk before entering your test code's 
while-loop makes the problem go away here.  Patch below.

As an aside, your test patch does not actually disable dss1_fclk, since it 
is already enabled by the time the while-loop starts.  So you might also 
want to add a clk_disable(c2) before your while-loop starts, when you 
test.

Based on the traceback that you sent, I'd conjecture that probably some 
part of the DSS subsystem is generating an interrupt via DSS_IRQ; but then 
dss_iclk ends up disabled, and the MPU INTC is not able to communicate 
with the DSS, and the INTC wedges.  (The aborting access is to 0xd8200098, 
the INTCPS_PENDING_IRQ0 register, rather than a DSS register.)  Probably 
some IRQs need to be masked before disabling the dss_iclk.


- Paul



 drivers/video/omap/omapfb_main.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index a77e3bf..57b9e98 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1808,9 +1808,11 @@ static int omapfb_probe(struct platform_device *pdev)
 	BUG_ON(fbdev_pdev != NULL);
 
 	{
-		struct clk *c1, *c2;
+		struct clk *c1, *c2, *c3;
 		c1 = clk_get(&pdev->dev, "dss_ick");
 		c2 = clk_get(&pdev->dev, "dss1_fck");
+		c3 = clk_get(&pdev->dev, "dss_tv_fck");
+ 		clk_enable(c3);
 		while(1) {
 			clk_enable(c1);
 			clk_enable(c2);
