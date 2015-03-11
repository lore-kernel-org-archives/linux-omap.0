From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 34/35] ARM: dts: dra7: add system control module node
Date: Wed, 11 Mar 2015 10:17:08 -0700
Message-ID: <20150311171708.GB5264@atomide.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
 <1424891085-10392-35-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:36559 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbbCKRWN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2015 13:22:13 -0400
Content-Disposition: inline
In-Reply-To: <1424891085-10392-35-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tero,

* Tero Kristo <t-kristo@ti.com> [150225 11:09]:
> Add node for system control module, and move all the existing system
> control IO space users under this new node as its children. A new node
> for scm_conf area is also added.
...

> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -203,26 +203,47 @@
>  			};
>  		};
>  
> +		scm: scm@4a002000 {
> +			compatible = "ti,dra7-ctrl", "simple-bus";
> +			reg = <0x4a002000 0x1400>,
> +			      <0x4a003400 0x600>,
> +			      <0x4ae0c000 0x600>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x4a002000 0x1400>,
> +				 <1 0 0x4a003400 0x600>,
> +				 <2 0 0x4ae0c000 0x600>;
> +
> +			scm_conf: tisyscon@0,0 {
> +				compatible = "syscon";
> +				reg = <0 0x0 0x1400>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +			};
> +
> +			dra7_pmx_core: pinmux@1,0 {
> +				compatible = "ti,dra7-padconf",
> +					     "pinctrl-single";
> +				reg = <1 0x0 0x0464>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +				pinctrl-single,register-width = <32>;
> +				pinctrl-single,function-mask = <0x3fffffff>;
> +			};
> +		};

Wouldn't it make more sense to have separate device_scm, core_scm and
wkup_scm instead of stuffing multiple ranges here?

Or are there other reasons for the multiple ranges?

Regards,

Tony
