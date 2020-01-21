From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] dt-bindings: clock: Move ti-dra7-atl.h to
 dt-bindigs/clock
Date: Tue, 21 Jan 2020 09:32:01 +0200
Message-ID: <bbb7386a-4f5d-6574-c971-0812f0272450@ti.com>
References: <20191114101817.20831-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20191114101817.20831-1-peter.ujfalusi@ti.com>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, mturquette@baylibre.com, robh+dt@kernel.org
Cc: sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 14/11/2019 12:18, Peter Ujfalusi wrote:
> Most of the clock related dt-binding header files are located in
> dt-bindings/clock folder. It would be good to keep all the similar
> header files at a single location.
> 
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Queued up towards 5.6, thanks.

-Tero

> ---
>   Documentation/devicetree/bindings/clock/ti/dra7-atl.txt | 4 ++--
>   arch/arm/boot/dts/dra7-evm-common.dtsi                  | 2 +-
>   arch/arm/boot/dts/dra72-evm-common.dtsi                 | 2 +-
>   include/dt-bindings/{clk => clock}/ti-dra7-atl.h        | 0
>   4 files changed, 4 insertions(+), 4 deletions(-)
>   rename include/dt-bindings/{clk => clock}/ti-dra7-atl.h (100%)
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/dra7-atl.txt b/Documentation/devicetree/bindings/clock/ti/dra7-atl.txt
> index 10f7047755f3..21c002d28b9b 100644
> --- a/Documentation/devicetree/bindings/clock/ti/dra7-atl.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/dra7-atl.txt
> @@ -43,7 +43,7 @@ Configuration of ATL instances:
>   	- aws : Audio word select signal selection
>   };
>   
> -For valid word select signals, see the dt-bindings/clk/ti-dra7-atl.h include
> +For valid word select signals, see the dt-bindings/clock/ti-dra7-atl.h include
>   file.
>   
>   Examples:
> @@ -83,7 +83,7 @@ atl: atl@4843c000 {
>   	clock-names = "fck";
>   };
>   
> -#include <dt-bindings/clk/ti-dra7-atl.h>
> +#include <dt-bindings/clock/ti-dra7-atl.h>
>   
>   &atl {
>   
> diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
> index 82eeba8faef1..23244b5a9942 100644
> --- a/arch/arm/boot/dts/dra7-evm-common.dtsi
> +++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
> @@ -4,7 +4,7 @@
>    */
>   
>   #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/clk/ti-dra7-atl.h>
> +#include <dt-bindings/clock/ti-dra7-atl.h>
>   #include <dt-bindings/input/input.h>
>   
>   / {
> diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
> index 8641a3d7d8ad..9eabfd1502da 100644
> --- a/arch/arm/boot/dts/dra72-evm-common.dtsi
> +++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
> @@ -6,7 +6,7 @@
>   
>   #include "dra72x.dtsi"
>   #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/clk/ti-dra7-atl.h>
> +#include <dt-bindings/clock/ti-dra7-atl.h>
>   
>   / {
>   	compatible = "ti,dra72-evm", "ti,dra722", "ti,dra72", "ti,dra7";
> diff --git a/include/dt-bindings/clk/ti-dra7-atl.h b/include/dt-bindings/clock/ti-dra7-atl.h
> similarity index 100%
> rename from include/dt-bindings/clk/ti-dra7-atl.h
> rename to include/dt-bindings/clock/ti-dra7-atl.h
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
