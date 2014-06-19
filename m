From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 06/18] ARM: dts: DRA7: Add divider table to optfclk_pciephy_div
 clock
Date: Thu, 19 Jun 2014 14:10:36 +0300
Message-ID: <53A2C52C.6020606@ti.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com> <1401345500-20188-7-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1401345500-20188-7-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, tony@atomide.com, jg1.han@samsung.com, Keerthy <j-keerthy@ti.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On 05/29/2014 09:38 AM, Kishon Vijay Abraham I wrote:
> From: Keerthy <j-keerthy@ti.com>
>
> Add divider table to optfclk_pciephy_div clock. The Documentation
> for divider clock can be found at ../clock/ti/divider.txt

This patch requires a better changelog. Why is the change done, any TRM 
refs etc.?

-Tero

>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/dra7xx-clocks.dtsi |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> index c767687..55e95c5 100644
> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> @@ -1170,6 +1170,7 @@
>   		clocks = <&apll_pcie_ck>;
>   		#clock-cells = <0>;
>   		reg = <0x021c>;
> +		ti,dividers = <2>, <1>;
>   		ti,bit-shift = <8>;
>   		ti,max-div = <2>;
>   	};
>

