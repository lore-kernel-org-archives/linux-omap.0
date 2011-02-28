From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 09/10] usb: host: omap: ehci and ohci simplification
Date: Mon, 28 Feb 2011 10:09:19 +0200
Message-ID: <20110228080919.GD2459@legolas.emea.dhcp.ti.com>
References: <1298675198-14214-1-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-2-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-3-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-4-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-5-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-6-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-7-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-8-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-9-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-10-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:36983 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752597Ab1B1IJY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 03:09:24 -0500
Content-Disposition: inline
In-Reply-To: <1298675198-14214-10-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, p-basak2@ti.com

Hi,

On Sat, Feb 26, 2011 at 04:36:37AM +0530, Keshava Munegowda wrote:
> @@ -148,137 +52,24 @@
>  #define	EHCI_INSNREG05_ULPI_EXTREGADD_SHIFT		8
>  #define	EHCI_INSNREG05_ULPI_WRDATA_SHIFT		0
>  
> -/* Values of UHH_REVISION - Note: these are not given in the TRM */
> -#define OMAP_EHCI_REV1	0x00000010	/* OMAP3 */
> -#define OMAP_EHCI_REV2	0x50700100	/* OMAP4 */
> +/*-------------------------------------------------------------------------*/
>  
> -#define is_omap_ehci_rev1(x)	(x->omap_ehci_rev == OMAP_EHCI_REV1)
> -#define is_omap_ehci_rev2(x)	(x->omap_ehci_rev == OMAP_EHCI_REV2)
> +static const struct hc_driver ehci_omap_hc_driver;
>  
> -#define is_ehci_phy_mode(x)	(x == OMAP_EHCI_PORT_MODE_PHY)
> -#define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
> -#define is_ehci_hsic_mode(x)	(x == OMAP_EHCI_PORT_MODE_HSIC)
>  
> -/*-------------------------------------------------------------------------*/
> -
> -static inline void ehci_omap_writel(void __iomem *base, u32 reg, u32 val)
> +static inline void ehci_write(void __iomem *base, u32 reg, u32 val)
>  {
>  	__raw_writel(val, base + reg);
>  }
>  
> -static inline u32 ehci_omap_readl(void __iomem *base, u32 reg)
> +static inline u32 ehci_read(void __iomem *base, u32 reg)

renaming these functions is not part of this patch.

-- 
balbi
