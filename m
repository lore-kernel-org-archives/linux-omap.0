From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 1/2] ARM: dts: am335x-bone-common: correct mux mode for
 cmd line
Date: Fri, 04 Oct 2013 15:01:44 +0200
Message-ID: <524EBC38.60306@baylibre.com>
References: <1380281710-12728-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:55027 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab3JDNBr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Oct 2013 09:01:47 -0400
Received: by mail-we0-f181.google.com with SMTP id p61so4397015wes.40
        for <linux-omap@vger.kernel.org>; Fri, 04 Oct 2013 06:01:46 -0700 (PDT)
In-Reply-To: <1380281710-12728-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, nm@ti.com, koen@dominion.thruhere.net

Hi Balaji,

On 27/09/2013 13:35, Balaji T K wrote:
> pinmux_emmc_pins: mux mode for cmd line should be MODE2
> to detect eMMC on beagle bone black and beagle bone white + eMMC cape.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Tested-by: Felipe Balbi <balbi@ti.com>
> ---
> based on git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.13/dts
>
>   arch/arm/boot/dts/am335x-bone-common.dtsi |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index ff5c3ca..51f6a99 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -153,7 +153,7 @@
>   	emmc_pins: pinmux_emmc_pins {
>   		pinctrl-single,pins = <
>   			0x80 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
> -			0x84 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_csn2.mmc1_cmd */
> +			0x84 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
>   			0x00 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
>   			0x04 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
>   			0x08 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
>

Thanks, I'll apply it for 3.13.

Regards,
Benoit

