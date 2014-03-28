From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH V3 5/6] ARM: am4372.dtsi: add omapdss information
Date: Fri, 28 Mar 2014 15:24:39 +0530
Message-ID: <533546DF.2000301@ti.com>
References: <1395658916-9032-1-git-send-email-sathyap@ti.com> <1395658916-9032-6-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40620 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbaC1Jym (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 05:54:42 -0400
In-Reply-To: <1395658916-9032-6-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

On Monday 24 March 2014 04:31 PM, Sathya Prakash M R wrote:
> Add DT data for the display subsystem, which contains the following
> blocks:
>     dss - the wrapper/glue for the display modules
>     dispc - display controller
>     rfbi - MIPI DBI encoder
> dss subsystem of am43x is re use from omap3.
> 
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi |   35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index ea55a4e..58fb78b 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -684,6 +684,41 @@
>  			num-cs = <4>;
>                          status = "disabled";
>                  };
> +
> +		dss: dss@4832A000 {
> +			compatible = "ti,omap3-dss", "simple-bus";
> +			reg = <0x4832A000 0x200>;

We use lower case hex numbers in kernel and even in dts files.

Thanks,
Sekhar

