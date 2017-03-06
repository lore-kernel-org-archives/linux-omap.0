From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 3/5] ARM: dts: am4372: Update operating-points-v2 table
 for cpu
Date: Mon, 6 Mar 2017 17:03:58 +0100
Message-ID: <20170306170358.52a3ff37@jawa>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
 <1488813822-26042-4-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488813822-26042-4-git-send-email-d-gerlach@ti.com>
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

On Mon, 6 Mar 2017 09:23:40 -0600
Dave Gerlach <d-gerlach@ti.com> wrote:

> The operatings-points-v2 table for am4372 was merged before any user
> of it was present in the kernel and before the binding had been
> finalized. The new ti-cpufreq driver and binding expects the platform
> specific properties to be part of the operating-points-v2 table
> rather than the cpu node so let's move them there as the only user is
> the ti-cpufreq driver.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Lukasz Majewski <lukma@denx.de>

> ---
>  arch/arm/boot/dts/am4372.dtsi | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi
> b/arch/arm/boot/dts/am4372.dtsi index 97fcaf415de1..176e09e9a45e
> 100644 --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -50,15 +50,14 @@
>  			clock-names = "cpu";
>  
>  			operating-points-v2 = <&cpu0_opp_table>;
> -			ti,syscon-efuse = <&scm_conf 0x610 0x3f 0>;
> -			ti,syscon-rev = <&scm_conf 0x600>;
>  
>  			clock-latency = <300000>; /* From
> omap-cpufreq driver */ };
>  	};
>  
> -	cpu0_opp_table: opp_table0 {
> -		compatible = "operating-points-v2";
> +	cpu0_opp_table: opp-table {
> +		compatible = "operating-points-v2-ti-cpu";
> +		syscon = <&scm_conf>;
>  
>  		opp50@300000000 {
>  			opp-hz = /bits/ 64 <300000000>;




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
