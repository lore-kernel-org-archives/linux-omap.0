From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] phy: cpcap-usb: Add CPCAP PMIC USB support
Date: Mon, 27 Mar 2017 08:05:19 -0700
Message-ID: <20170327150518.GH10760@atomide.com>
References: <20170322234602.5888-1-tony@atomide.com>
 <d47b0f99-1ef8-3bff-0fbe-edb95ed41e23@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d47b0f99-1ef8-3bff-0fbe-edb95ed41e23-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [170326 23:27]:
> On Thursday 23 March 2017 05:16 AM, Tony Lindgren wrote:
> > +static const struct phy_ops ops = {
> > +	.owner		= THIS_MODULE,
> > +};
> 
> Given that this phy doesn't have any phy_ops, Is there a reason for registering
> this phy with the phy framework? Is it because this driver uses the phy_core's
> pm_runtime feature?

Well there's also an ULPI PHY on CPCAP, but it's not used in the
motorola-mapphone configuration. I think some other configurations
use it though, so probably best to keep it.

And yeah, for PM runtime, I was thinking that we can have the
UART mode be the idle state.

> > +static void cpcap_usb_detect(struct work_struct *work)
> > +{
> > +	struct cpcap_phy_ddata *ddata;
> > +	struct cpcap_usb_ints_state s;
> > +	bool vbus = false;
> > +	int error;
> > +
> > +	ddata = container_of(work, struct cpcap_phy_ddata, detect_work.work);
> > +
> > +	error = cpcap_phy_get_ints_state(ddata, &s);
> > +	if (error)
> > +		return;
> > +
> > +	/* See also cpcap-charger.c phy_companion for VBUS handling */
> 
> I think this companion should have ideally used extcon framework. Then we could
> have used extcon_get_state() here.

OK I'll take a look at that. I'd like to do that as a follow-up
patches if that's OK with you.

FYI in case you're wondering, there are ADCs on the PMIC available
via IIO, and the charger is also using IIO framework for VBUS and
battery voltage. And the VBUS is set up as reverse mode in the
charger registers and the charging needs to be disabled for VBUS.

I guess Ideally the VBUS would be just a regulator from Linux point
of view that also allows negative current :)

> > +	ddata->vusb = devm_regulator_get(&pdev->dev, "vusb");
> > +	if (IS_ERR(ddata->vusb))
> > +		return PTR_ERR(ddata->vusb);
> > +
> > +	error = regulator_enable(ddata->vusb);
> > +	if (error)
> > +		return error;
> 
> Maybe we should create power_on ops and do regulator enable there?

This regulator is also needed for the UART mode, so it would have
to be disabled conditionally based on maybe a module parameter.
But yeah thanks for the pointer I did not even realize you have
power_on ops :)

Seems this can be also done when implementing PM runtime handling.
If you want some of these changes done for the initial patch,
please let me know.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
