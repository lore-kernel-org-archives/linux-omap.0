From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap4: add missing des_fck
Date: Mon, 12 Jun 2017 11:14:15 +0300
Message-ID: <acbebaee-fc79-d2b9-cc9a-86abe1f7fc05@ti.com>
References: <20170609231206.19798-1-sre@kernel.org>
 <20170609231206.19798-2-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170609231206.19798-2-sre@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/06/17 02:12, Sebastian Reichel wrote:
> Add missing functional clock for DES3DES IP core. This is
> documented in the TRM as CM_L4SEC_DES3DES_CLKCTRL.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>   arch/arm/boot/dts/omap44xx-clocks.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
> index 9573b37fbaa7..e997265460d4 100644
> --- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
> @@ -985,6 +985,14 @@
>   		reg = <0x15a8>;
>   	};
>   
> +	des_fck: des_fck@15b0 {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&l3_div_ck>;
> +		ti,bit-shift = <1>;
> +		reg = <0x15b0>;
> +	};
> +
>   	dss_sys_clk: dss_sys_clk@1120 {
>   		#clock-cells = <0>;
>   		compatible = "ti,gate-clock";
> 

NAK. Don't add a duplicate entry for the hwmod clkctrl clock. You are 
adding control to the exact same bit via the hwmod data entry also 
causing a possibility for race condition.

-Tero
