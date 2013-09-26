From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv7 30/36] ARM: dts: omap3 clock data
Date: Thu, 26 Sep 2013 11:06:57 -0500
Message-ID: <20130926160657.GA6280@kahuna>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <1380098922-30340-31-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36968 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834Ab3IZQHZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Sep 2013 12:07:25 -0400
Content-Disposition: inline
In-Reply-To: <1380098922-30340-31-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11:48-20130925, Tero Kristo wrote:
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 16420ae..bc11b83 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -533,4 +533,11 @@
>  			ram-bits = <12>;
>  		};
>  	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		/include/ "omap3xxx-clocks.dtsi"
> +	};
>  };
Clocks are introduced towards the tail of the dts -> this has a problem
associated with it -> device nodes should be able to reference phandle
like:

devicex {
	clocks = <&sys_ck>;
}

Since all the devices on ocp and cpu0 node appears above the definition
they fail to catch the phandle. instead, moving the clocks node as high
in the tree as possible resolves this: something like:
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index bc11b83..0b2161d 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -24,6 +24,13 @@
 		serial2 = &uart3;
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		/include/ "omap3xxx-clocks.dtsi"
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -534,10 +541,4 @@
 		};
 	};
 
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		/include/ "omap3xxx-clocks.dtsi"
-	};
 };

What do you think of the change? applies for all clock nodes in other
dtsi as well - I will mark them as I find them.

Further,
> diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
> index 5355d61..2ed7c69 100644
> --- a/arch/arm/boot/dts/omap34xx.dtsi
> +++ b/arch/arm/boot/dts/omap34xx.dtsi
> @@ -25,4 +25,123 @@
>  			clock-latency = <300000>; /* From legacy driver */
>  		};
>  	};
> -};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
dont need to state the above two -> already done in omap3.dtsi.
> +		/include/ "omap34xx-omap36xx-clocks.dtsi"
> +		/include/ "omap36xx-omap3430es2plus-clocks.dtsi"
> +		/include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
> +	};
> +};
[...]
> \ No newline at end of file
^^
[...]
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> index f8b3765..71fb6fb 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -35,4 +35,124 @@
>  			clock-frequency = <48000000>;
>  		};
>  	};
> -};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
^^ here as well.
> +		/include/ "omap36xx-clocks.dtsi"
> +		/include/ "omap34xx-omap36xx-clocks.dtsi"
> +		/include/ "omap36xx-omap3430es2plus-clocks.dtsi"
> +		/include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
> +	};
[...]
> +};
> \ No newline at end of file
^^ this need fix as well.

-- 
Regards,
Nishanth Menon
