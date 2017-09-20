From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ARM: dts: am43xx-epos-evm: Enable SGX on EPOS boards
Date: Wed, 20 Sep 2017 10:15:55 -0500
Message-ID: <89572d33-01a1-52de-f2c5-2582b335a38e@ti.com>
References: <20170918173130.17657-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170918173130.17657-1-afd@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/18/2017 12:31 PM, Andrew F. Davis wrote:
> From: Yogesh Siraswar <yogeshs@ti.com>
> 
> The SGX IP is valid and usable on AM438x devices, enable this
> here.
> 
> Signed-off-by: Yogesh Siraswar <yogeshs@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
> index 9d276af7c539..17c081b2cff3 100644
> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> @@ -796,3 +796,7 @@
>  	assigned-clocks = <&mux_synctimer32k_ck>;
>  	assigned-clock-parents = <&clkdiv32k_ick>;
>  };
> +
> +&sgx {
> +	status = "okay";
> +};
> 

Didn't see the parent node didn't make upstream this cycle, ignore for
now, sorry for the noise.
