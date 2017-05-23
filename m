From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] power: supply: cpcap-battery: Add a battery driver
Date: Mon, 22 May 2017 17:38:32 -0700
Message-ID: <20170523003831.GU10472@atomide.com>
References: <20170519055146.2038-1-tony@atomide.com>
 <20170520170533.GN10472@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170520170533.GN10472-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170520 10:09]:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170518 22:55]:
> > Note that I left out the battery interrupt handling for now as I need
> > to spend more time on it for the battery empty interrupts. The driver
> > works just fine without the interrupts too.
> ...
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> > @@ -0,0 +1,27 @@
> > +Motorola CPCAP PMIC battery driver binding
> > +
> > +Required properties:
> > +- compatible: Shall be "motorola,cpcap-battery"
> > +- interrupts: Interrupt specifier for each name in interrupt-names
> > +- interrupt-names: Should contain the following entries:
> > +		   "lowbph", "lowbpl", "chrgcurr1", "battdetb"
> > +- io-channels: IIO ADC channel specifier for each name in io-channel-names
> > +- io-channel-names: Should contain the following entries:
> > +		    "battdetb", "battp"
> > +
> > +Example:
> > +
> > +cpcap_battery: battery {
> > +	compatible = "motorola,cpcap-battery";
> > +	interrupts-extended = <
> > +		&cpcap 5 0 &cpcap 3 0
> > +		&cpcap 20 0 &cpcap 54 0
> > +	>;
> > +	interrupt-names =
> > +		"lowbph", "lowbpl",
> > +		"chrgcurr1", "battdetb";
> > +	io-channels = <&cpcap_adc 0 &cpcap_adc 1
> > +		       &cpcap_adc 5 &cpcap_adc 6>;
> > +	io-channel-names = "battdetb", "battp",
> > +			   "chg_isense", "batti";
> > +};
> 
> I guess we should leave out the interrupts in the binding for now
> too. Or at least move them to optional properties.

Never mind, I got the battery low interrupts finally working. Will
post v2 with interrupts shortly.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
