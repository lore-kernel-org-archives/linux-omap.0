From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] ehci: fix ehci pin mux init
Date: Thu, 6 Aug 2009 15:40:45 +0300
Message-ID: <20090806124044.GN2358@atomide.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52310 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZHFMkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 08:40:51 -0400
Content-Disposition: inline
In-Reply-To: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, david-b@pacbell.net

Hi,

* Ajay Kumar Gupta <ajay.gupta@ti.com> [090806 15:13]:
> EHCI pin mux init fucntion is still using old #ifdef which are not defined
> anymore.This causes pin mux init to always set TLL settings and thus EHCI
> PHY mode doesn't work.
> 
> Fixing this issue by using phy_mode parameter to initialize mux settings.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/usb-ehci.c |  167 ++++++++++++++++++++--------------------
>  1 files changed, 83 insertions(+), 84 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
> index 0fe26f2..53e6e85 100644
> --- a/arch/arm/mach-omap2/usb-ehci.c
> +++ b/arch/arm/mach-omap2/usb-ehci.c
> @@ -68,90 +68,89 @@ static struct platform_device ehci_device = {
>  /*
>   * setup_ehci_io_mux - initialize IO pad mux for USBHOST
>   */
> -static void setup_ehci_io_mux(void)
> +static void setup_ehci_io_mux(enum ehci_hcd_omap_mode phy_mode)
>  {
> -#ifdef CONFIG_OMAP_EHCI_PHY_MODE
> -	/* PHY mode of operation for board: 750-2083-001
> -	 * ISP1504 connected to Port1 and Port2
> -	 * Do Func Mux setting for 12-pin ULPI PHY mode
> -	 */
> -
> -	/* Port1 */
> -	omap_cfg_reg(Y9_3430_USB1HS_PHY_STP);
> -	omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK);
> -	omap_cfg_reg(AA14_3430_USB1HS_PHY_DIR);
> -	omap_cfg_reg(AA11_3430_USB1HS_PHY_NXT);
> -	omap_cfg_reg(W13_3430_USB1HS_PHY_DATA0);
> -	omap_cfg_reg(W12_3430_USB1HS_PHY_DATA1);
> -	omap_cfg_reg(W11_3430_USB1HS_PHY_DATA2);
> -	omap_cfg_reg(Y11_3430_USB1HS_PHY_DATA3);
> -	omap_cfg_reg(W9_3430_USB1HS_PHY_DATA4);
> -	omap_cfg_reg(Y12_3430_USB1HS_PHY_DATA5);
> -	omap_cfg_reg(W8_3430_USB1HS_PHY_DATA6);
> -	omap_cfg_reg(Y13_3430_USB1HS_PHY_DATA7);
> -
> -	/* Port2 */
> -	omap_cfg_reg(AA10_3430_USB2HS_PHY_STP);
> -	omap_cfg_reg(AA8_3430_USB2HS_PHY_CLK);
> -	omap_cfg_reg(AA9_3430_USB2HS_PHY_DIR);
> -	omap_cfg_reg(AB11_3430_USB2HS_PHY_NXT);
> -	omap_cfg_reg(AB10_3430_USB2HS_PHY_DATA0);
> -	omap_cfg_reg(AB9_3430_USB2HS_PHY_DATA1);
> -	omap_cfg_reg(W3_3430_USB2HS_PHY_DATA2);
> -	omap_cfg_reg(T4_3430_USB2HS_PHY_DATA3);
> -	omap_cfg_reg(T3_3430_USB2HS_PHY_DATA4);
> -	omap_cfg_reg(R3_3430_USB2HS_PHY_DATA5);
> -	omap_cfg_reg(R4_3430_USB2HS_PHY_DATA6);
> -	omap_cfg_reg(T2_3430_USB2HS_PHY_DATA7);
> -
> -#else
> -	/* Set Func mux for :
> -	 * TLL mode of operation
> -	 * 12-pin ULPI SDR TLL mode for Port1/2/3
> -	 */
> -
> -	/* Port1 */
> -	omap_cfg_reg(Y9_3430_USB1HS_TLL_STP);
> -	omap_cfg_reg(Y8_3430_USB1HS_TLL_CLK);
> -	omap_cfg_reg(AA14_3430_USB1HS_TLL_DIR);
> -	omap_cfg_reg(AA11_3430_USB1HS_TLL_NXT);
> -	omap_cfg_reg(W13_3430_USB1HS_TLL_DATA0);
> -	omap_cfg_reg(W12_3430_USB1HS_TLL_DATA1);
> -	omap_cfg_reg(W11_3430_USB1HS_TLL_DATA2);
> -	omap_cfg_reg(Y11_3430_USB1HS_TLL_DATA3);
> -	omap_cfg_reg(W9_3430_USB1HS_TLL_DATA4);
> -	omap_cfg_reg(Y12_3430_USB1HS_TLL_DATA5);
> -	omap_cfg_reg(W8_3430_USB1HS_TLL_DATA6);
> -	omap_cfg_reg(Y13_3430_USB1HS_TLL_DATA7);
> -
> -	/* Port2 */
> -	omap_cfg_reg(AA10_3430_USB2HS_TLL_STP);
> -	omap_cfg_reg(AA8_3430_USB2HS_TLL_CLK);
> -	omap_cfg_reg(AA9_3430_USB2HS_TLL_DIR);
> -	omap_cfg_reg(AB11_3430_USB2HS_TLL_NXT);
> -	omap_cfg_reg(AB10_3430_USB2HS_TLL_DATA0);
> -	omap_cfg_reg(AB9_3430_USB2HS_TLL_DATA1);
> -	omap_cfg_reg(W3_3430_USB2HS_TLL_DATA2);
> -	omap_cfg_reg(T4_3430_USB2HS_TLL_DATA3);
> -	omap_cfg_reg(T3_3430_USB2HS_TLL_DATA4);
> -	omap_cfg_reg(R3_3430_USB2HS_TLL_DATA5);
> -	omap_cfg_reg(R4_3430_USB2HS_TLL_DATA6);
> -	omap_cfg_reg(T2_3430_USB2HS_TLL_DATA7);
> -
> -	/* Port3 */
> -	omap_cfg_reg(AB3_3430_USB3HS_TLL_STP);
> -	omap_cfg_reg(AA6_3430_USB3HS_TLL_CLK);
> -	omap_cfg_reg(AA3_3430_USB3HS_TLL_DIR);
> -	omap_cfg_reg(Y3_3430_USB3HS_TLL_NXT);
> -	omap_cfg_reg(AA5_3430_USB3HS_TLL_DATA0);
> -	omap_cfg_reg(Y4_3430_USB3HS_TLL_DATA1);
> -	omap_cfg_reg(Y5_3430_USB3HS_TLL_DATA2);
> -	omap_cfg_reg(W5_3430_USB3HS_TLL_DATA3);
> -	omap_cfg_reg(AB12_3430_USB3HS_TLL_DATA4);
> -	omap_cfg_reg(AB13_3430_USB3HS_TLL_DATA5);
> -	omap_cfg_reg(AA13_3430_USB3HS_TLL_DATA6);
> -	omap_cfg_reg(AA12_3430_USB3HS_TLL_DATA7);
> -#endif /* CONFIG_OMAP_EHCI_PHY_MODE */
> +	if (phy_mode == EHCI_HCD_OMAP_MODE_PHY) {
> +		/* PHY mode of operation for board: 750-2083-001
> +		 * ISP1504 connected to Port1 and Port2
> +		 * Do Func Mux setting for 12-pin ULPI PHY mode
> +		 */
> +		/* Port1 */
> +		omap_cfg_reg(Y9_3430_USB1HS_PHY_STP);
> +		omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK);
> +		omap_cfg_reg(AA14_3430_USB1HS_PHY_DIR);
> +		omap_cfg_reg(AA11_3430_USB1HS_PHY_NXT);
> +		omap_cfg_reg(W13_3430_USB1HS_PHY_DATA0);
> +		omap_cfg_reg(W12_3430_USB1HS_PHY_DATA1);
> +		omap_cfg_reg(W11_3430_USB1HS_PHY_DATA2);
> +		omap_cfg_reg(Y11_3430_USB1HS_PHY_DATA3);
> +		omap_cfg_reg(W9_3430_USB1HS_PHY_DATA4);
> +		omap_cfg_reg(Y12_3430_USB1HS_PHY_DATA5);
> +		omap_cfg_reg(W8_3430_USB1HS_PHY_DATA6);
> +		omap_cfg_reg(Y13_3430_USB1HS_PHY_DATA7);
> +
> +		/* Port2 */
> +		omap_cfg_reg(AA10_3430_USB2HS_PHY_STP);
> +		omap_cfg_reg(AA8_3430_USB2HS_PHY_CLK);
> +		omap_cfg_reg(AA9_3430_USB2HS_PHY_DIR);
> +		omap_cfg_reg(AB11_3430_USB2HS_PHY_NXT);
> +		omap_cfg_reg(AB10_3430_USB2HS_PHY_DATA0);
> +		omap_cfg_reg(AB9_3430_USB2HS_PHY_DATA1);
> +		omap_cfg_reg(W3_3430_USB2HS_PHY_DATA2);
> +		omap_cfg_reg(T4_3430_USB2HS_PHY_DATA3);
> +		omap_cfg_reg(T3_3430_USB2HS_PHY_DATA4);
> +		omap_cfg_reg(R3_3430_USB2HS_PHY_DATA5);
> +		omap_cfg_reg(R4_3430_USB2HS_PHY_DATA6);
> +		omap_cfg_reg(T2_3430_USB2HS_PHY_DATA7);
> +
> +	} else {
> +		/* Set Func mux for :
> +		 * TLL mode of operation
> +		 * 12-pin ULPI SDR TLL mode for Port1/2/3
> +		 */
> +
> +		/* Port1 */
> +		omap_cfg_reg(Y9_3430_USB1HS_TLL_STP);
> +		omap_cfg_reg(Y8_3430_USB1HS_TLL_CLK);
> +		omap_cfg_reg(AA14_3430_USB1HS_TLL_DIR);
> +		omap_cfg_reg(AA11_3430_USB1HS_TLL_NXT);
> +		omap_cfg_reg(W13_3430_USB1HS_TLL_DATA0);
> +		omap_cfg_reg(W12_3430_USB1HS_TLL_DATA1);
> +		omap_cfg_reg(W11_3430_USB1HS_TLL_DATA2);
> +		omap_cfg_reg(Y11_3430_USB1HS_TLL_DATA3);
> +		omap_cfg_reg(W9_3430_USB1HS_TLL_DATA4);
> +		omap_cfg_reg(Y12_3430_USB1HS_TLL_DATA5);
> +		omap_cfg_reg(W8_3430_USB1HS_TLL_DATA6);
> +		omap_cfg_reg(Y13_3430_USB1HS_TLL_DATA7);
> +
> +		/* Port2 */
> +		omap_cfg_reg(AA10_3430_USB2HS_TLL_STP);
> +		omap_cfg_reg(AA8_3430_USB2HS_TLL_CLK);
> +		omap_cfg_reg(AA9_3430_USB2HS_TLL_DIR);
> +		omap_cfg_reg(AB11_3430_USB2HS_TLL_NXT);
> +		omap_cfg_reg(AB10_3430_USB2HS_TLL_DATA0);
> +		omap_cfg_reg(AB9_3430_USB2HS_TLL_DATA1);
> +		omap_cfg_reg(W3_3430_USB2HS_TLL_DATA2);
> +		omap_cfg_reg(T4_3430_USB2HS_TLL_DATA3);
> +		omap_cfg_reg(T3_3430_USB2HS_TLL_DATA4);
> +		omap_cfg_reg(R3_3430_USB2HS_TLL_DATA5);
> +		omap_cfg_reg(R4_3430_USB2HS_TLL_DATA6);
> +		omap_cfg_reg(T2_3430_USB2HS_TLL_DATA7);
> +
> +		/* Port3 */
> +		omap_cfg_reg(AB3_3430_USB3HS_TLL_STP);
> +		omap_cfg_reg(AA6_3430_USB3HS_TLL_CLK);
> +		omap_cfg_reg(AA3_3430_USB3HS_TLL_DIR);
> +		omap_cfg_reg(Y3_3430_USB3HS_TLL_NXT);
> +		omap_cfg_reg(AA5_3430_USB3HS_TLL_DATA0);
> +		omap_cfg_reg(Y4_3430_USB3HS_TLL_DATA1);
> +		omap_cfg_reg(Y5_3430_USB3HS_TLL_DATA2);
> +		omap_cfg_reg(W5_3430_USB3HS_TLL_DATA3);
> +		omap_cfg_reg(AB12_3430_USB3HS_TLL_DATA4);
> +		omap_cfg_reg(AB13_3430_USB3HS_TLL_DATA5);
> +		omap_cfg_reg(AA13_3430_USB3HS_TLL_DATA6);
> +		omap_cfg_reg(AA12_3430_USB3HS_TLL_DATA7);
> +	}
>  
>  	return;
>  }

Hmm, is this safe to do? Or does it remember on the number of data lines
that the transceiver uses? If so, maybe something like the recent mmc muxing
could be done where the number of pins is passed from platform_data.

This is assuming that the data lines do not have alternative pins.. In that case
only the common pins can be muxed and the rest would have to be muxed in the
board-*.c files.

Regards,

Tony


> @@ -172,7 +171,7 @@ void __init usb_ehci_init(enum ehci_hcd_omap_mode phy_mode,
>  
>  	/* Setup Pin IO MUX for EHCI */
>  	if (cpu_is_omap34xx())
> -		setup_ehci_io_mux();
> +		setup_ehci_io_mux(phy_mode);
>  
>  	if (platform_device_register(&ehci_device) < 0) {
>  		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
