From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/1] arm: dts: am33xx: correcting dt node unit address
 for usb
Date: Sat, 31 Aug 2013 21:42:06 +0400
Message-ID: <52222AEE.2090607@cogentembedded.com>
References: <1377885140-3529-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:58272 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743Ab3HaRmE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Aug 2013 13:42:04 -0400
Received: by mail-lb0-f179.google.com with SMTP id x18so2826961lbi.10
        for <linux-omap@vger.kernel.org>; Sat, 31 Aug 2013 10:42:02 -0700 (PDT)
In-Reply-To: <1377885140-3529-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: balbi@ti.com, bigeasy@linutronix.de, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

On 08/30/2013 09:52 PM, Mugunthan V N wrote:

> DT node's unit address should be its own register offset address to make it a
> unique across the system. This patch corrects the incorrect USB entries with
> correct register offset for unit address.

> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
>   arch/arm/boot/dts/am33xx.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index f9c5da9..e9b6775 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
[...]
> @@ -449,7 +449,7 @@
>   					"tx14", "tx15";
>   			};
>
> -			cppi41dma: dma-controller@07402000 {
> +			cppi41dma: dma-controller@47402000 {

    Not @47400000? Look at the first entry in the "reg" prop.

>   				compatible = "ti,am3359-cppi41";
>   				reg =  <0x47400000 0x1000
>   					0x47402000 0x1000

WBR, Sergei

