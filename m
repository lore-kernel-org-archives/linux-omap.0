From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 4/6] ARM: dts: omap5: add dwc3 omap dt data
Date: Sat, 26 Jan 2013 23:47:11 +0400
Message-ID: <510432BF.80808@mvista.com>
References: <1359112312-6918-1-git-send-email-kishon@ti.com> <1359112312-6918-5-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:41015 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab3AZTrc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Jan 2013 14:47:32 -0500
Received: by mail-lb0-f178.google.com with SMTP id n1so2321630lba.37
        for <linux-omap@vger.kernel.org>; Sat, 26 Jan 2013 11:47:30 -0800 (PST)
In-Reply-To: <1359112312-6918-5-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, s-guiriec@ti.com, gg@slimlogic.co.uk, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello.

On 25-01-2013 15:11, Kishon Vijay Abraham I wrote:

> Add dwc3 omap glue data to the omap5 dt data file. The information about
> the dt node added here is available @
> Documentation/devicetree/bindings/usb/omap-usb.txt

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/omap5.dtsi |   11 +++++++++++
>   1 file changed, 11 insertions(+)

> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 5f59bf2..1703a72 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -513,6 +513,17 @@
>   			ti,type = <2>;
>   		};
>
> +		omap_dwc3@4a020000 {
> +			compatible = "ti,dwc3";
> +			ti,hwmods = "usb_otg_ss";
> +			reg = <0x4a020000 0x1ff>;

    Shoudn't the "reg" length be 0x200 here? It's length, not limit.

WBR, Sergei

