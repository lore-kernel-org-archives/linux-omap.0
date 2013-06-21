From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv2 10/11] ARM: dts: omap4 clock data
Date: Thu, 20 Jun 2013 18:24:22 -0700
Message-ID: <51C3AB46.4040609@codeaurora.org>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com> <1371647942-4811-11-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:55139 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965258Ab3FUBYY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jun 2013 21:24:24 -0400
In-Reply-To: <1371647942-4811-11-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, mturquette@linaro.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 06/19/13 06:19, Tero Kristo wrote:
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 2a56428..70608db 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -106,6 +106,8 @@
>  			ti,hwmods = "counter_32k";
>  		};
>  
> +		/include/ "omap4-clocks.dtsi"
> +

Doesn't this cause one platform device to be allocated for each clock
node defined in omap4-clocks.dtsi? Are you concerned about wasting
memory on things that aren't really devices and that will never be probed?

>  		omap4_pmx_core: pinmux@4a100040 {
>  			compatible = "ti,omap4-padconf", "pinctrl-single";
>  			reg = <0x4a100040 0x0196>;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

