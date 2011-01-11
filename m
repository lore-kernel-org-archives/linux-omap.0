From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP boot
 failure)
Date: Tue, 11 Jan 2011 15:16:11 -0800
Message-ID: <20110111231611.GX4957@atomide.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
 <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com>
 <20110106203238.GH1198@n2100.arm.linux.org.uk>
 <20110106204053.GA7771@atomide.com>
 <20110107161230.GR1198@n2100.arm.linux.org.uk>
 <20110110185209.GC4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42553 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab1AKXQo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 18:16:44 -0500
Content-Disposition: inline
In-Reply-To: <20110110185209.GC4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

* Tony Lindgren <tony@atomide.com> [110110 10:51]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110107 08:12]:
> > On Thu, Jan 06, 2011 at 12:40:54PM -0800, Tony Lindgren wrote:
> > > Anyways, I can debug the DEBUG_LL booting issue further if the patch
> > > I posted does not help.
> > 
> > This is what I ended up with earlier today to make the debug code work
> > both in the decompressor and in the kernel - once I had it working I
> > haven't bothered putting any more effort into it.
> 
> Hmm I have DEBUG_LL working fine (execept not for the uncompress code).
> 
> Looks like the only issue I have with my 4430 es1.0 blaze board is
> that it won't boot reliably unless I disable l2x0_init.
> 
> Have you guys seen this issue?
> 
> Of course there are all kinds of omap4 warnings there, but after
> disabling l2x0_init I was able to run apt-get dist-upgrade on my
> board. This is with what I have queued up in omap-fixes.

Here's one more es1.0 fix after the recent USB changes.

Regards,

Tony


Author: Tony Lindgren <tony@atomide.com>
Date:   Tue Jan 11 15:03:03 2011 -0800

    omap4: Fix ULPI PHY init for ES1.0 SDP
    
    Commit 6aa85a5ae610106d89e50c7e1f760c56d12f9bc4 (omap4: 4430sdp:
    enable the ehci port on 4430SDP) added code to enable EHCI
    support on 4430sdp board.
    
    Looks like the ULPI pin does not seem to be muxed properly on ES1.0
    SDP and this causes the system to reboot when the ULPI PHY is
    enabled.
    
    Fix this by muxing the pin, this is the same setting for
    both ES1.0 and ES2.0. Also add checking for gpio_request.
    
    Cc: Keshava Munegowda <keshava_mgowda@ti.com
    Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -554,6 +554,7 @@ static void __init omap_sfh7741prox_init(void)
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
@@ -576,11 +577,12 @@ static void __init omap_4430sdp_init(void)
 	omap4_twl6030_hsmmc_init(mmc);
 
 	/* Power on the ULPI PHY */
-	if (gpio_is_valid(OMAP4SDP_MDM_PWR_EN_GPIO)) {
-		/* FIXME: Assumes pad is already muxed for GPIO mode */
-		gpio_request(OMAP4SDP_MDM_PWR_EN_GPIO, "USBB1 PHY VMDM_3V3");
+	status = gpio_request(OMAP4SDP_MDM_PWR_EN_GPIO, "USBB1 PHY VMDM_3V3");
+	if (status)
+		pr_err("%s: Could not get USBB1 PHY GPIO\n");
+	else
 		gpio_direction_output(OMAP4SDP_MDM_PWR_EN_GPIO, 1);
-	}
+
 	usb_ehci_init(&ehci_pdata);
 	usb_musb_init(&musb_board_data);
 
