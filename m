From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP boot failure)
Date: Thu, 13 Jan 2011 14:22:06 +0530
Message-ID: <2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com> <20110106203238.GH1198@n2100.arm.linux.org.uk>
 <20110106204053.GA7771@atomide.com> <20110107161230.GR1198@n2100.arm.linux.org.uk>
 <20110110185209.GC4957@atomide.com> <20110111231611.GX4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:44190 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752900Ab1AMIwJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 03:52:09 -0500
Received: by wyj26 with SMTP id 26so1476764wyj.0
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 00:52:07 -0800 (PST)
In-Reply-To: <20110111231611.GX4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

Tony Lindgren wrote:
> Here's one more es1.0 fix after the recent USB changes.
>
> Regards,
>
> Tony
>
>
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Tue Jan 11 15:03:03 2011 -0800
>
>     omap4: Fix ULPI PHY init for ES1.0 SDP
>
>     Commit 6aa85a5ae610106d89e50c7e1f760c56d12f9bc4 (omap4: 4430sdp:
>     enable the ehci port on 4430SDP) added code to enable EHCI
>     support on 4430sdp board.
>
>     Looks like the ULPI pin does not seem to be muxed properly on ES1.0
>     SDP and this causes the system to reboot when the ULPI PHY is
>     enabled.
>
>     Fix this by muxing the pin, this is the same setting for
>     both ES1.0 and ES2.0. Also add checking for gpio_request.
>
>     Cc: Keshava Munegowda <keshava_mgowda@ti.com
>     Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -554,6 +554,7 @@ static void __init omap_sfh7741prox_init(void)
>
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
> +	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
>  #else
> @@ -576,11 +577,12 @@ static void __init omap_4430sdp_init(void)
>  	omap4_twl6030_hsmmc_init(mmc);
>
>  	/* Power on the ULPI PHY */
> -	if (gpio_is_valid(OMAP4SDP_MDM_PWR_EN_GPIO)) {
> -		/* FIXME: Assumes pad is already muxed for GPIO mode */
> -		gpio_request(OMAP4SDP_MDM_PWR_EN_GPIO, "USBB1 PHY
VMDM_3V3");
> +	status = gpio_request(OMAP4SDP_MDM_PWR_EN_GPIO, "USBB1 PHY
VMDM_3V3");
> +	if (status)
> +		pr_err("%s: Could not get USBB1 PHY GPIO\n");

Tony,

This throws up a build warning as there's no parameter corresponding to
the %s. Showed up in linux-next as of today.

- Anand
