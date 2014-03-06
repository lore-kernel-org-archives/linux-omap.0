From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/5] ARM: dts: AM4372: Add USB nodes
Date: Thu, 6 Mar 2014 10:37:30 -0800
Message-ID: <20140306183729.GC1381@atomide.com>
References: <1393854834-23810-1-git-send-email-george.cherian@ti.com>
 <1393854834-23810-3-git-send-email-george.cherian@ti.com>
 <53183699.8070106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53183699.8070106-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, anatol.pomozov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140306 00:52]:
> On 03/03/2014 03:53 PM, George Cherian wrote:
> > --- a/arch/arm/boot/dts/am4372.dtsi
> > +++ b/arch/arm/boot/dts/am4372.dtsi
> > @@ -698,6 +698,105 @@
> >  			       <&edma 11>;
> >  			dma-names = "tx", "rx";
> >  		};
> > +
> > +		am43xx_control_usb2phy1: control-phy@44e10620 {
> > +			compatible = "ti,control-phy-am437usb2";
> 
> Since this is the first usage of this compatible ID, we still have room to
> change it to be better. Tony's suggestion was to use "ti,control-phy-am437-usb2"

Or from grepping point of view ti,control-phy-usb2-am437 might be better?

Regards,

Tony 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
