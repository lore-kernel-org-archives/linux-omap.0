From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] can: c_can: Move pm_runtime_enable/disable calls to
 common code
Date: Thu, 13 Sep 2012 08:25:53 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2E1C0@DBDE01.ent.ti.com>
References: <1347521292-28751-1-git-send-email-anilkumar@ti.com>
 <50518FB7.7090300@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <50518FB7.7090300@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Marc,

On Thu, Sep 13, 2012 at 13:18:07, Marc Kleine-Budde wrote:
> On 09/13/2012 09:28 AM, AnilKumar Ch wrote:
> > Move pm_runtime_enable/disable calls to c_can.c driver. Current
> > implementation is such that platform driver is doing pm_runtime
> > enable/disable and core driver is doing put_sync/get_sync.
> > 
> > PM runtime calls should be invoked if there is a valid device
> > pointer from platform driver so moving enable/disable calls
> > to core driver.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> > Incorporated Kevin's comments on "can: c_can: Add runtime PM
> > support to Bosch C_CAN/D_CAN controller" patch.
> > 
> > This patch is tested on AM335x-EVM and cleanly applies on
> > linux-can master
> 
> I'll squash this into "can: c_can: Add runtime PM support to Bosch
> C_CAN/D_CAN controller".
> > 
> >  drivers/net/can/c_can/c_can.c          |   18 +++++++++++++++++-
> >  drivers/net/can/c_can/c_can_platform.c |    5 -----
> >  2 files changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> > index aa6c5eb..e472975 100644
> > --- a/drivers/net/can/c_can/c_can.c
> > +++ b/drivers/net/can/c_can/c_can.c
> > @@ -1155,10 +1155,23 @@ static const struct net_device_ops c_can_netdev_ops = {
> >  
> >  int register_c_can_dev(struct net_device *dev)
> >  {
> > +	int ret;
> > +	struct c_can_priv *priv = netdev_priv(dev);
> > +
> > +	if (priv->device)
> > +		pm_runtime_enable(priv->device);
> 
> I'll add a static inline for these two new function, too.

My bad, this should be my first change.

> 
> > +
> >  	dev->flags |= IFF_ECHO;	/* we support local echo */
> >  	dev->netdev_ops = &c_can_netdev_ops;
> >  
> > -	return register_candev(dev);
> > +	ret = register_candev(dev);
> > +	if (ret) {
> > +		if (priv->device)
> > +			pm_runtime_disable(priv->device);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(register_c_can_dev);
> >  
> > @@ -1170,6 +1183,9 @@ void unregister_c_can_dev(struct net_device *dev)
> >  	c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
> >  
> >  	unregister_candev(dev);
> > +
> > +	if (priv->device)
> > +		pm_runtime_disable(priv->device);
> >  }
> >  EXPORT_SYMBOL_GPL(unregister_c_can_dev);
> >  
> > diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> > index c351975..491101a 100644
> > --- a/drivers/net/can/c_can/c_can_platform.c
> > +++ b/drivers/net/can/c_can/c_can_platform.c
> > @@ -32,7 +32,6 @@
> >  #include <linux/clk.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > -#include <linux/pm_runtime.h>
> >  #include <linux/pinctrl/consumer.h>
> >  
> >  #include <linux/can/dev.h>
> > @@ -185,8 +184,6 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> >  		goto exit_free_device;
> >  	}
> >  
> > -	pm_runtime_enable(&pdev->dev);
> > -
> >  	dev->irq = irq;
> >  	priv->base = addr;
> >  	priv->device = &pdev->dev;
> > @@ -209,7 +206,6 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> >  
> >  exit_clear_drvdata:
> >  	platform_set_drvdata(pdev, NULL);
> > -	pm_runtime_disable(&pdev->dev);
> 
> When squaahsing both patches we see still some changes here, I'll fix
> that, too.

Thanks Marc

Thanks
AnilKumar
