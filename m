From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC PATCH 4/4] ARM: dts: am33xx: adopt to cpsw-phy-sel driver
 to configure phy mode
Date: Sun, 08 Sep 2013 22:04:05 +0400
Message-ID: <522CBC15.5060008@cogentembedded.com>
References: <1378639438-27686-1-git-send-email-mugunthanvnm@ti.com> <1378639438-27686-5-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:38672 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab3IHSEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Sep 2013 14:04:10 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so4248116lab.13
        for <linux-omap@vger.kernel.org>; Sun, 08 Sep 2013 11:04:08 -0700 (PDT)
In-Reply-To: <1378639438-27686-5-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev@vger.kernel.org, zonque@gmail.com, davem@davemloft.net, bcousson@baylibre.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org

Hello.

On 09/08/2013 03:23 PM, Mugunthan V N wrote:

> Add DT entries for the phy mode selection in AM33xx SoC using cpsw-phy-sel
> driver.

> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
>   arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)

> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index f9c5da9..4359672 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -594,6 +594,12 @@
>   				/* Filled in by U-Boot */
>   				mac-address = [ 00 00 00 00 00 00 ];
>   			};
> +
> +			phy_sel: cpsw_phy_sel@44e10650 {

    Dashes are preferred to uderscores in the device tree names.

> +				compatible = "ti,am3352-cpsw-phy-sel";
> +				reg= <0x44e10650 0x4>;
> +				reg-names = "gmii-sel";
> +			};

WBR, Sergei

