From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Wed, 11 Mar 2015 08:19:27 -0700
Message-ID: <20150311151927.GV5264@atomide.com>
References: <20150309205157.GE5140@atomide.com>
 <550011B1.5010706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <550011B1.5010706@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [150311 02:58]:
> Hi Tony,
> 
> On Tuesday 10 March 2015 02:21 AM, Tony Lindgren wrote:
> >Add a minimal driver for dm816x USB. Otherwise we can just use
> >the existing musb_am335x and musb_dsps on dm816x.
> 
> If we can use an existing driver, I'd prefer that.

Hmm that needs rewording.. Should say that with this phy
driver musb works with existing musb_dsps usb driver on
dm816x. There is no existing driver, the closest similar
thing is the legacy drivers/usb/musb/davinci.c that has
no separate phy driver.

> >+static int dm816x_usb_phy_power_off(struct phy *x)
> >+{
> >+	struct dm816x_usb_phy *phy = phy_get_drvdata(x);
> >+
> >+	pm_runtime_put(phy->dev);
> 
> phy core takes care of invoking pm_runtime_put on power_off.
> So this function shouldn't be needed at all.

OK will remove the pm_runtime calls for all of them.

...

> >+	phy->refclk = devm_clk_get(phy->dev, "refclk");
> >+	if (IS_ERR(phy->refclk))
> >+		return PTR_ERR(phy->refclk);
> >+
> >+	generic_phy = devm_phy_create(phy->dev, NULL, &ops);
> >+	if (IS_ERR(generic_phy))
> >+		return PTR_ERR(generic_phy);
> 
> Just invoke pm_runtime_enable before phy_create and phy core will take care of
> invoking all pm_runtime functions at appropriate time.

OK will.

Thanks,

Tony
