From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: dra7: Add scm_conf1 node and remove
 redundant nodes
Date: Mon, 20 Jul 2015 15:04:44 +0300
Message-ID: <55ACE3DC.7070806@ti.com>
References: <1437140844-6032-1-git-send-email-rogerq@ti.com> <1437140844-6032-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437140844-6032-4-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/17/2015 04:47 PM, Roger Quadros wrote:
> scm_conf1 maps the control register address space after the
> padconf till the end.
>
> Fix the scm_conf and pmx_core resource lengths. We need to add
> 4 bytes to include the last 32-bit register space.
>
> Remove the redundant dra7_ctrl_core and dra7_ctrl_general nodes.
> They are not used by anyone and no longer needed as they are
> covered by scm_conf and scm_conf1.

Looks like you are doing three things in this patch, maybe split it up 
as such?

>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   arch/arm/boot/dts/dra7.dtsi | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 4a0718c..d07c34c 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -141,7 +141,7 @@
>   				dra7_pmx_core: pinmux@1400 {
>   					compatible = "ti,dra7-padconf",
>   						     "pinctrl-single";
> -					reg = <0x1400 0x0464>;
> +					reg = <0x1400 0x0468>;
>   					#address-cells = <1>;
>   					#size-cells = <0>;
>   					#interrupt-cells = <1>;
> @@ -149,6 +149,13 @@
>   					pinctrl-single,register-width = <32>;
>   					pinctrl-single,function-mask = <0x3fffffff>;
>   				};
> +
> +				scm_conf1: scm_conf@1 {

Should be ... scm_conf@1868?

Are there any users for this area anyway? I don't think we should map 
this area just for fun of it. Mostly it looks like this contains efuse 
values for OPPs, which should be mapped from the OPP layer, not as a 
generic syscon.

> +					compatible = "syscon";
> +					reg = <0x1868 0x03e0>;
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +				};
>   			};
>
>   			cm_core_aon: cm_core_aon@5000 {
> @@ -286,16 +293,6 @@
>   				#thermal-sensor-cells = <1>;
>   		};
>
> -		dra7_ctrl_core: ctrl_core@4a002000 {
> -			compatible = "syscon";
> -			reg = <0x4a002000 0x6d0>;
> -		};
> -
> -		dra7_ctrl_general: tisyscon@4a002e00 {
> -			compatible = "syscon";
> -			reg = <0x4a002e00 0x7c>;
> -		};

I thought I had removed these already and yes... this was done in commit 
d919501feffa8715147582c3ffce96fad0c7016f already, but seems they were 
added back in a resolution for a merge conflict later.

-Tero

> -
>   		sdma: dma-controller@4a056000 {
>   			compatible = "ti,omap4430-sdma";
>   			reg = <0x4a056000 0x1000>;
>
