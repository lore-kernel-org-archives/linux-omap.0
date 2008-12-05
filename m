From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: Bug: enabling USB-TLL fclk
Date: Fri, 5 Dec 2008 15:05:35 -0800
Message-ID: <5e088bd90812051505x47cebc7dp7a863dbca66d40df@mail.gmail.com>
References: <a46a26fd0810221358l6153c0dat74f76af99fc8afaf@mail.gmail.com>
	 <a46a26fd0810221523y4a947442p6eb060192603b8f1@mail.gmail.com>
	 <a46a26fd0810231451n2095b03btc832c2a8b70d2749@mail.gmail.com>
	 <200810231516.32947.david-b@pacbell.net>
	 <FCCFB4CDC6E5564B9182F639FC35608702396F8AB7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:1803 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbYLEXFh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 18:05:37 -0500
Received: by yx-out-2324.google.com with SMTP id 8so135579yxm.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Dec 2008 15:05:35 -0800 (PST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702396F8AB7@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Oct 24, 2008 at 4:19 PM, Pandita, Vikram <vikram.pandita@ti.com> wrote:
>
> Paul
>
>  I was debugging why EHCI is not coming up and getting stuck in infinite loop for TLL not enabling.

EHCI is still broken on the current top of tree -- same infinite loop.

Have anyone figured out what is going wrong here?

Steve


> I found that there is issue with clock framework in enabling "usbtll_fck" clock.
>
> On enabling tll-fck clock, the framework returns error for the node:
>
> static struct clk dpll5_ck = {
>        .name           = "dpll5_ck",
>        .parent         = &sys_ck,
>        .prcm_mod       = PLL_MOD,
>        .dpll_data      = &dpll5_dd,
>        .flags          = CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
>        .enable         = &omap3_noncore_dpll_enable,
>        .disable        = &omap3_noncore_dpll_disable,
>        .round_rate     = &omap2_dpll_round_rate,
>        .set_rate       = &omap3_noncore_dpll_set_rate,
>        .clkdm          = { .name = "dpll5_clkdm" },
>        .recalc         = &omap3_dpll_recalc,
> };
>
>
> If I set the FCLK for USB-TLL directly as per following patch, EHCI works fine.
> Please check what is wrong with the above clock node.
>
> ---
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 419e70a..96b9df5 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -236,10 +236,9 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
>  #endif
>
>        /* Configure TLL for 60Mhz clk for ULPI */
> -       ehci_clocks->usbtll_fck_clk = clk_get(&dev->dev, USBHOST_TLL_FCLK);
> -       if (IS_ERR(ehci_clocks->usbtll_fck_clk))
> -               return PTR_ERR(ehci_clocks->usbtll_fck_clk);
> -       clk_enable(ehci_clocks->usbtll_fck_clk);
> +
> +       /* Force enable FCLK for USB-TLL */
> +       omap_writel(1<<2, 0x48004A08); /* CM_FCLKEN3_CORE */
>
>        ehci_clocks->usbtll_ick_clk = clk_get(&dev->dev, USBHOST_TLL_ICKL);
>        if (IS_ERR(ehci_clocks->usbtll_ick_clk))
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
