From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: omap3: keep ssi ports by default
Date: Mon, 19 Oct 2015 09:01:58 -0700
Message-ID: <20151019160158.GB22043@atomide.com>
References: <1444819456-26728-1-git-send-email-rogerq@ti.com>
 <1444819456-26728-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444819456-26728-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: wsa@the-dreams.de, sre@kernel.org, pavel@ucw.cz, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [151014 03:48]:
> Let's keep the SSI ports disabled in the omap3.dtsi to avoid
> getting the following noise on the console for boards that don't
> use the SSI ports.
> 
> "omap_ssi_port 4805a000.ssi-port: DT data is missing cawake gpio (err=-2)"
> 
> As omap3-n900 uses one SSI port, mark it enabled there.

This is the wrong way around.. The SSI ports are there on all omap3 SoCs,
we do want to have the struct device created for them. It's best to have
the driver probe and then idle SSI and bail out. Marking something with
status = "disabled" should be only used if you really want to avoid kernel
touching the device at all, for example, if something is managed from
the start by a copropcessor.

Regards,

Tony


> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/omap3-n900.dts | 1 +
>  arch/arm/boot/dts/omap3.dtsi     | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 5f5e0f3..bdb72fb 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -949,6 +949,7 @@
>  };
>  
>  &ssi_port1 {
> +	status = "ok";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&ssi_pins>;
>  
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 8a2b253..25b0b37 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -815,6 +815,7 @@
>  				interrupt-parent = <&intc>;
>  				interrupts = <67>,
>  					     <68>;
> +				status = "disabled";
>  			};
>  
>  			ssi_port2: ssi-port@4805b000 {
> @@ -828,6 +829,7 @@
>  				interrupt-parent = <&intc>;
>  				interrupts = <69>,
>  					     <70>;
> +				status = "disabled";
>  			};
>  		};
>  	};
> -- 
> 2.1.4
> 
