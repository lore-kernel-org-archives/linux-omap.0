From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [RESEND][PATCH] ARM: OMAP: devicetree: fix SPI node compatible
 property syntax items
Date: Fri, 8 Nov 2013 09:18:56 +0530
Message-ID: <527C5F28.40007@ti.com>
References: <1383831938-9402-1-git-send-email-ewitcher@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39072 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652Ab3KHDtF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Nov 2013 22:49:05 -0500
In-Reply-To: <1383831938-9402-1-git-send-email-ewitcher@mindspring.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Witcher <ewitcher@mindspring.com>
Cc: robherring2@gmail.com, bcousson@baylibre.com, matt.porter@linaro.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Thursday 07 November 2013 07:15 PM, Eric Witcher wrote:
> Correct the SPI node compatible property items to match example code and
> match current DTS usage.
>
> Signed-off-by: Eric Witcher<ewitcher@mindspring.com>
> ---
>   Documentation/devicetree/bindings/spi/omap-spi.txt | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
> index 4c85c4c..2ba5f9c 100644
> --- a/Documentation/devicetree/bindings/spi/omap-spi.txt
> +++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
> @@ -2,8 +2,8 @@ OMAP2+ McSPI device
>
>   Required properties:
>   - compatible :
> -  - "ti,omap2-spi" for OMAP2&  OMAP3.
> -  - "ti,omap4-spi" for OMAP4+.
> +  - "ti,omap2-mcspi" for OMAP2&  OMAP3.
> +  - "ti,omap4-mcspi" for OMAP4+.
>   - ti,spi-num-cs : Number of chipselect supported  by the instance.
>   - ti,hwmods: Name of the hwmod associated to the McSPI
>   - ti,pindir-d0-out-d1-in: Select the D0 pin as output and D1 as
Acked-by: Sourav Poddar <sourav.poddar@ti.com>
