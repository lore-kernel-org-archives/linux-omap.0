From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH] ARM: dts: dra7: Correct clock tree for sys_32k_ck
Date: Mon, 14 Mar 2016 17:32:03 +0530
Message-ID: <56E6A83B.5000908@ti.com>
References: <1457956748-597-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1457956748-597-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org



On Monday 14 March 2016 05:29 PM, Keerthy wrote:
> This is w.r.t J6/J6eco: 32clk is pseudo (erratum i856) - clock source.
> Errata i856 for the AM572x (DRA7xx) points out that the 32.768KHz external
> crystal is not enabled at power up. Instead the CPU falls back to using
> an emulation for the 32KHz clock which is SYSCLK1/610.  SYSCLK1 is usually
> 20MHz on boards so far (which gives an emulated frequency of 32.786KHz)

Missing signed-off. Please ignore this patch.

>
> Modelling the same in device tree.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> Errata Document: http://www.ti.com/lit/er/sprz429h/sprz429h.pdf
> Errata number: i856
>
> Tested the debugfs clock tree nodes on DRA7-EVM.
>
>   arch/arm/boot/dts/dra7xx-clocks.dtsi | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> index 357bede..7f1f892 100644
> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> @@ -98,12 +98,20 @@
>   		clock-frequency = <32768>;
>   	};
>
> -	sys_32k_ck: sys_32k_ck {
> +	sys_clk32_crystal_ck: sys_clk32_crystal_ck {
>   		#clock-cells = <0>;
>   		compatible = "fixed-clock";
>   		clock-frequency = <32768>;
>   	};
>
> +	sys_clk32_pseudo_ck: sys_clk32_pseudo_ck {
> +		#clock-cells = <0>;
> +		compatible = "fixed-factor-clock";
> +		clocks = <&sys_clkin1>;
> +		clock-mult = <1>;
> +		clock-div = <610>;
> +	};
> +
>   	virt_12000000_ck: virt_12000000_ck {
>   		#clock-cells = <0>;
>   		compatible = "fixed-clock";
> @@ -2146,4 +2154,12 @@
>   		ti,bit-shift = <0>;
>   		reg = <0x558>;
>   	};
> +
> +	sys_32k_ck: sys_32k_ck {
> +		#clock-cells = <0>;
> +		compatible = "ti,mux-clock";
> +		clocks = <&sys_clk32_crystal_ck>, <&sys_clk32_pseudo_ck>, <&sys_clk32_pseudo_ck>, <&sys_clk32_pseudo_ck>;
> +		ti,bit-shift = <8>;
> +		reg = <0x6c4>;
> +	};
>   };
>
