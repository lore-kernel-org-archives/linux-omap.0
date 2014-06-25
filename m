From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: DRA7-evm: Enable SATA PHY and USB PHY power supplies
Date: Wed, 25 Jun 2014 17:27:44 -0500
Message-ID: <53AB4CE0.6020705@ti.com>
References: <1403700996-27105-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403700996-27105-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: rnayak@ti.com, balbi@ti.com, nsekhar@ti.com, kishon@ti.com, george.cherian@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/25/2014 07:56 AM, Roger Quadros wrote:
> The SATA and USB PHYs need the 1.8V and 3.3V supplies.
> The PHY drivers/framework don't yet support regulator
> supply so we have to keep these regulators always-on till
> then.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/dra7-evm.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 4adc280..99a1f79 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -241,6 +241,7 @@
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
>  					regulator-boot-on;
> +					regulator-always-on;
>  				};
>  
>  				ldo9_reg: ldo9 {
> @@ -266,6 +267,7 @@
>  					regulator-min-microvolt = <3300000>;
>  					regulator-max-microvolt = <3300000>;
>  					regulator-boot-on;
> +					regulator-always-on;
>  				};
>  			};
>  		};
> 

Why not fix phy driver/framework as needed? the trouble is people
always forget to remove always-on... who actually audits old logs and
fixes stuff back up?

-- 
Regards,
Nishanth Menon
