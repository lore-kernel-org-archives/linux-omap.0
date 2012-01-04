From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 06/10] arm/dts: OMAP3: Add i2c controller nodes
Date: Wed, 4 Jan 2012 11:14:00 -0700
Message-ID: <20120104181400.GM15503@ponder.secretlab.ca>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-7-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1323439361-1647-7-git-send-email-b-cousson-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 09, 2011 at 03:02:37PM +0100, Benoit Cousson wrote:
> Add i2c controllers nodes into the main ocp bus.
> 
> Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
>  arch/arm/boot/dts/omap3.dtsi |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 6866dc7..81d8e2c 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -61,5 +61,33 @@
>  			ti,intc-size = <96>;
>  			reg = <0x48200000 0x1000>;
>  		};
> +
> +		/*
> +		 * Flags for all i2c instances: 0x118
> +		 * APPLY_ERRATA_I207 | RESET_REGS_POSTIDLE | BUS_SHIFT_2
> +		 */
> +		i2c1: i2c@1 {
> +			compatible = "ti,omap3-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c1";
> +			ti,flags = <0x118>;
> +		};
> +
> +		i2c2: i2c@2 {
> +			compatible = "ti,omap3-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c2";
> +			ti,flags = <0x118>;
> +		};
> +
> +		i2c3: i2c@3 {
> +			compatible = "ti,omap3-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c3";
> +			ti,flags = <0x118>;
> +		};
>  	};
>  };
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
