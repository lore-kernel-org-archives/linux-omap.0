From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/6 v2] omap: musb: ti81xx: Add phy power function
Date: Thu, 08 Sep 2011 14:45:33 +0400
Message-ID: <4E689CCD.2050708@ru.mvista.com>
References: <1315414945-19829-1-git-send-email-ajay.gupta@ti.com> <1315414945-19829-4-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51425 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758223Ab1IHKqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 06:46:20 -0400
In-Reply-To: <1315414945-19829-4-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, tony@atomide.com, Ravi Babu <ravibabu@ti.com>

Hello.

On 07-09-2011 21:02, Ajay Kumar Gupta wrote:

> Adding ti81xx_musb_phy_power() which will be used by musb driver through
> its function pointer in board_data.

> Signed-off-by: Ajay Kumar Gupta<ajay.gupta@ti.com>
> Signed-off-by: Ravi Babu<ravibabu@ti.com>
> ---
>   arch/arm/mach-omap2/omap_phy_internal.c |   24 +++++++++++++++++++++++
>   arch/arm/plat-omap/include/plat/usb.h   |   32 +++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
> index 58775e3..352b6af 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -260,3 +260,27 @@ void am35x_set_mode(u8 musb_mode)
>
>   	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
>   }
> +
> +void ti81xx_musb_phy_power(u8 on)
> +{
> +	u32 usbphycfg = omap_ctrl_readl(USBCTRL0);
> +
> +	if (on) {
> +		if (cpu_is_ti816x()) {
> +			usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
> +			usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
> +		} else if (cpu_is_ti814x()) {
> +			usbphycfg&= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
> +				| USBPHY_DPINPUT | USBPHY_DMINPUT);
> +			usbphycfg |= (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
> +				| USBPHY_DPOPBUFCTL | USBPHY_DPOPBUFCTL);

    Same #define repeated twice?

WBR, Sergei
