From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v5] can: c_can: Add runtime PM support to Bosch
 C_CAN/D_CAN controller
Date: Wed, 8 Aug 2012 11:29:01 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA0D76B@DBDE01.ent.ti.com>
References: <1344338457-595-1-git-send-email-anilkumar@ti.com>
 <50210291.6020307@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <50210291.6020307@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Marc,

Thanks for the review

On Tue, Aug 07, 2012 at 17:27:05, Marc Kleine-Budde wrote:
> On 08/07/2012 01:20 PM, AnilKumar Ch wrote:
> > Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> > APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> > register of C_CAN/D_CAN IP when clock is turned off.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> > This patch has been tested on AM335X EVM. Due to lack of hardware
> > I am not able to test c_can functionality. I appreciate if anyone
> > can test c_can functionality with this patch.
> 
> The "priv->pdev->dev" will not work for c_can/d_can which are not using
> the platform driver. Options:
> a) priv->dev
>    add a struct device pointer to the priv, and
>    1) guard pm_runtime_get_sync() for priv->dev == NULL
>       (or check if pm_runtime_get_sync copes with NULL pointer)
> 
>    - or -

This is a better option but to implement this current priv->dev
needs to move to priv->ndev. Then we can add dev pointer to priv
struct.

> 
>    2) fill in the priv->dev in all other drivers (i.e. PCI)
>       and check if it makes sense/works to call it on PCI hardware
> 
> b) convert all other drivers, i.e. the PCI driver to create a
>    platform device
>
> Without thinking long, I suggest to a) with flavour 1)
> 
> Maybe there are better solutions.
> 
> Marc
> 
> More comments inline:
> 
> > 
> > This patch is based on "can-next/master" 
> > 
> > Changes from v4:
> > 	- Incorporated Vaibhav H review comments on v4.
> > 	  * Moved pm_runtime put/get_sync calls to appropriate positions.
> > 	- This patch is from "Add DT support to C_CAN/D_CAN controller"
> > 	  patch series. Rest of the patches in this series were applied
> > 	  so this v5 contains only this patch.
> > 
> >  drivers/net/can/c_can/c_can.c          |    8 ++++++++
> >  drivers/net/can/c_can/c_can.h          |    1 +
> >  drivers/net/can/c_can/c_can_platform.c |   11 +++++++++++
> >  3 files changed, 20 insertions(+)
> > 
> > diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> > index eea6608..ca1151d 100644
> > --- a/drivers/net/can/c_can/c_can.c
> > +++ b/drivers/net/can/c_can/c_can.c
> > @@ -34,6 +34,8 @@
> >  #include <linux/if_ether.h>
> >  #include <linux/list.h>
> >  #include <linux/io.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/platform_device.h>
> >  
> >  #include <linux/can.h>
> >  #include <linux/can/dev.h>
> > @@ -673,6 +675,8 @@ static int c_can_get_berr_counter(const struct net_device *dev,
> >  	unsigned int reg_err_counter;
> >  	struct c_can_priv *priv = netdev_priv(dev);
> >  
> > +	pm_runtime_get_sync(&priv->pdev->dev);
> > +
> 
> Why do you make a get_sync() here, where's the correspondning put_sync()?

While setting the bitrate, top layers checks the status of
C_CAN/D_CAN BERR register to know the bit status. I will take
care properly.

> 
> >  	reg_err_counter = priv->read_reg(priv, C_CAN_ERR_CNT_REG);
> >  	bec->rxerr = (reg_err_counter & ERR_CNT_REC_MASK) >>
> >  				ERR_CNT_REC_SHIFT;
> > @@ -1053,6 +1057,8 @@ static int c_can_open(struct net_device *dev)
> >  	int err;
> >  	struct c_can_priv *priv = netdev_priv(dev);
> >  
> > +	pm_runtime_get_sync(&priv->pdev->dev);
> > +
> >  	/* open the can device */
> >  	err = open_candev(dev);
> >  	if (err) {
> 
> What if open_candev() fails? Please add a jump label
> exit_open_candev_fail and add thje put_sync() there.

Missed, I will take care in return path

Regards
AnilKumar

