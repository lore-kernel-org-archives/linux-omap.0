From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v9] can: c_can: Add runtime PM support to Bosch
 C_CAN/D_CAN controller
Date: Mon, 10 Sep 2012 10:44:12 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2BA55@DBDE01.ent.ti.com>
References: <1345461654-439-1-git-send-email-anilkumar@ti.com>
	<878vcmhgdn.fsf@deeprootsystems.com>
	<331ABD5ECB02734CA317220B2BBEABC13EA2921A@DBDE01.ent.ti.com>
 <87ipbpmtst.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55558 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756452Ab2IJKo2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 06:44:28 -0400
In-Reply-To: <87ipbpmtst.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Hi Kevin,

On Sat, Sep 08, 2012 at 02:31:22, Kevin Hilman wrote:
> "AnilKumar, Chimata" <anilkumar@ti.com> writes:
> 
> > Hi Kevin,
> >
> > On Fri, Sep 07, 2012 at 05:07:56, Kevin Hilman wrote:
> >> AnilKumar Ch <anilkumar@ti.com> writes:
> >> 
> >> > Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> >> > APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> >> > register of C_CAN/D_CAN IP when clock is turned off.
> >> >
> >> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> >> 
> >> I'm not familar with the CAN specifics here, but some comments on the
> >> runtime PM implementation.
> >
> > Thanks for the comments.
> >
> >> 
> >> > ---
> >> > This patch has been tested on AM335X EVM. Due to lack of hardware
> >> > I am not able to test c_can functionality. I appreciate if anyone
> >> > can test c_can functionality with this patch.
> >> >
> >> > This patch is based on "can-next/master" 
> >> >
> >> > Changes from v8:
> >> > 	- corrected the return path sequence in c_can_probe()
> >> >
> >> > Changes from v7:
> >> > 	- Incorporated Marc's comments on v7
> >> > 	  * changed device pointer to c_can_priv pointer
> >> >
> >> > Changes from v6:
> >> > 	- Incorporated Marc's comments on v6
> >> > 	  * changed dev pointer to priv
> >> > 	  * removed platform_device.h include from c_can.c
> >> >
> >> > Changes from v5:
> >> > 	- Incorporated Marc's comments on v5
> >> > 	  * changed runtime pm calls in c_can driver to handle
> >> > 	    the drivers which are not using platform drivers.
> >> > 	  * added device pointer protection in c_can driver if
> >> > 	    not passed from platform/pci driver.
> >> >
> >> > Changes from v4:
> >> > 	- Incorporated Vaibhav H review comments on v4.
> >> > 	  * Moved pm_runtime put/get_sync calls to appropriate positions.
> >> > 	- This patch is from "Add DT support to C_CAN/D_CAN controller"
> >> > 	  patch series. Rest of the patches in this series were applied
> >> > 	  so this v5 contains only this patch.
> >> >
> >> >  drivers/net/can/c_can/c_can.c          |   24 +++++++++++++++++++++++-
> >> >  drivers/net/can/c_can/c_can.h          |    1 +
> >> >  drivers/net/can/c_can/c_can_platform.c |   11 +++++++++--
> >> >  3 files changed, 33 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> >> > index 4c538e3..966d318 100644
> >> > --- a/drivers/net/can/c_can/c_can.c
> >> > +++ b/drivers/net/can/c_can/c_can.c
> >> > @@ -34,6 +34,7 @@
> >> >  #include <linux/if_ether.h>
> >> >  #include <linux/list.h>
> >> >  #include <linux/io.h>
> >> > +#include <linux/pm_runtime.h>
> >> >  
> >> >  #include <linux/can.h>
> >> >  #include <linux/can/dev.h>
> >> > @@ -201,6 +202,18 @@ static const struct can_bittiming_const c_can_bittiming_const = {
> >> >  	.brp_inc = 1,
> >> >  };
> >> >  
> >> > +static inline void c_can_pm_runtime_get_sync(struct c_can_priv *priv)
> >> > +{
> >> > +	if (priv->device)
> >> > +		pm_runtime_get_sync(priv->device);
> >> > +}
> >> > +
> >> > +static inline void c_can_pm_runtime_put_sync(struct c_can_priv *priv)
> >> > +{
> >> > +	if (priv->device)
> >> > +		pm_runtime_put_sync(priv->device);
> >> > +}
> >> 
> >> IMO, these extra helpers are rather unsightly, and should not be needed.
> >> The driver should just be directly doing get_sync/put_sync.  If
> >> priv->device isn't presnt, then runtime PM should just never be enabled.
> >> 
> >
> > In case of c_can driver we have two drivers one is generic c_can.c driver,
> > provides the basic functionality of CAN. Another two drivers c_can_platform.c
> > and c_can_pci.c, which uses core c_can.c driver by exporting some platform
> > specific ops like read/write.
> >
> > priv->device pointer is passed from c_can_platform.c by this means
> > "priv->device = &pdev->dev;" (see below) but not for c_can_pci.c
> >
> > The purpose of check here is for *_pci.c driver which do not have runtime pm
> > implemented yet so we should do and get_sync/put_sync. In case of *_pci.c
> > driver there is no pm_runtime_enable/disable once that is implemented then
> > this check will be removed.
> 
> Then you should probably move the pm_runtime_enable/disable into the
> common code (where the get_sync/put_sync) are.  Then you could simply 
> avoid the pm_runtime_enable() if there is no priv->device.
> 

Thanks for the comments

I got your point, will move pm_runtime_enable/disable to common code.

Thanks
AnilKumar
