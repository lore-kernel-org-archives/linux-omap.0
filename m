From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Configure USB host for 37xx-evm
Date: Tue, 23 May 2017 07:19:01 -0700
Message-ID: <20170523141901.GW10472@atomide.com>
References: <20170522160647.9606-1-tony@atomide.com>
 <921f6aa1-d410-0942-6ddd-692377acb349@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <921f6aa1-d410-0942-6ddd-692377acb349-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [170523 00:40]:
> On 22/05/17 19:06, Tony Lindgren wrote:
> > +	hsusb2_pins: pinmux_hsusb2_pins {
> > +		pinctrl-single,pins = <
> > +
> > +		/* On-board EHCI USB2 gpmc_nbe1.gpio_61 */
> > +		OMAP3_CORE1_IOPAD(0x20c8, PIN_OUTPUT | MUX_MODE4)
> 
> GPIO_61 looks like nUSB2_EN_1V8 from you comment. This is PHY power related and not hsusb2 related
> so it should be in a different group?

Hmm only ehci is using the legacy usb-phy and it will never get
set for ohci alone. Even though ohci alone is not usable without
a LS/FS phy, that might create more confusion if anybody attempts
to actually use ohci with a real phy. So we probably want to set
them as pinctrl hogs like beagle board is doing.

> > +&omap3_pmx_core2 {
> > +	hsusb2_2_pins: pinmux_hsusb2_2_pins {
> > +		pinctrl-single,pins = <
> > +
> > +		/* EHCI PHY reset GPIO etk_d7.gpio_21 */
> > +		OMAP3630_CORE2_IOPAD(0x25ea, PIN_OUTPUT | MUX_MODE4)
> 
> GPIO_21 is PHY RESET related and not hsusb2 related. Can we have this in a pin group for hsusb2_phy?

Probably should be just pinctrl hog then for the same reasons until
the phy vs usb-phy mess is cleared.

> Also, hsusb2_pins and hsusb2_2_pins are both related to hsusb2. In omap3-beagle.dts
> we don't assign them to any node and they are just setup once at boot by pincltrl default.

Yup I totally see why that is done now..

> > +
> > +		/* EHCI VBUS etk_d8.gpio_22 */
> > +		OMAP3630_CORE2_IOPAD(0x25ec, PIN_OUTPUT | MUX_MODE4)
> 
> GPIO_21 is PHY power enable so can we have this in a pin group for hsusb2_power?

Again should probably be a pinctrl hog for now for the same reasons.

> > +/* GPIO_61 (nUSB2_EN_1V8) low for on-board EHCI USB2 interface */
> > +&gpio2 {
> > +	en_hsusb2_clk {
> 
> Is this GPIO_61 enabling 1V8 supply or clk? Node name should be fixed accordingly.
> 
> > +		gpio-hog;
> > +		gpios = <29 GPIO_ACTIVE_HIGH>;
> 
> Should this be be GPIO_61?

Oh that seems wrong, thanks for noticing it. Will check.

> Does this need to be a hog?
> 
> > +		output-low;
> > +		line-name = "hsusb2 port";
> 
> Can line name be more revealing? e.g. hsusb2 power or hsusb2 clock?

It seems to route the interface between extension connector pins
and the phy on the device.

> > +	/* HS USB Host PHY on PORT 2 */
> > +	hsusb2_phy: hsusb2_phy {
> 
> Here we can put the PHY reset related pinmux group.

That will never get claimed for ohci alone currently. There
is no real LS/FS phy, so best to set them up as pinctrl hogs.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
