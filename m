From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 06/11] arm/dts: am33xx: Add dt data for usbss
Date: Wed, 18 Jul 2012 12:37:23 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EADB646@DBDE01.ent.ti.com>
References: <1342516407-16515-1-git-send-email-ajay.gupta@ti.com>
 <1342516407-16515-7-git-send-email-ajay.gupta@ti.com>
 <50055CD9.3060300@mvista.com>
 <47CEF8C4B26E8C44B22B028A650E0EA93EADB1C5@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA93EADB1C5-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi
> > On 17-07-2012 13:13, Ajay Kumar Gupta wrote:
> >
> > > Added device tree data for usbss on am33xx. There are two musb
> > controllers
> > > on am33xx platform so have port0_mode and port1_mode additional
> data.
> >
> > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> > > ---
> > >   arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
> > >   1 files changed, 11 insertions(+), 0 deletions(-)
> >
> > > diff --git a/arch/arm/boot/dts/am33xx.dtsi
> > b/arch/arm/boot/dts/am33xx.dtsi
> > > index 59509c4..b572803 100644
> > > --- a/arch/arm/boot/dts/am33xx.dtsi
> > > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > > @@ -154,5 +154,16 @@
> > >   			#size-cells = <0>;
> > >   			ti,hwmods = "i2c3";
> > >   		};
> > > +
> > > +		usb_otg_hs: usb_otg_hs@47400000 {
> >
> >     The "reg" property is absent, so why did you give the node name
> the
> > address postfix?
> 
> Currently "reg" property is coming from "ti hwmods".

I meant base addresses are coming from hwmods and so there is no "reg"
property added here. I will update the patch dropping address postfix.

Ajay

> > > +			compatible = "ti,musb-am33xx";
> > > +			ti,hwmods = "usb_otg_hs";
> > > +			multipoint = <1>;
> > > +			num_eps = <16>;
> > > +			ram_bits = <12>;
> > > +			port0_mode = <3>;
> > > +			port1_mode = <1>;
> > > +			power = <250>;
> > > +		};
> >
> > WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
