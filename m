From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 1/2] DTS: dra7: Replace obsolete "operating-points"
 property with "operating-points-v2"
Date: Fri, 3 Feb 2017 10:54:54 -0600
Message-ID: <9f5ef6ed-add0-098f-a380-c859a6839c0a@ti.com>
References: <1486135491-14223-1-git-send-email-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486135491-14223-1-git-send-email-lukma@denx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lukasz Majewski <lukma@denx.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
On 02/03/2017 09:24 AM, Lukasz Majewski wrote:
> The "operating-points" property have been replaced with
> "operating-points-v2". Only entries with the same frequencies have
> been added, so no reqression should be introduced.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 3c228f9..a860a56 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -80,11 +80,7 @@
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
>
> -			operating-points = <
> -				/* kHz    uV */
> -				1000000	1060000
> -				1176000	1160000
> -				>;
> +			operating-points-v2 = <&cpu0_opp_table>;
>
>  			clocks = <&dpll_mpu_ck>;
>  			clock-names = "cpu";
> @@ -98,6 +94,22 @@
>  		};
>  	};
>
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp_nom@1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <1060000 850000 1150000>;
> +			opp-suspend;
> +		};
> +
> +		opp_od@1176000000 {
> +			opp-hz = /bits/ 64 <1176000000>;
> +			opp-microvolt = <1160000 885000 1160000>;
> +		};
> +	};
> +

This is being done here already [1] as these OPPs have specific requirements 
depending on the SoC in use. I have sent proper operating-points-v2 tables here 
[2] already, they won't be ready to merge until after the driver at [1] is merged.

Regards,
Dave

[1] http://www.spinics.net/lists/devicetree/msg158967.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/430209.html

>  	/*
>  	 * The soc node represents the soc top level view. It is used for IPs
>  	 * that are not memory mapped in the MPU view or for the MPU itself.
>
