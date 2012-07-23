From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH 1/2] PWM: ECAP: PWM driver support for ECAP APWM.
Date: Mon, 23 Jul 2012 09:10:09 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E971530@DBDE01.ent.ti.com>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-2-git-send-email-avinashphilip@ti.com>
 <20120723065235.GA23797@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37286 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab2GWJLU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jul 2012 05:11:20 -0400
In-Reply-To: <20120723065235.GA23797@avionic-0098.mockup.avionic-design.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jul 23, 2012 at 12:22:35, Thierry Reding wrote:
> On Fri, Jul 13, 2012 at 03:05:01PM +0530, Philip, Avinash wrote:
[snip]
> >  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
> > +obj-$(CONFIG_PWM_ECAP)		+= pwm-ecap.o
> 
> Both the Kconfig and Makefile should have the entries ordered
> alphabetically.

Ok. I will correct it.

> 
[snip]
> > +/* ECAP registers and bits definitions */
> > +#define TSCTR			0x00
> > +#define CTRPHS			0x04
> > +#define CAP1			0x08
> > +#define CAP2			0x0C
> > +#define CAP3			0x10
> > +#define CAP4			0x14
> > +#define ECCTL1			0x28
> 
> These registers are not used. I guess there is some use to list all
> registers here but on the other hand the majority are unused so they
> just clutter the driver.


> 
> > +#define ECCTL2_APWM_POL_LOW	BIT(10)
> 
> This bit is never used.

> 
> > +#define ECEINT			0x2C
> > +#define ECFLG			0x2E
> > +#define ECCLR			0x30
> > +#define REVID			0x5c
> 
> These are unused as well.

Ok. I will remove it. These are been placed in future enhancement.

> 
> > +
> > +#define DRIVER_NAME	"ecap"
> 
> You only use this once when defining the struct platform_driver, so
> maybe you can just drop it.

In the v2 patch, I am planning to use same in
platform_get_resource_byname(). Here I will use this define to search
resources.

> 
> > +
> > +struct ecap_pwm_chip {
> > +	struct pwm_chip	chip;
> > +	unsigned int	clk_rate;
> > +	void __iomem	*mmio_base;
> > +	int		pwm_period_ns;
> > +	int		pwm_duty_ns;
> > +};
> 
> The pwm_period_ns and pwm_duty_ns don't seem to be used at all. Can they
> be dropped?

Ok. I will remove it. 

> 
> > +	/*
> > +	 * Enable 'Free run Time stamp counter mode' to start counter
> > +	 * and  'APWM mode' to enable APWM output
> > +	 */
> > +	reg_val = readw(pc->mmio_base + ECCTL2);
> > +	reg_val |= ECCTL2_TSCTR_FREERUN | ECCTL2_APWM_MODE;
> 
> You already set the APWM_MODE bit in .config(), why is it needed here
> again? Seeing that .disable() clears the bit as well, perhaps leaving it
> clear in .config() is the better option.

Clearing APWM mode in .disable() ensures PWM low output (i.e., PWM pin = low 
in idle state).

The Period & Compare registers are updated from Shadow registers (CAP1 & CAP2)
During PWM configuration. To enable loading from Shadow registers, APWM mode 
should be set.
The same is done in .config().


> 
> > +}
> > +
> > +static void ecap_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
> > +		dev_warn(chip->dev, "Removing PWM device without disabling\n");
> > +		pm_runtime_put_sync(chip->dev);
> > +	}
> > +}
> 
> I wonder whether we want to have something like this in the PWM core at
> some point. Maybe we should call .disable() automatically when they are
> freed, or alternatively return -EBUSY if a PWM is freed but still
> enabled. I think I prefer the latter. For now we can leave this in,
> because I don't want to make any such core changes for 3.6 now that the
> merge window is open.

OK Thanks.

> 
> > +
> > +static struct pwm_ops ecap_pwm_ops = {
> > +	.free		= ecap_pwm_free,
> > +	.config		= ecap_pwm_config,
> > +	.enable		= ecap_pwm_enable,
> > +	.disable	= ecap_pwm_disable,
> > +	.owner		= THIS_MODULE,
> > +};
> 
> This should be "static const pwm_ops ...".

Ok I will correct it.

> 
> > +
> > +static int __devinit ecap_pwm_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct resource *r;
> > +	struct clk *clk;
> > +	struct ecap_pwm_chip *pc;
> > +
> > +	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> > +	if (!pc) {
> > +		dev_err(&pdev->dev, "failed to allocate memory\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	clk = devm_clk_get(&pdev->dev, "fck");
> > +	if (IS_ERR(clk)) {
> > +		dev_err(&pdev->dev, "failed to get clock\n");
> > +		return PTR_ERR(clk);
> > +	}
> > +
> > +	pc->clk_rate = clk_get_rate(clk);
> > +	if (!pc->clk_rate) {
> > +		dev_err(&pdev->dev, "failed to get clock rate\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	pc->chip.dev = &pdev->dev;
> > +	pc->chip.ops = &ecap_pwm_ops;
> > +	pc->chip.base = -1;
> > +	pc->chip.npwm = 1;
> 
> The cover letter mentions that the AM335x has 3 instances of the ECAP.
> Is there any chance that they can be unified in one driver instance
> (i.e. .npwm = 3?).

No. All instances have separate resources (clocks, memory ..).

> 
> > +
> > +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecap_reg");
> > +	if (r == NULL) {
> 
> You use "if (!ptr)" everywhere else, maybe you should make this
> consistent?
Ok
> Also the platform_get_resource_byname() is really only
> useful for devices that have several register regions associated with
> them. I don't know your hardware in detail, but I doubt that a PWM
> device has more than one register region.

In fact PWM Module has 4 different register space (eCAP, eHRPWM, eQEP & 
Common Config space). So I need to use platform_get_resource_byname()

> 
> > +		dev_err(&pdev->dev, "no memory resource defined\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	pc->mmio_base = devm_request_and_ioremap(&pdev->dev, r);
> > +	if (!pc->mmio_base) {
> > +		dev_err(&pdev->dev, "failed to ioremap() registers\n");
> > +		return -EADDRNOTAVAIL;
> > +	}
> > +
> > +	ret = pwmchip_add(&pc->chip);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	pm_runtime_enable(&pdev->dev);
> > +	platform_set_drvdata(pdev, pc);
> > +	dev_info(&pdev->dev, "PWM device initialized\n");
> 
> I think this can go away. If none of the above errors is shown you can
> just assume that the PWM was initialized.

Ok. I will remove.

> 
> > +	return 0;
> > +}
> > +
> > +static int __devexit ecap_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct ecap_pwm_chip *pc = platform_get_drvdata(pdev);
> > +	struct pwm_device *pwm;
> > +
> > +	if (WARN_ON(!pc))
> > +		return -ENODEV;
> 
> Do you really want to be this verbose? This kind of check is very rare
> anyway, but explicitly warning about it doesn't seems overkill. I think
> the check can even be left out, since every possible error that would
> lead to the driver data not being checked would already cause .probe()
> to return < 0 and therefore .remove() won't ever be called anyway.

Point taken, I will remove.

> 
> > +
> > +	pwm = &pc->chip.pwms[0];
> 
> You don't use this variable.
Ok

Thanks
Avinash

> 
> Thierry
> 
