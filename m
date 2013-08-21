From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] ARM: DTS: SAMA5: Add PMU support
Date: Wed, 21 Aug 2013 11:18:09 +0200
Message-ID: <521485D1.8040308@atmel.com>
References: <1375716366-19121-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375716366-19121-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/08/2013 17:26, Alexandre Belloni :
> ARM Performance Monitor Units are available on the sama5d3, add the support in
> the dtsi.
>
> Tested with perf and oprofile on the sama5d31ek.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Stacked on at91-3.12-dt.

Thanks.

> ---
>   arch/arm/boot/dts/sama5d3.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index a1d5e25..afa68ac 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -48,6 +48,11 @@
>   		};
>   	};
>
> +       pmu {
> +               compatible = "arm,cortex-a5-pmu";
> +               interrupts = <46 IRQ_TYPE_LEVEL_HIGH 0>;
> +       };
> +
>   	memory {
>   		reg = <0x20000000 0x8000000>;
>   	};
>


-- 
Nicolas Ferre
