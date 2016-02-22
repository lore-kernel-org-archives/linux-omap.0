From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: am57xx-beagle-x15: Add eeprom information
Date: Mon, 22 Feb 2016 11:19:01 -0800
Message-ID: <20160222191901.GT13417@atomide.com>
References: <1456159868-32416-1-git-send-email-nm@ti.com>
 <1456159868-32416-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456159868-32416-2-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [160222 08:51]:
> Add EEPROM at 0x50 that describes the board configuration.
> This is useful for userspace programs that may need to check board
> revision and other similar information.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index 36c0fa6c362a..50312f80b972 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -591,6 +591,11 @@
>  		DRVDD-supply = <&vdd_3v3>;
>  		DVDD-supply = <&aic_dvdd>;
>  	};
> +
> +	eeprom: eeprom@50 {
> +		compatible = "at,24c32";
> +		reg = <0x50>;
> +	};
>  };
>  

Applying into omap-for-v4.6/dt thanks.

Tony
