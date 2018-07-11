From: Tony Lindgren <tony@atomide.com>
Subject: Re: Vibrations on Droid 4?
Date: Wed, 11 Jul 2018 06:27:39 -0700
Message-ID: <20180711132739.GL99251@atomide.com>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711080218.GA21225@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180711 08:05]:
> Hi!
> 
> > > Its parent is gpio@4805d000 , and that one seems to be present.
> > > 
> > > user@devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
> > > driver				       driver_override  gpio
> > > gpiochip5  modalias  of_node  power  subsystem  uevent
> > 
> > Sorry, something went wrong with merging this. The parent
> > of ti,omap-dmtimer-pwm and pwm-vibrator should be / and
> > not gpio6.
> 
> Ok, got it to probe... after dts fix and adding EPROBE_DEFFER to
> driver.
..
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -159,13 +159,7 @@
>  
>  		dais = <&mcbsp2_port>, <&mcbsp3_port>;
>  	};
> -};
> -
> -&dss {
> -	status = "okay";
> -};
>  
> -&gpio6 {
>  	pwm8: dmtimer-pwm-8 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&vibrator_direction_pin>;
> @@ -192,7 +186,10 @@
>  		pwm-names = "enable", "direction";
>  		direction-duty-cycle-ns = <10000000>;
>  	};
> +};
>  
> +&dss {
> +	status = "okay";
>  };
>  
>  &dsi1 {

Hmm sorry if I did a mismerge on the above. A note to
myself to stop applying patches that apply with fuzz,
that is clearly dangerous with dts files with lots
of similar named properties.

Regards,

Tony
