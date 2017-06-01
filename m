From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] power: supply: cpcap-battery: Add a battery driver
Date: Wed, 31 May 2017 17:13:09 -0700
Message-ID: <20170601001309.GN3730@atomide.com>
References: <20170523005637.945-1-tony@atomide.com>
 <20170531163002.j4xb6fo3ipq6ly2d@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170531163002.j4xb6fo3ipq6ly2d@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170531 09:33]:
> On Mon, May 22, 2017 at 05:56:37PM -0700, Tony Lindgren wrote:
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
> 
> Doesn't match the example.

Oops thanks for catching that. Will repost shortly with the
binding as a separate patch.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
