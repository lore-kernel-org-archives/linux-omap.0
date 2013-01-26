From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 5/6] ARM: dts: omap5: add dwc3 core dt data
Date: Sat, 26 Jan 2013 23:49:07 +0400
Message-ID: <51043333.6030208@mvista.com>
References: <1359112312-6918-1-git-send-email-kishon@ti.com> <1359112312-6918-6-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:55762 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab3AZTt1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Jan 2013 14:49:27 -0500
Received: by mail-la0-f41.google.com with SMTP id fo12so279821lab.14
        for <linux-omap@vger.kernel.org>; Sat, 26 Jan 2013 11:49:25 -0800 (PST)
In-Reply-To: <1359112312-6918-6-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, s-guiriec@ti.com, gg@slimlogic.co.uk, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 25-01-2013 15:11, Kishon Vijay Abraham I wrote:

> Add dwc3 core dt data as a subnode to dwc3 omap glue data in omap5 dt
> data file. The information for the entered data node is available @
> Documentation/devicetree/bindings/usb/dwc3.txt

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/omap5.dtsi |    7 +++++++
>   1 file changed, 7 insertions(+)

> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 1703a72..58118c4 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -522,6 +522,13 @@
>   			#size-cells = <1>;
>   			utmi-mode = <2>;
>   			ranges;
> +			dwc3@4a030000 {
> +				compatible = "synopsys,dwc3";
> +				reg = <0x4a030000 0xcfff>;

    Same question here.

WBR, Sergei

