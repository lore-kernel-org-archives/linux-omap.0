From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v9] can: c_can: Add runtime PM support to Bosch
 C_CAN/D_CAN controller
Date: Fri, 7 Sep 2012 03:28:05 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2921A@DBDE01.ent.ti.com>
References: <1345461654-439-1-git-send-email-anilkumar@ti.com>
 <878vcmhgdn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <878vcmhgdn.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

On Fri, Sep 07, 2012 at 05:07:56, Kevin Hilman wrote:
> AnilKumar Ch <anilkumar@ti.com> writes:
> 
> > Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> > APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> > register of C_CAN/D_CAN IP when clock is turned off.
> >
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> I'm not familar with the CAN specifics here, but some comments on the
> runtime PM implementation.

Thanks for the comments.

> 
> > ---
> > This patch has been tested on AM335X EVM. Due to lack of hardware
> > I am not able to test c_can functionality. I appreciate if anyone
> > can test c_can functionality with this patch.
> >
> > This patch is based on "can-next/master" 
> >
> > Changes from v8:
> > 	- corrected the return path sequence in c_can_probe()
> >
> > Changes from v7:
> > 	- Incorporated Marc's comments on v7
> > 	  * changed device pointer to c_can_priv pointer
> >
> > Changes from v6:
> > 	- Incorporated Marc's comments on v6
> > 	  * changed dev pointer to priv
> > 	  * removed platform_device.h include from c_can.c
> >
> > Changes from v5:
> > 	- Incorporated Marc's comments on v5
> > 	  * changed runtime pm calls in c_can driver to handle
> > 	    the drivers which are not using platform drivers.
> > 	  * added device pointer protection in c_can driver if
> > 	    not passed from platform/pci driver.
> >
> > Changes from v4:
> > 	- Incorporated Vaibhav H review comments on v4.
> > 	  * Moved pm_runtime put/get_sync calls to appropriate positions.
> > 	- This patch is from "Add DT support to C_CAN/D_CAN controller"
> > 	  patch series. Rest of the patches in this series were applied
> > 	  so this v5 contains only this patch.
> >
> >  drivers/net/can/c_can/c_can.c          |   24 +++++++++++++++++++++++-
> >  drivers/net/can/c_can/c_can.h          |    1 +
> >  drivers/net/can/c_can/c_can_platform.c |   11 +++++++++--
> >  3 files changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> > index 4c538e3..966d318 100644
> > --- a/drivers/net/can/c_can/c_can.c
> > +++ b/drivers/net/can/c_can/c_can.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/if_ether.h>
> >  #include <linux/list.h>
> >  #include <linux/io.h>
> > +#include <linux/pm_runtime.h>
> >  
> >  #include <linux/can.h>
> >  #include <linux/can/dev.h>
> > @@ -201,6 +202,18 @@ static const struct can_bittiming_const c_can_bittiming_const = {
> >  	.brp_inc = 1,
> >  };
> >  
> > +static inline void c_can_pm_runtime_get_sync(struct c_can_priv *priv)
> > +{
> > +	if (priv->device)
> > +		pm_runtime_get_sync(priv->device);
> > +}
> > +
> > +static inline void c_can_pm_runtime_put_sync(struct c_can_priv *priv)
> > +{
> > +	if (priv->device)
> > +		pm_runtime_put_sync(priv->device);
> > +}
> 
> IMO, these extra helpers are rather unsightly, and should not be needed.
> The driver should just be directly doing get_sync/put_sync.  If
> priv->device isn't presnt, then runtime PM should just never be enabled.
> 

In case of c_can driver we have two drivers one is generic c_can.c driver,
provides the basic functionality of CAN. Another two drivers c_can_platform.c
and c_can_pci.c, which uses core c_can.c driver by exporting some platform
specific ops like read/write.

priv->device pointer is passed from c_can_platform.c by this means
"priv->device = &pdev->dev;" (see below) but not for c_can_pci.c

The purpose of check here is for *_pci.c driver which do not have runtime pm
implemented yet so we should do and get_sync/put_sync. In case of *_pci.c
driver there is no pm_runtime_enable/disable once that is implemented then
this check will be removed.

Thanks
AnilKumar

> 
> >  static inline int get_tx_next_msg_obj(const struct c_can_priv *priv)
> >  {
> >  	return (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) +
> > @@ -673,11 +686,15 @@ static int c_can_get_berr_counter(const struct net_device *dev,
> >  	unsigned int reg_err_counter;
> >  	struct c_can_priv *priv = netdev_priv(dev);
> >  
> > +	c_can_pm_runtime_get_sync(priv);
> > +
> >  	reg_err_counter = priv->read_reg(priv, C_CAN_ERR_CNT_REG);
> >  	bec->rxerr = (reg_err_counter & ERR_CNT_REC_MASK) >>
> >  				ERR_CNT_REC_SHIFT;
> >  	bec->txerr = reg_err_counter & ERR_CNT_TEC_MASK;
> >  
> > +	c_can_pm_runtime_put_sync(priv);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -1053,11 +1070,13 @@ static int c_can_open(struct net_device *dev)
> >  	int err;
> >  	struct c_can_priv *priv = netdev_priv(dev);
> >  
> > +	c_can_pm_runtime_get_sync(priv);
> > +
> >  	/* open the can device */
> >  	err = open_candev(dev);
> >  	if (err) {
> >  		netdev_err(dev, "failed to open can device\n");
> > -		return err;
> > +		goto exit_open_fail;
> >  	}
> >  
> >  	/* register interrupt handler */
> > @@ -1079,6 +1098,8 @@ static int c_can_open(struct net_device *dev)
> >  
> >  exit_irq_fail:
> >  	close_candev(dev);
> > +exit_open_fail:
> > +	c_can_pm_runtime_put_sync(priv);
> >  	return err;
> >  }
> >  
> > @@ -1091,6 +1112,7 @@ static int c_can_close(struct net_device *dev)
> >  	c_can_stop(dev);
> >  	free_irq(dev->irq, dev);
> >  	close_candev(dev);
> > +	c_can_pm_runtime_put_sync(priv);
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
> > index 4e56baa..1437a6d 100644
> > --- a/drivers/net/can/c_can/c_can.h
> > +++ b/drivers/net/can/c_can/c_can.h
> > @@ -153,6 +153,7 @@ struct c_can_priv {
> >  	struct can_priv can;	/* must be the first member */
> >  	struct napi_struct napi;
> >  	struct net_device *dev;
> > +	struct device *device;
> >  	int tx_object;
> >  	int current_status;
> >  	int last_status;
> > diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> > index d0a66cf..90801c4 100644
> > --- a/drivers/net/can/c_can/c_can_platform.c
> > +++ b/drivers/net/can/c_can/c_can_platform.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/pm_runtime.h>
> >  
> >  #include <linux/can/dev.h>
> >  
> > @@ -177,8 +178,11 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> >  		goto exit_free_device;
> >  	}
> >  
> > +	pm_runtime_enable(&pdev->dev);
> > +
> >  	dev->irq = irq;
> >  	priv->base = addr;
> > +	priv->device = &pdev->dev;
> >  	priv->can.clock.freq = clk_get_rate(clk);
> >  	priv->priv = clk;
> >  
> > @@ -189,15 +193,17 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
> >  			KBUILD_MODNAME, ret);
> > -		goto exit_free_device;
> > +		goto exit_clear_drvdata;
> >  	}
> >  
> >  	dev_info(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
> >  		 KBUILD_MODNAME, priv->base, dev->irq);
> >  	return 0;
> >  
> > -exit_free_device:
> > +exit_clear_drvdata:
> >  	platform_set_drvdata(pdev, NULL);
> > +	pm_runtime_disable(&pdev->dev);
> > +exit_free_device:
> >  	free_c_can_dev(dev);
> >  exit_iounmap:
> >  	iounmap(addr);
> > @@ -226,6 +232,7 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
> >  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	release_mem_region(mem->start, resource_size(mem));
> >  
> > +	pm_runtime_disable(&pdev->dev);
> >  	clk_put(priv->priv);
> >  
> >  	return 0;
> 

