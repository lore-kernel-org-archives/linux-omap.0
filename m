From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH 1/2] OMAP4: otg: phy: fix charger detection
Date: Fri, 3 Aug 2012 14:31:28 +0530
Message-ID: <CAAe_U6+w8VbYcCXDZ6wPzu4hrF-MSpXdArz6nogPbfZ0m2E=Ag@mail.gmail.com>
References: <1341477720-6771-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:44373 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753056Ab2HCJBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 05:01:31 -0400
Received: by weyx56 with SMTP id x56so265325wey.41
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 02:01:29 -0700 (PDT)
In-Reply-To: <1341477720-6771-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi,

On Thu, Jul 5, 2012 at 2:12 PM, Ruslan Bilovol <ruslan.bilovol@ti.com> wrote:
> Charger detection feature is not correctly used
> and thus makes some regressions if OTG was used in
> the host mode. Charger detection takes 500 ms so
> if some device is attached to the host after 500 ms
> it will be suddenly resetted.
>
> This feature is enabled by default after reset/cold boot
> so always affects PHY usage. So finally this was wrongly
> interpreted as "phy requires 200ms to start".
> After fixing this we can safely remove uggly mdelay after
> powering on the PHY.
>
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> ---
>  arch/arm/mach-omap2/omap_phy_internal.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
> index d52651a..a13a37c 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -42,12 +42,16 @@
>  #define        SESSEND                         BIT(3)
>  #define        IDDIG                           BIT(4)
>
> +#define CONTROL_USB2PHYCORE            0x620
> +#define USB2PHY_DISCHGDET              BIT(30)
> +
>  static struct clk *phyclk, *clk48m, *clk32k;
>  static void __iomem *ctrl_base;
>  static int usbotghs_control;
>
>  int omap4430_phy_init(struct device *dev)
>  {
> +       u32 usb2phycore;
>         ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
>         if (!ctrl_base) {
>                 pr_err("control module ioremap failed\n");
> @@ -56,6 +60,11 @@ int omap4430_phy_init(struct device *dev)
>         /* Power down the phy */
>         __raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>
> +       /* Disable charger detection by default */
> +       usb2phycore = omap4_ctrl_pad_readl(CONTROL_USB2PHYCORE);
> +       usb2phycore |= USB2PHY_DISCHGDET;
> +       omap4_ctrl_pad_writel(usb2phycore, CONTROL_USB2PHYCORE);

Maybe I failed to understand correctly but the $subject says it
*fixes* charger detection but the patch *disables* charger detection.

-Kishon
