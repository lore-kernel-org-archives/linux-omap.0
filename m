From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH DO NOT MERGE 5/6] ARM: dts: omap4: add some sample
 clkctrl data
Date: Tue, 7 Mar 2017 06:45:00 -0800
Message-ID: <20170307144500.GE10239@codeaurora.org>
References: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
 <1486992157-10673-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1486992157-10673-6-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, mturquette@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/13, Tero Kristo wrote:
> Adds clkctrl nodes for cm_l4per and cm_abe as example. Peripherals using
> @@ -131,27 +132,61 @@
>  			ranges = <0 0x4a000000 0x1000000>;
>  
>  			cm1: cm1@4000 {
> -				compatible = "ti,omap4-cm1";
> +				compatible = "ti,omap4-cm1", "simple-bus";
>  				reg = <0x4000 0x2000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x4000 0x2000>;
>  
>  				cm1_clocks: clocks {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  				};
>  
> +				cm_abe: cm_abe@0 {

The unit address should be 500 here.

> +					compatible = "ti,omap4-cm";
> +					reg = <0x500 0x100>;
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					ranges = <0 0x500 0x100>;
> +
> +					cm_abe_clkctrl: cm_abe_clkctrl@20 {
> +						compatible = "ti,omap4-clkctrl";
> +						reg = <0x20 0x6c>;
> +						#clock-cells = <2>;
> +					};
> +				};
> +
>  				cm1_clockdomains: clockdomains {
>  				};
>  			};
>  
>  			cm2: cm2@8000 {
> -				compatible = "ti,omap4-cm2";
> +				compatible = "ti,omap4-cm2", "simple-bus";
>  				reg = <0x8000 0x3000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x8000 0x3000>;
>  
>  				cm2_clocks: clocks {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  				};
>  
> +				cm_l4per: cm_l4per@0 {

and 1400 here.

> +					compatible = "ti,omap4-cm";
> +					reg = <0x1400 0x200>;
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					ranges = <0 0x1400 0x200>;
> +
> +					cm_l4per_clkctrl: cm_l4per_clkctrl@20 {

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
