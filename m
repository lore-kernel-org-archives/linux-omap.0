From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/3] usb: ohci-exynos: Make provision for vdd regulators
Date: Thu, 24 Apr 2014 10:26:15 +0900
Message-ID: <000001cf5f5c$2f6c2440$8e446cc0$%han@samsung.com>
References: <1398082604-3013-1-git-send-email-gautam.vivek@samsung.com>
 <002b01cf5f52$a7bc0d70$f7342850$%tikhomirov@samsung.com>
 <001a01cf5f54$af090810$0d1b1830$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <001a01cf5f54$af090810$0d1b1830$%han@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Anton Tikhomirov' <av.tikhomirov@samsung.com>, 'Vivek Gautam' <gautam.vivek@samsung.com>
Cc: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, balbi@ti.com, kgene.kim@samsung.com, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Thursday, April 24, 2014 9:33 AM, Jingoo Han wrote:
> On Thursday, April 24, 2014 9:18 AM, Anton Tikhomirov wrote:
> > On Monday, April 21, 2014 9:17 PM, Vivek Gautam wrote:
> > >
> > > Facilitate getting required 3.3V and 1.0V VDD supply for
> > > OHCI controller on Exynos.
> > >
> > > With patches for regulators' nodes merged in 3.15:
> > > c8c253f ARM: dts: Add regulator entries to smdk5420
> > > 275dcd2 ARM: dts: add max77686 pmic node for smdk5250,
> > >
> > > certain perripherals will now need to ensure that,
> > > they request VDD regulators in their drivers, and enable
> > > them so as to make them working.
> > >
> > > Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> > > Cc: Jingoo Han <jg1.han@samsung.com>
> > > ---
> > >
> > > Based on 'usb-next' branch of Greg's usb tree.
> > >
> > >  drivers/usb/host/ohci-exynos.c |   47
> > > ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > >
> > > diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-
> > > exynos.c
> > > index 68588d8..e2e72a8 100644
> > > --- a/drivers/usb/host/ohci-exynos.c
> > > +++ b/drivers/usb/host/ohci-exynos.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/regulator/consumer.h>
> > >  #include <linux/usb/phy.h>
> > >  #include <linux/usb/samsung_usb_phy.h>
> > >  #include <linux/usb.h>
> > > @@ -37,6 +38,8 @@ struct exynos_ohci_hcd {
> > >  	struct clk *clk;
> > >  	struct usb_phy *phy;
> > >  	struct usb_otg *otg;
> > > +	struct regulator *vdd33;
> > > +	struct regulator *vdd10;
> > >  };
> > >
> > >  static void exynos_ohci_phy_enable(struct platform_device *pdev)
> > > @@ -98,6 +101,28 @@ static int exynos_ohci_probe(struct platform_device
> > > *pdev)
> > >  		exynos_ohci->otg = phy->otg;
> > >  	}
> > >
> > > +	exynos_ohci->vdd33 = devm_regulator_get(&pdev->dev, "vdd33");
> > > +	if (IS_ERR(exynos_ohci->vdd33)) {
> > > +		err = PTR_ERR(exynos_ohci->vdd33);
> > > +		goto fail_regulator1;
> > > +	}
> > > +	err = regulator_enable(exynos_ohci->vdd33);
> > > +	if (err) {
> > > +		dev_err(&pdev->dev, "Failed to enable VDD33 supply\n");
> > > +		goto fail_regulator1;
> > > +	}
> > > +
> > > +	exynos_ohci->vdd10 = devm_regulator_get(&pdev->dev, "vdd10");
> > > +	if (IS_ERR(exynos_ohci->vdd10)) {
> > > +		err = PTR_ERR(exynos_ohci->vdd10);
> > > +		goto fail_regulator2;
> > > +	}
> > > +	err = regulator_enable(exynos_ohci->vdd10);
> > > +	if (err) {
> > > +		dev_err(&pdev->dev, "Failed to enable VDD10 supply\n");
> > > +		goto fail_regulator2;
> > > +	}
> > > +
> >
> > Do we need to skip regulator settings together with PHY configuration
> > in case of exynos5440?
> 
> Oh, right. In the case of exynos5440, regulator settings is not
> necessary. Vivek, would you fix it in order skip regulator settings
> in exynos5440? It also applies to ehci-exynos.

Sorry, in the case of exynos5440, this patch already skips
regulator settings.

In the case of exynos5440, there is no need to set PHY setting
and regulator setting.

How about making regulator setting "optional"?
Then, regulator setting can be done, only when regulator
is supported.

exynos_ohci_probe()
	exynos_ohci->vdd33 = devm_regulator_get(&pdev->dev, "vdd33");
	if (IS_ERR(exynos_ohci->vdd33)) {
		dev_err(&pdev->dev, "Failed to get VDD33 supply\n");
	} else {
		err = regulator_enable(exynos_ohci->vdd33);
		if (err) {
			dev_err(&pdev->dev, "Failed to enable VDD33 supply\n");
			goto fail_regulator1;
		}
	}

	exynos_ohci->vdd10 = devm_regulator_get(&pdev->dev, "vdd10");
	if (IS_ERR(exynos_ohci->vdd10)) {
		dev_err(&pdev->dev, "Failed to get VDD10 supply\n");
	} else {
		err = regulator_enable(exynos_ohci->vdd10);
		if (err) {
			dev_err(&pdev->dev, "Failed to enable VDD10 supply\n");
			goto fail_regulator2;
		}
	}

In this case, suspend/resume can be fixed as below.

exynos_ohci_suspend()
	if (exynos_ohci->vdd10)
		regulator_disable(exynos_ohci->vdd10);
	if (exynos_ohci->vdd33)
		regulator_disable(exynos_ohci->vdd33);

exynos_ohci_resume()

	if (exynos_ohci->vdd33) {
		ret = regulator_enable(exynos_ohci->vdd33);
		if (ret) {
			dev_err(dev, "Failed to enable VDD33 supply\n");
			return ret;
		}
	}
	if (exynos_ohci->vdd10) {
		ret = regulator_enable(exynos_ohci->vdd10);
		if (ret) {
			dev_err(dev, "Failed to enable VDD10 supply\n");
			return ret;
		}
	}

Best regards,
Jingoo Han

> 
> >
> > >  skip_phy:
> > >  	exynos_ohci->clk = devm_clk_get(&pdev->dev, "usbhost");
> > >
> > > @@ -154,6 +179,10 @@ fail_add_hcd:
> > >  fail_io:
> > >  	clk_disable_unprepare(exynos_ohci->clk);
> > >  fail_clk:
> > > +	regulator_disable(exynos_ohci->vdd10);
> > > +fail_regulator2:
> > > +	regulator_disable(exynos_ohci->vdd33);
> > > +fail_regulator1:
> > >  	usb_put_hcd(hcd);
> > >  	return err;
> > >  }
> > > @@ -172,6 +201,9 @@ static int exynos_ohci_remove(struct
> > > platform_device *pdev)
> > >
> > >  	clk_disable_unprepare(exynos_ohci->clk);
> > >
> > > +	regulator_disable(exynos_ohci->vdd10);
> > > +	regulator_disable(exynos_ohci->vdd33);
> > > +
> > >  	usb_put_hcd(hcd);
> > >
> > >  	return 0;
> > > @@ -208,6 +240,9 @@ static int exynos_ohci_suspend(struct device *dev)
> > >
> > >  	clk_disable_unprepare(exynos_ohci->clk);
> > >
> > > +	regulator_disable(exynos_ohci->vdd10);
> > > +	regulator_disable(exynos_ohci->vdd33);
> > > +
> > >  	spin_unlock_irqrestore(&ohci->lock, flags);
> > >
> > >  	return 0;
> > > @@ -218,6 +253,18 @@ static int exynos_ohci_resume(struct device *dev)
> > >  	struct usb_hcd *hcd			= dev_get_drvdata(dev);
> > >  	struct exynos_ohci_hcd *exynos_ohci	= to_exynos_ohci(hcd);
> > >  	struct platform_device *pdev		= to_platform_device(dev);
> > > +	int ret;
> > > +
> > > +	ret = regulator_enable(exynos_ohci->vdd33);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to enable VDD33 supply\n");
> > > +		return ret;
> >
> > Not sure, but shall we continue resuming and do everything
> > we can in case of error? At least it will avoid
> > WARN_ON(clk->enable_count == 0) on next system suspend.
> >
> > > +	}
> > > +	ret = regulator_enable(exynos_ohci->vdd10);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to enable VDD10 supply\n");
> > > +		return ret;
> > > +	}
> > >
> > >  	clk_prepare_enable(exynos_ohci->clk);
> > >
> > > --
> >
> > Thanks
