From: Lukasz Majewski <lukma-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] DTS: dra7: Add "opp_high" opp node to support 1.5
 GHz SoC operation
Date: Sat, 4 Feb 2017 00:06:15 +0100
Message-ID: <20170204000615.4417940f@jawa>
References: <1486135491-14223-1-git-send-email-lukma@denx.de>
        <1486135491-14223-2-git-send-email-lukma@denx.de>
        <f17ceda2-45e0-9c67-7c8a-5a35132a2d0a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f17ceda2-45e0-9c67-7c8a-5a35132a2d0a-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

> On 02/03/2017 09:24 AM, Lukasz Majewski wrote:
> > The "opp_high" property brings support for 1.5 GHz CPU frequency
> > for TI's am57xx line of processors.
> >
> > Signed-off-by: Lukasz Majewski <lukma-ynQEQJNshbs@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/dra7.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/dra7.dtsi
> > b/arch/arm/boot/dts/dra7.dtsi index a860a56..5e678cd 100644
> > --- a/arch/arm/boot/dts/dra7.dtsi
> > +++ b/arch/arm/boot/dts/dra7.dtsi
> > @@ -108,6 +108,11 @@
> >  			opp-hz = /bits/ 64 <1176000000>;
> >  			opp-microvolt = <1160000 885000 1160000>;
> >  		};
> > +
> > +		opp_high@1500000000 {
> > +			opp-hz = /bits/ 64 <1500000000>;
> > +			opp-microvolt = <1210000 950000 1250000>;
> > +		};
> >  	};
> >
> >  	/*
> >
> Please keep this out of the way till we get the AVS class0 integrated 
> in. devices wont be save at 1.5GHz without the opp powerdomain + AVS 
> Class0 implementation.
> 

Yes, correct. My AM5728 works with this opp, but AM5718 hangs when this
frequency is enabled.



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
