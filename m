From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ARM: dts: add AM33XX EDMA support
Date: Sat, 24 Aug 2013 22:02:01 +0400
Message-ID: <5218F519.3040409@cogentembedded.com>
References: <1377284808-32412-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377284808-32412-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Benoit Cousson <bcousson@baylibre.com>, tony@atomide.com, devicetree@vger.kernel.org, Matt Porter <mporter@ti.com>, Joel Fernandes <joelf@ti.com>, Matt Porter <mdp@ti.com>, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Joel A Fernandes <joelagnel@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 08/23/2013 11:06 PM, Sebastian Andrzej Siewior wrote:

> From: Matt Porter <mdp@ti.com>

> Adds AM33XX EDMA support to the am33xx.dtsi as documented in
> Documentation/devicetree/bindings/dma/ti-edma.txt

> Joel: Drop DT entries that are non-hardware-description for now as discussed in [1]

> [1] https://patchwork.kernel.org/patch/2226761/

> Signed-off-by: Matt Porter <mporter@ti.com>
> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Could someone please pick this up?

>   arch/arm/boot/dts/am33xx.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 38b446b..784f774 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -96,6 +96,18 @@
>   			reg = <0x48200000 0x1000>;
>   		};
>
> +		edma: edma@49000000 {

    The node should be named "dma-controller", not "edma",according to ePAPR 
section 2.2.2:

http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
