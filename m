From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/3] ARM: dts: Add support for phyCORE-AM335x PCM-953
 carrier board
Date: Thu, 9 Feb 2017 09:31:33 -0800
Message-ID: <20170209173132.GD21809@atomide.com>
References: <1485252576-36955-1-git-send-email-t.remmet@phytec.de>
 <ff34a257-7272-9b9e-c0bb-a88bac8b3d05@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ff34a257-7272-9b9e-c0bb-a88bac8b3d05-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wadim Egorov <w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org> [170209 08:57]:
> On 24/01/17 10:09, Teresa Remmet wrote:
> > +	user_buttons: user_buttons {
> > +		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&user_buttons_pins>;
> > +
> > +		button@0 {
> > +			label = "home";
> > +			linux,code = <KEY_HOME>;
> > +			gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> > +			gpio-key,wakeup;
> > +		};
> > +
> > +		button@1 {
> > +			label = "menu";
> > +			linux,code = <KEY_MENU>;
> > +			gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
> > +			gpio-key,wakeup;
> 
> Could you please replace this with wakeup-source as specified in
> Documentation/devicetree/bindings/power/wakeup-source.txt
> 
> I know this patch is merged, just fix it on top of linux-next ?
> I think TI/OMAP downstream tree has some remnants of the legacy
> boolean and it keeps slipping through every merge window :)

Oops sorry these keep coming. Teresa, can you please send a
follow-up fix against current Linux next?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
