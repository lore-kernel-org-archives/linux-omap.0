From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 4/5] ARM: dts: dra7: Add updated operating-points-v2
 table for cpu
Date: Mon, 6 Mar 2017 17:23:48 +0100
Message-ID: <20170306172348.2832ba51@jawa>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
 <1488813822-26042-5-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488813822-26042-5-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, Yegor Yefremov <yegorslists@googlemail.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 6 Mar 2017 09:23:41 -0600
Dave Gerlach <d-gerlach@ti.com> wrote:

> After the ti-cpufreq driver has been added, we can now drop the
> operating-points table present in dra7.dtsi for the cpu and add an
> operating-points-v2 table with all OPPs available for all silicon
> revisions. Also add necessary data for use by ti-cpufreq to
> selectively enable the appropriate OPPs at runtime as part of the
> operating-points table.
> 
> As we now need to define voltage ranges for each OPP, we define the
> minimum and maximum voltage to match the ranges possible for AVS
> class0 voltage as defined by the DRA7/AM57 Data Manual, with the
> exception of using a range for OPP_OD based on historical data to
> ensure that SoCs from older lots still continue to boot, even though
> more optimal voltages are now the standard. Once an AVS Class0 driver
> is in place it will be possible for these OPP voltages to be adjusted
> to any voltage within the provided range.
> 
> Information from SPRS953, Revised December 2015.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Lukasz Majewski <lukma@denx.de>

> ---
>  arch/arm/boot/dts/dra7.dtsi   | 24 +++++++++++++++++++-----
>  arch/arm/boot/dts/dra74x.dtsi |  5 +++++
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 2c9e56f4aac5..e9dc314b0dcf 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -81,11 +81,7 @@
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
> @@ -99,6 +95,24 @@
>  		};
>  	};
>  
> +	cpu0_opp_table: opp-table {
> +		compatible = "operating-points-v2-ti-cpu";
> +		syscon = <&scm_wkup>;
> +
> +		opp_nom@1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <1060000 850000 1150000>;
> +			opp-supported-hw = <0xFF 0x01>;
> +			opp-suspend;
> +		};
> +
> +		opp_od@1176000000 {
> +			opp-hz = /bits/ 64 <1176000000>;
> +			opp-microvolt = <1160000 885000 1160000>;
> +			opp-supported-hw = <0xFF 0x02>;
> +		};
> +	};
> +
>  	/*
>  	 * The soc node represents the soc top level view. It is
> used for IPs
>  	 * that are not memory mapped in the MPU view or for the MPU
> itself. diff --git a/arch/arm/boot/dts/dra74x.dtsi
> b/arch/arm/boot/dts/dra74x.dtsi index 0a78347e6615..24e6746c5b26
> 100644 --- a/arch/arm/boot/dts/dra74x.dtsi
> +++ b/arch/arm/boot/dts/dra74x.dtsi
> @@ -17,6 +17,7 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <1>;
> +			operating-points-v2 = <&cpu0_opp_table>;
>  		};
>  	};
>  
> @@ -79,6 +80,10 @@
>  	};
>  };
>  
> +&cpu0_opp_table {
> +	opp-shared;
> +};
> +
>  &dss {
>  	reg = <0x58000000 0x80>,
>  	      <0x58004054 0x4>,




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
