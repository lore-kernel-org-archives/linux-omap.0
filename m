From: Keerthy <a0393675@ti.com>
Subject: Re: [tiL4.4-P PATCH] ARM: dts: am437x-sk-evm: Reduce i2c0 bus speed
 for tps65218
Date: Wed, 15 Jun 2016 11:45:02 +0530
Message-ID: <5760F266.5060309@ti.com>
References: <1465971211-15994-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465971211-15994-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, tony@atomide.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, d-gerlach@ti.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>, Aparna Balasubramanian <aparnab@ti.com>
List-Id: linux-omap@vger.kernel.org



On Wednesday 15 June 2016 11:43 AM, Keerthy wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
>
> Based on the latest timing specifications for the TPS65218 from the data
> sheet, http://www.ti.com/lit/ds/symlink/tps65218.pdf, document SLDS206
> from November 2014, we must change the i2c bus speed to better fit within
> the minimum high SCL time required for proper i2c transfer.
>
> When running at 400khz, measurements show that SCL spends
> 0.8125 uS/1.666 uS high/low which violates the requirement for minimum
> high period of SCL provided in datasheet Table 7.6 which is 1 uS.
> Switching to 100khz gives us 5 uS/5 uS high/low which both fall above
> the minimum given values for 100 khz, 4.0 uS/4.7 uS high/low.
>
> Without this patch occasionally a voltage set operation from the kernel
> will appear to have worked but the actual voltage reflected on the PMIC
> will not have updated, causing problems especially with cpufreq that may
> update to a higher OPP without actually raising the voltage on DCDC2,
> leading to a hang.

I will resend with proper $Subject. Sorry for the noise. Please ignore 
this patch.

>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Signed-off-by: Aparna Balasubramanian <aparnab@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   arch/arm/boot/dts/am437x-sk-evm.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> index 18a3445..5f67001 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -490,7 +490,7 @@
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c0_pins>;
> -	clock-frequency = <400000>;
> +	clock-frequency = <100000>;
>
>   	tps@24 {
>   		compatible = "ti,tps65218";
>
