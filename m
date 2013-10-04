From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 2/2] ARM: dts: am335x-evm, am335x-evmsdk: switch mmc1
 to 4-bit mode
Date: Fri, 04 Oct 2013 15:02:08 +0200
Message-ID: <524EBC50.20207@baylibre.com>
References: <1380281710-12728-1-git-send-email-balajitk@ti.com> <1380281710-12728-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:42257 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab3JDNCL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Oct 2013 09:02:11 -0400
Received: by mail-wi0-f170.google.com with SMTP id cb5so2285907wib.3
        for <linux-omap@vger.kernel.org>; Fri, 04 Oct 2013 06:02:10 -0700 (PDT)
In-Reply-To: <1380281710-12728-2-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, nm@ti.com, koen@dominion.thruhere.net

Hi Balaji,

On 27/09/2013 13:35, Balaji T K wrote:
> set bus-width to make SD card operate in 4 bit mode.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
> based on git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.13/dts
>
>   arch/arm/boot/dts/am335x-evm.dts   |    1 +
>   arch/arm/boot/dts/am335x-evmsk.dts |    1 +
>   2 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 23b0a3e..028ca09 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -521,4 +521,5 @@
>   &mmc1 {
>   	status = "okay";
>   	vmmc-supply = <&vmmc_reg>;
> +	bus-width = <4>;
>   };
> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> index bc93895..563a2b1 100644
> --- a/arch/arm/boot/dts/am335x-evmsk.dts
> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> @@ -423,4 +423,5 @@
>   &mmc1 {
>   	status = "okay";
>   	vmmc-supply = <&vmmc_reg>;
> +	bus-width = <4>;
>   };
>

Thanks, I'll apply it for 3.13.

Regards,
Benoit
