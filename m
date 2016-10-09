From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/4] ARM: dts: am33xx: add DMA properties for tscadc
Date: Sun, 9 Oct 2016 09:34:52 +0100
Message-ID: <b8272b0e-3051-445b-865e-968d2dac1a9f@kernel.org>
References: <20161005090443.24576-1-mugunthanvnm@ti.com>
 <20161005090443.24576-4-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161005090443.24576-4-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, John Syne <john3909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 05/10/16 10:04, Mugunthan V N wrote:
> Add DMA properties for tscadc
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Do the binding docs need updating to reflect this?  I can't immediately
find the relevant doc to check!

Jonathan
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 98748c6..6d607b8 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -917,6 +917,8 @@
>  			interrupts = <16>;
>  			ti,hwmods = "adc_tsc";
>  			status = "disabled";
> +			dmas = <&edma 53 0>, <&edma 57 0>;
> +			dma-names = "fifo0", "fifo1";
>  
>  			tsc {
>  				compatible = "ti,am3359-tsc";
> 
