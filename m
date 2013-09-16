From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] WLAN regression fixes for omap4 after moving to DT
 based booting
Date: Mon, 16 Sep 2013 14:38:18 -0700
Message-ID: <20130916213817.GA5388@atomide.com>
References: <20130913190811.24617.97699.stgit@localhost>
 <CAOesGMgzMfxoJpEOXhs8dQrpqavpWxG6_RfXHMEpDnEnOrP7iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64033 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab3IPViX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Sep 2013 17:38:23 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMgzMfxoJpEOXhs8dQrpqavpWxG6_RfXHMEpDnEnOrP7iw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

* Olof Johansson <olof@lixom.net> [130913 22:17]:
> Hi,
> 
> Not related to wlan but with DT conversion; I noticed the following in
> dmesg on Panda ES with omap2plus_defconfig on current mainline:
> 
> [    0.000000] smp_twd: clock not found -2

That should get fixed for v3.13 when we get the proper DT clocks
for omap. Currently twd_get_clock() currently does:

	if (np)
		twd_clk = of_clk_get(np, 0);
	else
		twd_clk = clk_get_sys("smp_twd", NULL);

So if fails in the np case right now.

I'd probably wait for v3.13 on this one to avoid adding
temporary timer workarounds to twd_get_clock() or stuffing
the clock for the timer by using of_clk_add_provider().

If people feel strongly that we should fix it for v3.12,
then let me know. Things do work without it, of course the
local timer is not being used though.
 
> and:
> 
> [    0.440399] omap-gpmc 50000000.gpmc: error: clk_get

Thanks that's an easy one. I'll queue the following fix.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Mon, 16 Sep 2013 14:22:31 -0700
Subject: [PATCH] ARM: OMAP4: Fix clock_get error for GPMC during boot

Looks like we still have the legacy clock alias name for
omap4 GPMC (General Purpose Memory Controller), so let's
fix it for the device tree naming. There's no need to keep
the legacy naming as omap4 is DT only nowadays.

Without this fix we get the following error while booting:

[    0.440399] omap-gpmc 50000000.gpmc: error: clk_get

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1632,7 +1632,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"auxclk5_src_ck",		&auxclk5_src_ck),
 	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck),
 	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck),
-	CLK("omap-gpmc",	"fck",			&dummy_ck),
+	CLK("50000000.gpmc",	"fck",			&dummy_ck),
 	CLK("omap_i2c.1",	"ick",			&dummy_ck),
 	CLK("omap_i2c.2",	"ick",			&dummy_ck),
 	CLK("omap_i2c.3",	"ick",			&dummy_ck),
