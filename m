From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: omap3-beagle-xm: fix string error in compatible
 property
Date: Wed, 14 Aug 2013 10:08:11 +0200
Message-ID: <520B3AEB.4030809@baylibre.com>
References: <1375884855-19414-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:62590 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab3HNIIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Aug 2013 04:08:15 -0400
Received: by mail-wg0-f51.google.com with SMTP id a12so7218025wgh.6
        for <linux-omap@vger.kernel.org>; Wed, 14 Aug 2013 01:08:13 -0700 (PDT)
In-Reply-To: <1375884855-19414-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Robert,

On 07/08/2013 16:14, Robert Nelson wrote:
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> ---
>   arch/arm/boot/dts/omap3-beagle-xm.dts |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index afdb164..0c514dc 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -11,7 +11,7 @@
>
>   / {
>   	model = "TI OMAP3 BeagleBoard xM";
> -	compatible = "ti,omap3-beagle-xm, ti,omap3-beagle", "ti,omap3";
> +	compatible = "ti,omap3-beagle-xm", "ti,omap3-beagle", "ti,omap3";

Thanks for the fix.

I'll apply it for -rc6.

Regards,
Benoit

