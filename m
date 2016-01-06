From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and
 charging of backup battery
Date: Tue, 5 Jan 2016 17:00:12 -0800
Message-ID: <20160106010011.GG12777@atomide.com>
References: <cover.1451995297.git.hns@goldelico.com>
 <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com>
 <568C5451.8070709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <568C5451.8070709-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160105 15:40]:
> On 01/05/2016 06:01 AM, H. Nikolaus Schaller wrote:
> > tested on OMP5432 EVM
> > 
> > Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/omap5-board-common.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
> > index 5cf76a1..30c0d3b 100644
> > --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> > +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> > @@ -358,6 +358,14 @@
> >  			#clock-cells = <0>;
> >  		};
> >  
> > +		rtc {
> > +			compatible = "ti,palmas-rtc";
> > +			interrupt-parent = <&palmas>;
> > +			interrupts = <8 IRQ_TYPE_NONE>;
> 
> IRQ_TYPE_NONE is not correct here -> it should have some polarity - if
> it had none, there'd be no interrupt, right?

Also I'm not seeing just zeroes coming from RTC after typing hwclock
on omap5-uevm. It's working on x15 though.

Nikolaus, is hwclock command working for you on omap5-uevm?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
