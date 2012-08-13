From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v6] can: c_can: Add runtime PM support to Bosch
 C_CAN/D_CAN controller
Date: Mon, 13 Aug 2012 13:59:31 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA11B0C@DBDE01.ent.ti.com>
References: <1344840599-19545-1-git-send-email-anilkumar@ti.com>
 <5028EEAE.6090402@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37716 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab2HMN7q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Aug 2012 09:59:46 -0400
In-Reply-To: <5028EEAE.6090402@pengutronix.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Hi Marc,

Thanks for the review.

On Mon, Aug 13, 2012 at 17:40:22, Marc Kleine-Budde wrote:
> On 08/13/2012 08:49 AM, AnilKumar Ch wrote:
> > Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> > APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> > register of C_CAN/D_CAN IP when clock is turned off.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> Looks good, minor style suggestion inline.
> 
> Marc
> 
> > ---
> > This patch has been tested on AM335X EVM. Due to lack of hardware
> > I am not able to test c_can functionality. I appreciate if anyone
> > can test c_can functionality with this patch.
> > 
> > This patch is based on "can-next/master" 
> > 
> > Changes from v5:
> > 	- Incorporated Marc's commets on v5
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
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  drivers/net/can/c_can/c_can.c          |   25 ++++++++++++++++++++++++-
> >  drivers/net/can/c_can/c_can.h          |    1 +
> >  drivers/net/can/c_can/c_can_platform.c |    6 ++++++
> >  3 files changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> > index 4c538e3..64344b8 100644
> > --- a/drivers/net/can/c_can/c_can.c
> > +++ b/drivers/net/can/c_can/c_can.c
> > @@ -34,6 +34,8 @@
> >  #include <linux/if_ether.h>
> >  #include <linux/list.h>
> >  #include <linux/io.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/platform_device.h>
>             ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Is this still needed?

Not required, missed out while cleaning and now it's removed.

> 
> >  
> >  #include <linux/can.h>
> >  #include <linux/can/dev.h>
> > @@ -201,6 +203,18 @@ static const struct can_bittiming_const c_can_bittiming_const = {
> >  	.brp_inc = 1,
> >  };
> >  
> > +static inline void c_can_pm_runtime_get_sync(struct device *dev)
> 
> Use priv as parameter, not dev.

done

> 
> > +{
> > +	if (dev)
> > +		pm_runtime_get_sync(dev);
> > +}
> > +
> > +static inline void c_can_pm_runtime_put_sync(struct device *dev)
> 
> ditto

done, I will send updated version.

Thanks
AnilKumar
