From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ARM: dts: am57xx-idk: tpic2810 is on I2C bus, not SPI
Date: Wed, 15 Feb 2017 09:42:11 -0600
Message-ID: <504d1a9f-8c89-43b2-9a49-f130a21c50fd@ti.com>
References: <f884c250c4142ef44ec0c770aab277803f1f5da3.1487171304.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f884c250c4142ef44ec0c770aab277803f1f5da3.1487171304.git.nsekhar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 02/15/2017 09:12 AM, Sekhar Nori wrote:
> commit 50e95b6b854c ("ARM: dts: am57xx-idk: Add Industrial
> output support") added the TPIC2810 device-tree node under
> SPI bus instead of I2C1.
> 

Well that's odd, looks like git could get confused by the lack of
context around the node during rebases. Anyway,

Acked-by: Andrew F. Davis <afd@ti.com>

> Fix it. Tested on AM572x IDK by driving on-board LEDs
> connected to TPIC2810
> 
> Fixes: 50e95b6b854c ("ARM: dts: am57xx-idk: Add Industrial output support")
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  arch/arm/boot/dts/am57xx-idk-common.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
> index 814a720d5c3d..d0a55b845690 100644
> --- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
> +++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
> @@ -311,6 +311,13 @@
>  			/* ID & VBUS GPIOs provided in board dts */
>  		};
>  	};
> +
> +	tpic2810: tpic2810@60 {
> +		compatible = "ti,tpic2810";
> +		reg = <0x60>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
>  };
>  
>  &mcspi3 {
> @@ -326,13 +333,6 @@
>  		spi-max-frequency = <1000000>;
>  		spi-cpol;
>  	};
> -
> -	tpic2810: tpic2810@60 {
> -		compatible = "ti,tpic2810";
> -		reg = <0x60>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
>  };
>  
>  &uart3 {
> 
