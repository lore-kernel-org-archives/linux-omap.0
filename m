From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2 1/2] arm/dts: Add AM33XX basic pinctrl support
Date: Tue, 24 Jul 2012 09:10:47 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA026C5@DBDE01.ent.ti.com>
References: <1342769508-24810-1-git-send-email-anilkumar@ti.com>
 <1342769508-24810-2-git-send-email-anilkumar@ti.com>
 <20120724083203.GV6522@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43282 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab2GXJLD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 05:11:03 -0400
In-Reply-To: <20120724083203.GV6522@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

On Tue, Jul 24, 2012 at 14:02:04, Tony Lindgren wrote:
> * AnilKumar Ch <anilkumar@ti.com> [120720 00:36]:
> > Add basic pinctrl support for AM33XX family of devices by adding DT
> > data to am33xx dtsi file. These patches are based on pinctrl-single
> > driver and tested on am335x-evm & am335x-bone devices.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index 59509c4..9b974dc 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -40,6 +40,15 @@
> >  		};
> >  	};
> >  
> > +	am3358_pinmux: pinmux@44E10800 {
> > +		compatible = "pinctrl-single";
> > +		reg = <0x44E10800 0x0338>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		pinctrl-single,register-width = <32>;
> > +		pinctrl-single,function-mask = <0x7F>;
> > +	};
> > +
> >  	/*
> >  	 * XXX: Use a flat representation of the AM33XX interconnect.
> >  	 * The real AM33XX interconnect network is quite complex.Since
> 
> Is there only one padconf domain on 33xx instead of separate core
> and wkup domains like omap3 and omap4 have?
> 

Yes, in case of AM33XX we have only on padconf domain.

Regards
AnilKumar