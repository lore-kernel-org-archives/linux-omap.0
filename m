From: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: Add support for phyCORE-AM335x PCM-953
 carrier board
Date: Mon, 23 Jan 2017 11:27:12 +0100
Message-ID: <1485167232.3082.9.camel@phytec.de>
References: <1484831270-7251-1-git-send-email-t.remmet@phytec.de>
         <20170121205345.oij67ai5d7q7k74d@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170121205345.oij67ai5d7q7k74d@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wadim Egorov <w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Rob,

Am Samstag, den 21.01.2017, 14:53 -0600 schrieb Rob Herring:
> On Thu, Jan 19, 2017 at 02:07:48PM +0100, Teresa Remmet wrote:
> > 
> > The phyCORE-AM335x development kit is a combination of the
> > phyCORE-AM335x SoM and a PCM-953 carrier board. The features
> > of the PCM-953 are:
> > * ETH phy on carrier board: 1x RGMII
> > * 1x CAN
> > * Up to 4x UART
> > * USB0 (otg)
> > * USB1 (host)
> > * SD slot
> > * User gpio-keys
> > * User LEDs
> > 
> > Signed-off-by: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
> > Reviewed-by: Wadim Egorov <w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
> > ---
> >  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
> >  arch/arm/boot/dts/Makefile                         |   1 +
> >  arch/arm/boot/dts/am335x-pcm-953.dtsi              | 303
> > +++++++++++++++++++++
> >  arch/arm/boot/dts/am335x-phycore-rdk.dts           |  27 ++
> >  4 files changed, 334 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/am335x-pcm-953.dtsi
> >  create mode 100644 arch/arm/boot/dts/am335x-phycore-rdk.dts
> [...]
> 
> > 
> > +	user_leds: user_leds {
> > +		compatible = "gpio-leds";
> > +	};
> > +
> > +	user_buttons: user_buttons {
> > +		compatible = "gpio-keys";
> > +	};
> With only a compatible, I don't think there's much gain to split
> these 2 
> nodes. Otherwse,

whould it be ok to open up the root node again below? Or should I
better move the nodes up? Which does mess up the order then. We
orinented here on the am335x-pepper.dts. They also only keep the
compatibles in the root node.

Thanks,
Teresa

> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> 
> > 
> > +&user_buttons {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&user_buttons_pins>;
> > +	status = "okay";
> > +
> > +	button@0 {
> > +		label = "home";
> > +		linux,code = <KEY_HOME>;
> > +		gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> > +		gpio-key,wakeup;
> > +	};
> > +
> > +	button@1 {
> > +		label = "menu";
> > +		linux,code = <KEY_MENU>;
> > +		gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
> > +		gpio-key,wakeup;
> > +	};
> > +};
> > +
> > +&user_leds {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&user_leds_pins>;
> > +	status = "okay";
> > +
> > +	green {
> > +		label = "green:user";
> > +		gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
> > +		linux,default-trigger = "gpio";
> > +		default-state = "on";
> > +	};
> > +
> > +	yellow {
> > +		label = "yellow:user";
> > +		gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
> > +		linux,default-trigger = "gpio";
> > +		default-state = "on";
> > +	};
> > +};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
