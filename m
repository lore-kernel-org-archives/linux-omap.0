From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH RESEND] omap3: Fix EHCI port for IGEP v2 board.
Date: Tue, 16 Mar 2010 08:55:35 +0200
Message-ID: <20100316065535.GB5438@nokia.com>
References: <1267455756-5081-1-git-send-email-eballetbo@gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19566 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734Ab0CPG4s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Mar 2010 02:56:48 -0400
Content-Disposition: inline
In-Reply-To: <1267455756-5081-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

On Mon, Mar 01, 2010 at 04:02:36PM +0100, ext Enric Balletbo i Serra wrote:
>From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
>
>IGEP v2 uses EHCI port 1 instead of EHCI port 2.
>
>Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>

I'm happy with the explanation:

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

>---
> arch/arm/mach-omap2/board-igep0020.c |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
>index 3c7789d..d55c57b 100644
>--- a/arch/arm/mach-omap2/board-igep0020.c
>+++ b/arch/arm/mach-omap2/board-igep0020.c
>@@ -458,13 +458,13 @@ static struct omap_musb_board_data musb_board_data = {
> };
>
> static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
>-	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
>-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
>+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
>+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
>
> 	.phy_reset = true,
>-	.reset_gpio_port[0] = -EINVAL,
>-	.reset_gpio_port[1] = IGEP2_GPIO_USBH_NRESET,
>+	.reset_gpio_port[0] = IGEP2_GPIO_USBH_NRESET,
>+	.reset_gpio_port[1] = -EINVAL,
> 	.reset_gpio_port[2] = -EINVAL,
> };
>
>-- 
>1.5.4.3
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
