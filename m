From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v8] can: c_can: Add runtime PM support to Bosch
 C_CAN/D_CAN controller
Date: Mon, 20 Aug 2012 11:03:41 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA19F1B@DBDE01.ent.ti.com>
References: <1345452359-1137-1-git-send-email-anilkumar@ti.com>
 <5032144C.2090007@pengutronix.de> <50321831.1070106@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <50321831.1070106@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 20, 2012 at 16:27:53, Marc Kleine-Budde wrote:
> On 08/20/2012 12:41 PM, Marc Kleine-Budde wrote:
> > On 08/20/2012 10:45 AM, AnilKumar Ch wrote:
> >> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> >> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> >> register of C_CAN/D_CAN IP when clock is turned off.
> >>
> >> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> >> ---
> >> This patch has been tested on AM335X EVM. Due to lack of hardware
> >> I am not able to test c_can functionality. I appreciate if anyone
> >> can test c_can functionality with this patch.
> >>
> >> This patch is based on "can-next/master" 
> >>
> >> Changes from v7:
> >> 	- Incorporated Marc's commets on v7
> >> 	  * changed device pointer to c_can_priv pointer
> > 
> > looks good.
> > 
> > [...]
> > 
> >> --- a/drivers/net/can/c_can/c_can_platform.c
> >> +++ b/drivers/net/can/c_can/c_can_platform.c
> >> @@ -32,6 +32,7 @@
> >>  #include <linux/clk.h>
> >>  #include <linux/of.h>
> >>  #include <linux/of_device.h>
> >> +#include <linux/pm_runtime.h>
> >>  
> >>  #include <linux/can/dev.h>
> >>  
> >> @@ -177,8 +178,11 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> >>  		goto exit_free_device;
> >                      ^^^^^^^^^^^^^^^^
> >>  	}
> >>  
> >> +	pm_runtime_enable(&pdev->dev);
> >> +
> >>  	dev->irq = irq;
> >>  	priv->base = addr;
> >> +	priv->device = &pdev->dev;
> >>  	priv->can.clock.freq = clk_get_rate(clk);
> >>  	priv->priv = clk;
> >>  
> >> @@ -198,6 +202,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> >>  
> >>  exit_free_device:
> >>  	platform_set_drvdata(pdev, NULL);
> >> +	pm_runtime_disable(&pdev->dev);
> > 
> > I think this will end up in a NULL pointer deferf.
> 
> Should be no problem, as you're using pdev->dev not priv->device.
> 
> Sorry for the noise :)
> 

One more catch here, return path is not proper.

exit_free_device: should contain only free_c_can_dev(dev); 

Regards
AnilKumar
