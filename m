From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 1/4] can: c_can: Adopt pinctrl support
Date: Tue, 4 Sep 2012 06:14:30 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2630A@DBDE01.ent.ti.com>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com>
 <1346673139-14540-2-git-send-email-anilkumar@ti.com>
 <5045161C.4000100@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <5045161C.4000100@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "tony@atomide.com" <tony@atomide.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Marc,

On Tue, Sep 04, 2012 at 02:12:04, Marc Kleine-Budde wrote:
> On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
> > Adopt pinctrl support to c_can driver based on c_can device
> > pointer, pinctrl driver configure SoC pins to d_can mode
> > according to definitions provided in .dts file.
> > 
> > In device specific device tree file 'pinctrl-names = "default";'
> > and 'pinctrl-0 = <&d_can1_pins>;' needs to add to configure pins
> > from c_can driver. d_can1_pins node contains the pinmux/config
> > details of d_can L/H pins.
> 
> Looks good, is the pinctrl property documented in the dt bindings already?
> 

Yes, its here Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt

Thanks
AnilKumar

> 
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  drivers/net/can/c_can/c_can_platform.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> > index 90801c4..c351975 100644
> > --- a/drivers/net/can/c_can/c_can_platform.c
> > +++ b/drivers/net/can/c_can/c_can_platform.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/pinctrl/consumer.h>
> >  
> >  #include <linux/can/dev.h>
> >  
> > @@ -98,6 +99,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> >  	struct c_can_priv *priv;
> >  	const struct of_device_id *match;
> >  	const struct platform_device_id *id;
> > +	struct pinctrl *pinctrl;
> >  	struct resource *mem;
> >  	int irq;
> >  	struct clk *clk;
> > @@ -114,6 +116,11 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> >  		id = platform_get_device_id(pdev);
> >  	}
> >  
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> > +	if (IS_ERR(pinctrl))
> > +		dev_warn(&pdev->dev,
> > +			"failed to configure pins from driver\n");
> > +
> >  	/* get the appropriate clk */
> >  	clk = clk_get(&pdev->dev, NULL);
> >  	if (IS_ERR(clk)) {
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

