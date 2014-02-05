From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/3] arm: dts: am33xx.dtsi: Add node name to rtc device
 node
Date: Wed, 05 Feb 2014 21:29:37 +0300
Message-ID: <52F28311.20905@cogentembedded.com>
References: <1391602361-2666-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:40021 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbaBER3M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Feb 2014 12:29:12 -0500
Received: by mail-la0-f47.google.com with SMTP id hr17so577441lab.6
        for <linux-omap@vger.kernel.org>; Wed, 05 Feb 2014 09:29:11 -0800 (PST)
In-Reply-To: <1391602361-2666-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Lukas Stockmann <lukas.stockmann@siemens.com>, linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>

Hello.

On 02/05/2014 03:12 PM, Stefan Roese wrote:

> Making it possible to reference and therefor change (disable) this
> device node from other dts file which import this dtsi file.

> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Lukas Stockmann <lukas.stockmann@siemens.com>
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>   arch/arm/boot/dts/am33xx.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 6d95d3d..b8daf8c 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -399,7 +399,7 @@
>   			ti,timer-pwm;
>   		};
>
> -		rtc@44e3e000 {
> +		rtc: rtc@44e3e000 {

    Node name is "rtc@44e3e000" -- what you are adding is a label.

WBR, Sergei

