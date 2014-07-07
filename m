From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] ARM: dts: OMAP5: Add device nodes for ABB
Date: Mon, 7 Jul 2014 04:32:21 -0700
Message-ID: <20140707113220.GQ28884@atomide.com>
References: <1402017072-12599-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21976 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbaGGLcU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 07:32:20 -0400
Content-Disposition: inline
In-Reply-To: <1402017072-12599-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nishanth Menon <nm@ti.com> [140605 18:12]:
> From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>
> 
> Add ABB device nodes for OMAP5 family of devices. Data is based on
> final production OMAP543x Technical Reference Manual revision Z (April 2013).
> Final production Data Manual for OMAP5432 SWPS050F(APRIL 2014).
> 
> [nm@ti.com: co-developer and updates to latest documentation]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
> ---
> Original patch (v1): https://patchwork.kernel.org/patch/3555191/
> 
> Rest of the series was accepted, however, I had to drop this
> previously to ensure that the data we introduce is compatible with
> production samples and existing pre-production samples on various
> OMAP5uEVMs already in circulation.

Is this OK to queue for v3.17 or do we need it for the -rc cycle?

Regards,

Tony
 
>  arch/arm/boot/dts/omap5.dtsi |   60 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index a4ed549..8eee6fb 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -985,6 +985,66 @@
>  				dma-names = "audio_tx";
>  			};
>  		};
> +
> +		abb_mpu: regulator-abb-mpu {
> +			compatible = "ti,abb-v2";
> +			regulator-name = "abb_mpu";
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			clocks = <&sys_clkin>;
> +			ti,settling-time = <50>;
> +			ti,clock-cycles = <16>;
> +
> +			reg = <0x4ae07cdc 0x8>, <0x4ae06014 0x4>,
> +			      <0x4a0021c4 0x8>, <0x4ae0c318 0x4>;
> +			reg-names = "base-address", "int-address",
> +				    "efuse-address", "ldo-address";
> +			ti,tranxdone-status-mask = <0x80>;
> +			/* LDOVBBMPU_MUX_CTRL */
> +			ti,ldovbb-override-mask = <0x400>;
> +			/* LDOVBBMPU_VSET_OUT */
> +			ti,ldovbb-vset-mask = <0x1F>;
> +
> +			/*
> +			 * NOTE: only FBB mode used but actual vset will
> +			 * determine final biasing
> +			 */
> +			ti,abb_info = <
> +			/*uV		ABB	efuse	rbb_m fbb_m	vset_m*/
> +			1060000		0	0x0	0 0x02000000 0x01F00000
> +			1250000		0	0x4	0 0x02000000 0x01F00000
> +			>;
> +		};
> +
> +		abb_mm: regulator-abb-mm {
> +			compatible = "ti,abb-v2";
> +			regulator-name = "abb_mm";
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			clocks = <&sys_clkin>;
> +			ti,settling-time = <50>;
> +			ti,clock-cycles = <16>;
> +
> +			reg = <0x4ae07ce4 0x8>, <0x4ae06010 0x4>,
> +			      <0x4a0021a4 0x8>, <0x4ae0c314 0x4>;
> +			reg-names = "base-address", "int-address",
> +				    "efuse-address", "ldo-address";
> +			ti,tranxdone-status-mask = <0x80000000>;
> +			/* LDOVBBMM_MUX_CTRL */
> +			ti,ldovbb-override-mask = <0x400>;
> +			/* LDOVBBMM_VSET_OUT */
> +			ti,ldovbb-vset-mask = <0x1F>;
> +
> +			/*
> +			 * NOTE: only FBB mode used but actual vset will
> +			 * determine final biasing
> +			 */
> +			ti,abb_info = <
> +			/*uV		ABB	efuse	rbb_m fbb_m	vset_m*/
> +			1025000		0	0x0	0 0x02000000 0x01F00000
> +			1120000		0	0x4	0 0x02000000 0x01F00000
> +			>;
> +		};
>  	};
>  };
>  
> -- 
> 1.7.9.5
> 
