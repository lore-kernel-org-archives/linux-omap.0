From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V4] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
Date: Wed, 7 Jan 2015 16:20:37 -0800
Message-ID: <20150108002037.GS13010@atomide.com>
References: <1420475549-28492-1-git-send-email-nm@ti.com>
 <20150105172718.GJ19336@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50997 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751919AbbAHAYZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 19:24:25 -0500
Content-Disposition: inline
In-Reply-To: <20150105172718.GJ19336@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Nishanth Menon <nm@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, sre@kernel.org

* Felipe Balbi <balbi@ti.com> [150105 09:30]:
> On Mon, Jan 05, 2015 at 10:32:29AM -0600, Nishanth Menon wrote:
> > TPS gpio now controls a 5v 500mA TL5209 regulator which may be supply
> > a fan (such as AFB02505HHB) over J1 connector for various purposes.
> > Provide device tree node to enable the same.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> have already reviewed this one previously:
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Applying this into omap-for-v3.20/dt instead of the
earlier version thanks.

Tony

> > ---
> > V4: Change format of the speed-map used.
> > V3: https://patchwork.kernel.org/patch/5562121/
> > V2: https://patchwork.kernel.org/patch/5445111/
> > V1: https://patchwork.kernel.org/patch/5444911/
> > 
> > Enable and disable can be controlled by (post the RPM, it finds
> > closest match - even a 1 will do)
> > 
> > echo '13000' > /sys/class/hwmon/hwmon0/fan1_target
> > and
> > echo '0' > /sys/class/hwmon/hwmon0/fan1_target
> > 
> > Test log: http://slexy.org/view/s2T0ajh46z
> > 
> > requires CONFIG_GPIO_PALMAS and CONFIG_SENSORS_GPIO_FAN to be operational
> > Applies on v3.19-rc1
> > 
> >  arch/arm/boot/dts/am57xx-beagle-x15.dts |   14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> > index 6c2e8e4..c5d4cea 100644
> > --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> > +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> > @@ -80,6 +80,14 @@
> >  			default-state = "off";
> >  		};
> >  	};
> > +
> > +	gpio_fan: gpio_fan {
> > +		/* Based on 5v 500mA AFB02505HHB */
> > +		compatible = "gpio-fan";
> > +		gpios =  <&tps659038_gpio 1 GPIO_ACTIVE_HIGH>;
> > +		gpio-fan,speed-map = <0     0>,
> > +				     <13000 1>;
> > +	};
> >  };
> >  
> >  &dra7_pmx_core {
> > @@ -394,6 +402,12 @@
> >  			wakeup-source;
> >  			ti,palmas-long-press-seconds = <12>;
> >  		};
> > +
> > +		tps659038_gpio: tps659038_gpio {
> > +			compatible = "ti,palmas-gpio";
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +		};
> >  	};
> >  
> >  	tmp102: tmp102@48 {
> > -- 
> > 1.7.9.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> balbi


