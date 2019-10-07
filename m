From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Set status to disable for MMC3
Date: Mon, 7 Oct 2019 09:16:34 -0700
Message-ID: <20191007161634.GS5610@atomide.com>
References: <20191007080339.57209-1-manu@freebsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191007080339.57209-1-manu@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Emmanuel Vadot <manu@freebsd.org>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Emmanuel Vadot <manu@freebsd.org> [191007 08:04]:
> Commit 5b63fb90adb95 ("ARM: dts: Fix incomplete dts data for am3 and am4 mmc")
> fixed the mmc instances on the l3 interconnect but removed the disabled status.
> Fix this and let boards properly define it if it have it.

The dts default is "okay", and should be fine for all the
internal devices even if not pinned out on the board. This
way the devices get properly idled during boot, and we
avoid repeating status = "enabled" over and over again in
the board specific dts files.

Then the board specific dts files might want to configure
devices with status = "disabled" if really needed. But this
should be only done for devices that Linux must not use,
such as crypto acclerators on secure devices if claimed by
the secure mode.

So if this fixes something, it's almost certainly a sign
of something else being broken?

Regards,

Tony


> Fixes: 5b63fb90adb95 ("ARM: dts: Fix incomplete dts data for am3 and am4 mmc")
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index fb6b8aa12cc5..b3a1fd9e39fa 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -260,6 +260,7 @@
>  				ti,needs-special-reset;
>  				interrupts = <29>;
>  				reg = <0x0 0x1000>;
> +				status = "disabled";
>  			};
>  		};
>  
> -- 
> 2.22.0
> 
