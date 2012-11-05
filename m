From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH V2 3/3] ARM: dts: omap5-evm: LPDDR2 memory device details
 for EVM
Date: Mon, 5 Nov 2012 12:02:21 +0100
Message-ID: <50979CBD.8010901@ti.com>
References: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com> <1349959669-16366-4-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58040 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab2KELCi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 06:02:38 -0500
In-Reply-To: <1349959669-16366-4-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 10/11/2012 02:47 PM, Lokesh Vutla wrote:
> Samsung's K3PE0E000B memory part is used in OMAP5-evm board.
> Adding timings and geometry details for Samsung's memory part and
> attaching the same to device-handle of EMIF1/2.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  arch/arm/boot/dts/omap5-evm.dts           |   11 +++++
>  arch/arm/boot/dts/samsung_k3pe0e000b.dtsi |   67 +++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
> 
> diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
> index 6f87e1a..ed1d1b5 100644
> --- a/arch/arm/boot/dts/omap5-evm.dts
> +++ b/arch/arm/boot/dts/omap5-evm.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>  
>  /include/ "omap5.dtsi"
> +/include/ "samsung_k3pe0e000b.dtsi"
>  
>  / {
>  	model = "TI OMAP5 EVM board";
> @@ -82,3 +83,13 @@
>  			0x020700d9>;	/* SEARCH */
>  	linux,input-no-autorepeat;
>  };
> +
> +&emif1 {
> +	cs1-used;
> +	device-handle = <&samsung_K3PE0E000B>;
> +};
> +
> +&emif2 {
> +	cs1-used;
> +	device-handle = <&samsung_K3PE0E000B>;
> +};
> diff --git a/arch/arm/boot/dts/samsung_k3pe0e000b.dtsi b/arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
> new file mode 100644
> index 0000000..b352d69
> --- /dev/null
> +++ b/arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
> @@ -0,0 +1,67 @@
> +/*
> + * Timings and Geometry for Samsung K3PE0E000B memory part
> + */
> +
> +/ {
> +	samsung_K3PE0E000B: lpddr2 {
> +		compatible	= "Samsung,K3PE0E000B","jedec,lpddr2-s4";
> +		density		= <4096>;
> +		io-width	= <32>;
> +
> +		tRPab-min-tck	= <3>;
> +		tRCD-min-tck	= <3>;
> +		tWR-min-tck	= <3>;
> +		tRASmin-min-tck	= <3>;
> +		tRRD-min-tck	= <2>;
> +		tWTR-min-tck	= <2>;
> +		tXP-min-tck	= <2>;
> +		tRTP-min-tck	= <2>;
> +		tCKE-min-tck	= <3>;
> +		tCKESR-min-tck	= <3>;
> +		tFAW-min-tck	= <8>;
> +
> +		timings_samsung_K3PE0E000B_533mhz: lpddr2-timings@0 {

Nit, but the official unit is: MHz [1].


Regards,
Benoit

[1] http://www.bipm.org/utils/common/pdf/si_brochure_8_en.pdf

