From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] phy: Add a driver for dm816x USB PHY
Date: Wed, 18 Mar 2015 08:26:19 -0700
Message-ID: <20150318152618.GN31346@atomide.com>
References: <1426637554-27178-1-git-send-email-tony@atomide.com>
 <550994B3.5080301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <550994B3.5080301@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [150318 08:09]:
> On Wednesday 18 March 2015 05:42 AM, Tony Lindgren wrote:
> >+
> >+/*
> >+ * We have phy-core.c handle pm_runtime calls for us. We implement
> >+ * these functions for phy-core.c to keep track of power_count.
> >+ * Note that we may want to remove these eventually and rely only
> >+ * on the usecounting done by PM runtime.
> 
> irrespective of whether the phy drivers implement power_off/power_on callbacks
> or not, the phy core maintains it's usecount. So the following two functions
> shouldn't be needed at all.

OK thanks, I will drop them then.

> >+static int dm816x_usb_phy_power_off(struct phy *x)
> >+{
> >+	return 0;
> >+}
> >+
> >+static int dm816x_usb_phy_power_on(struct phy *x)
> >+{
> >+	return 0;
> >+}
...

> >+static int dm816x_usb_phy_runtime_suspend(struct device *dev)
> >+{
> >+	struct dm816x_usb_phy *phy = dev_get_drvdata(dev);
> >+	unsigned int mask, val;
> >+	int error = 0;
> >+
> >+	mask = BIT(phy->instance);
> >+	val = ~BIT(phy->instance);
> >+	error = regmap_update_bits(phy->syscon, phy->usb_ctrl,
> >+				   mask, val);
> 
> Shouldn't this be protected since both the PHYs can access the same register?

Here regmap takes care of the locking of the syscon register.
Note that this only happens when using regmap_update_bits(), doing
a separate regmap read followed by a regmap write won't achieve the
same.

BTW, we should update the other PHY drivers accessing the SCM region
to do the same using the syscon if not doing already.

Regards,

Tony
