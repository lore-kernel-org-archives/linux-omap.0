From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 5/8] pwm: pwm-tiehrpwm: Add device-tree binding support
 for EHRPWM driver
Date: Wed, 7 Nov 2012 15:20:28 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9DE3A5@DBDE01.ent.ti.com>
References: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
 <1352106749-9437-6-git-send-email-avinashphilip@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC0447E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC0447E-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Bedia, Vaibhav" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 06, 2012 at 12:16:13, Bedia, Vaibhav wrote:
> On Mon, Nov 05, 2012 at 14:42:26, Philip, Avinash wrote:
> [...]
> 	
> > +#include <linux/of_device.h>
> > +#include <linux/pinctrl/consumer.h>
> 
> Pinctrl changes should be separate patch. Morevoer, you don't mention
> that you making this change.

Ok. I will make a separate patch for pinctrl changes.

> 
> > +
> > +#include "tipwmss.h"
> >  
> >  /* EHRPWM registers and bits definitions */
> >  
> > @@ -107,6 +111,10 @@
> >  #define AQCSFRC_CSFA_FRCHIGH	BIT(1)
> >  #define AQCSFRC_CSFA_DISSWFRC	(BIT(1) | BIT(0))
> >  
> > +#define EPWMCLK_EN_SHIFT	8
> > +
> > +#define PWM_CELL_SIZE		3
> > +
> >  #define NUM_PWM_CHANNEL		2	/* EHRPWM channels */
> >  
> >  struct ehrpwm_pwm_chip {
> > @@ -392,12 +400,27 @@ static const struct pwm_ops ehrpwm_pwm_ops = {
> >  	.owner		= THIS_MODULE,
> >  };
> >  
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id ehrpwm_of_match[] = {
> > +	{
> > +		.compatible	= "ti,am33xx-ehrpwm",
> > +	},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, ehrpwm_of_match);
> > +#endif
> > +
> >  static int __devinit ehrpwm_pwm_probe(struct platform_device *pdev)
> >  {
> >  	int ret;
> >  	struct resource *r;
> >  	struct clk *clk;
> >  	struct ehrpwm_pwm_chip *pc;
> > +	struct pinctrl *pinctrl;
> > +
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> 
> I didn't see a patch adding the pinctrl entries.

Patch 8/8 has pinctrl entries in DT. First driver changes for supporting
DT data. 

> 
> > +	if (IS_ERR(pinctrl))
> > +		dev_warn(&pdev->dev, "failed to configure pins from driver\n");
> >  
> >  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> >  	if (!pc) {
> > @@ -419,6 +442,7 @@ static int __devinit ehrpwm_pwm_probe(struct platform_device *pdev)
> >  
> >  	pc->chip.dev = &pdev->dev;
> >  	pc->chip.ops = &ehrpwm_pwm_ops;
> > +	pc->chip.of_pwm_n_cells = PWM_CELL_SIZE;
> >  	pc->chip.base = -1;
> >  	pc->chip.npwm = NUM_PWM_CHANNEL;
> >  
> > @@ -437,8 +461,11 @@ static int __devinit ehrpwm_pwm_probe(struct platform_device *pdev)
> >  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> >  		return ret;
> >  	}
> > -
> >  	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_get_sync(&pdev->dev);
> > +	pwmss_submodule_state_change(pdev->dev.parent, EPWMCLK_EN_SHIFT, true);
> 
> I think you should modify this API to return the status for drivers to check.

Check for status check will add.

> 
> Another related question, why should this clock be enabled in probe and not only when it
> is required?

This is another clock gating from PWM subsystem as all sub modules shared the clock resource.
Still this gating from PWM subsystem is required to access PWM sub modules.
Handling of this for context loss & restore done at pwmss driver, will add the support.

> Shouldn't it be disabled in suspend?

Will take care when adding suspend/resume functionality.

Thanks
Avinash

> 
> Regards,
> Vaibhav
> 
