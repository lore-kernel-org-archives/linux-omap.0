From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP boot failure)
Date: Tue, 1 Feb 2011 18:25:59 +0530
Message-ID: <3c13ae6d9e13b94548bfcaaced7681e8@mail.gmail.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com> <20110106203238.GH1198@n2100.arm.linux.org.uk>
 <20110106204053.GA7771@atomide.com> <20110107161230.GR1198@n2100.arm.linux.org.uk>
 <20110110185209.GC4957@atomide.com> <20110111231611.GX4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45667 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751640Ab1BAM4C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 07:56:02 -0500
Received: by iwn37 with SMTP id 37so13206850iwn.25
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 04:56:01 -0800 (PST)
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

Tony,

I believe this fix is fixing your reboot issue, but it's breaking
EHCI support on the SDP.

The MODE4 above should really be MODE3 - all GPIOs are on MODE3.
By changing

The patch snippet below fixes EHCI on the SDP, but I believe that
making this change will reintroduce the "board reboots" issue
you originally reported. Could you check and tell me if this
is the case?

Just curious - is your board a Blaze, or an SDP?

diff --git a/arch/arm/mach-omap2/board-4430sdp.c
b/arch/arm/mach-omap2/board-4430sdp.c
index 07d1b20..ab9fb4d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -554,7 +554,7 @@ static void __init omap_sfh7741prox_init(void)

 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
-	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
+	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
