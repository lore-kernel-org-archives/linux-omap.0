From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: OMAP2-only kernel compile broken
Date: Sun, 10 Jul 2011 03:35:13 -0700
Message-ID: <4E198061.5060202@ti.com>
References: <alpine.DEB.2.00.1107091955040.15984@utopia.booyaka.com> <20110710095216.GN31978@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48767 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751935Ab1GJKfT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 10 Jul 2011 06:35:19 -0400
Received: by gxk21 with SMTP id 21so31582gxk.5
        for <linux-omap@vger.kernel.org>; Sun, 10 Jul 2011 03:35:17 -0700 (PDT)
In-Reply-To: <20110710095216.GN31978@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, hemahk@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

Felipe,

On 7/10/2011 2:52 AM, Felipe Balbi wrote:
> From: Felipe Balbi<balbi@ti.com>
> Date: Sun, 10 Jul 2011 12:22:20 +0300
> Subject: [PATCH] usb: musb: fix build breakage
> Organization: Texas Instruments\n
>
> This patch fixes the compilation brekage which
> commits 208466dc ("usb: otg:OMAP4430: Powerdown
> the internal PHY when USB is disabled") and
> fb91cde4 ("usb: musb: OMAP4430: Power down
> the PHY during board init") introduced when
> building a OMAP2-only kernel.
>
>    LD      .tmp_vmlinux1
> arch/arm/mach-omap2/built-in.o:(.data+0x7ce0): undefined reference to
> +`omap4430_phy_init'
> arch/arm/mach-omap2/built-in.o:(.data+0x7ce4): undefined reference to
> +`omap4430_phy_exit'
> arch/arm/mach-omap2/built-in.o:(.data+0x7ce8): undefined reference to
> +`omap4430_phy_power'
> arch/arm/mach-omap2/built-in.o:(.data+0x7cec): undefined reference to
> +`omap4430_phy_set_clk'
> arch/arm/mach-omap2/built-in.o:(.data+0x7cf0): undefined reference to
> +`omap4430_phy_suspend'
> make: *** [.tmp_vmlinux1] Error 1
>
> Cc:stable@kernel.org
> Reported-by: Paul Walmsley<paul@pwsan.com>
> Signed-off-by: Felipe Balbi<balbi@ti.com>
> ---
>   arch/arm/plat-omap/include/plat/usb.h |   14 ++++++++++++++
>   1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
> index 17d3c93..99dd64e 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -103,11 +103,25 @@ extern void usbhs_init(const struct usbhs_omap_board_data *pdata);
>   extern int omap_usbhs_enable(struct device *dev);
>   extern void omap_usbhs_disable(struct device *dev);
>
> +#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_OMAP3)
>   extern int omap4430_phy_power(struct device *dev, int ID, int on);
>   extern int omap4430_phy_set_clk(struct device *dev, int on);
>   extern int omap4430_phy_init(struct device *dev);
>   extern int omap4430_phy_exit(struct device *dev);
>   extern int omap4430_phy_suspend(struct device *dev, int suspend);
The comment is not related to this patch, but are above functions
limited to _omap4430_ only or omap446x may also need them. If the
phy is same on all OMAP4 devices, then another patch with renaming
all these functions to omap4_* should be done. Or even better is
make use of phy IP name itslef.

Regrads,
Santosh
