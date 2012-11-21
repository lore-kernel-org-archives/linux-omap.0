From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2] can: c_can: Add d_can raminit support
Date: Wed, 21 Nov 2012 08:58:03 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA77D25@DBDE01.ent.ti.com>
References: <1353476650-24398-1-git-send-email-anilkumar@ti.com>
 <50AC9578.4030505@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <50AC9578.4030505@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 21, 2012 at 14:18:56, Marc Kleine-Budde wrote:
> On 11/21/2012 06:44 AM, AnilKumar Ch wrote:
> > Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM,
> > which holds all the message objects during transmission or
> > receiving of data. This initialization/de-initialization should
> > be done in synchronous with D_CAN clock.
> > 
> > In case of AM335X-EVM (current user of D_CAN driver) message RAM is
> > controlled through control module register for both instances. So
> > control module register details is required to initialization or
> > de-initialization of message RAM according to instance number.
> > 
> > Control module memory resource is obtained from D_CAN dt node and
> > instance number obtained from device tree aliases node.
> > 
> > This patch was tested on AM335x-EVM along with pinctrl data addition
> > patch, d_can dt aliases addition and control module data addition.
> > pinctrl data addition is not added to am335x-evm.dts (only supports
> > CPLD profile#0) because d_can1 is supported under CPLD profile#1.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> 
> [...]
> 
> > @@ -178,6 +195,20 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> >  		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
> >  		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
> >  		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
> > +
> > +		if (pdev->dev.of_node)
> > +			priv->instance = pdev->id < 0 ?
> > +				of_alias_get_id(pdev->dev.of_node, "d_can") :
> > +				pdev->id;
> 
> This wouldn't work with non DT kernels, what about:
> 
> if (pdev->dev.of_node)
> 	priv->instance = of_alias_get_id(pdev->dev.of_node, "d_can");
> else
> 	priv->instance = pdev->id;
> 

I completely forgot this case, yes this is the correct way of doing it.

Thanks
AnilKumar

> > +
> > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +		priv->raminit_ctrlreg =
> > +				devm_request_and_ioremap(&pdev->dev, res);
> > +		if (!priv->raminit_ctrlreg || priv->instance < 0) {
> > +			dev_info(&pdev->dev, "control memory is not used for raminit\n");
> > +			break;
> > +		}
> > +		priv->ram_init = c_can_hw_raminit;
> >  		break;
> >  	default:
> >  		ret = -EINVAL;
> > 
> 
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
> 

