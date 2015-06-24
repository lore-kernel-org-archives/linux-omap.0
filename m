From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 17/17] ARM: dts: omap4: Use "syscon-otghs" instead of
 "ctrl-module" in USB node
Date: Wed, 24 Jun 2015 15:02:22 +0300
Message-ID: <20150624150222.98f9bfec890438c67e4d52eb@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
	<1435060743-5511-18-git-send-email-kishon@ti.com>
	<20150624104116.GC4156@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150624104116.GC4156@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, bcousson@baylibre.com, balbi@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, 24 Jun 2015 03:41:16 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Kishon Vijay Abraham I <kishon@ti.com> [150623 05:02]:
> > --- a/arch/arm/boot/dts/omap4.dtsi
> > +++ b/arch/arm/boot/dts/omap4.dtsi
> > @@ -852,12 +852,6 @@
> >  			};
> >  		};
> >  
> > -		omap_control_usbotg: control-phy@4a00233c {
> > -			compatible = "ti,control-phy-otghs";
> > -			reg = <0x4a00233c 0x4>;
> > -			reg-names = "otghs_control";
> > -		};
> > -
> >  		usb_otg_hs: usb_otg_hs@4a0ab000 {
> >  			compatible = "ti,omap4-musb";
> >  			reg = <0x4a0ab000 0x7ff>;
> > @@ -870,7 +864,7 @@
> >  			multipoint = <1>;
> >  			num-eps = <16>;
> >  			ram-bits = <12>;
> > -			ctrl-module = <&omap_control_usbotg>;
> > +			syscon-otghs = <&scm_conf 0x33c>;
> >  		};
> >  
> >  		aes: aes@4b501000 {
> 
> We should still keep a separate entry for the phy in the dtsi
> files. And the phy should be a child of the scm_conf area in the
> dtsi file.

The PHY already has a separate entry with its own set of registers.
Just that some bits have been shoved into the control module space
not only for PHY but for other modules as well like DSS, DCAN, etc.

> 
> This is because the scm and usb_otg_hs are separate devices and
> can be clocked separately. So the phy driver needs to be a
> separate driver to avoid spaghetti code and issues with clocking.

for the PHY register space this is already done.

But for the register bits that lie in control module space isn't that
taken care by syscon driver?

cheers,
-roger
