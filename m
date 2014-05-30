From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Enabling clock for EMU clock domain
Date: Fri, 30 May 2014 15:45:29 -0600
Message-ID: <CANLsYkzCt6WWhGagFjM1tRwe93VaoBbg0cbVfLpUg8SWHn7txg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34121 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324AbaE3Vpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 May 2014 17:45:30 -0400
Received: by mail-yk0-f175.google.com with SMTP id 131so2004069ykp.34
        for <linux-omap@vger.kernel.org>; Fri, 30 May 2014 14:45:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Good afternoon,

I am working on a beagleXM fitted with an OMAP3630 (I know it's old).
I am getting a reference on the "emu_src_ck" clock by calling

clk = clk_get(dev, "emu_src_ck");

>From there calling:

clk_enable(clk);

I have observed that upon returning from clk_enable() the clock is
still not active and as such, an access to the memory map of a device
in the EMU domain results in a kernel crash [1].

The enable function associated to "emu_src_ck" is
"omap2_clkops_enable_clkdm()", which ends up calling
"omap3xxx_clkdm_clk_enable()".  In there there following condition is
taken:

240         if ((clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) &&
241             (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)) {
242                 omap3xxx_clkdm_wakeup(clkdm);
243                 return 0;
244         }

"omap3xxx_clkdm_wakeup()" results in a __raw_writel() and returns
right away, not waiting for the status bit associated to the clock.
That is where the problem is coming from.

Asking an OMAP clock expert I learned that if an ".enable()" function
is to wait for the status bit to be active before returning, it has to
go through "omap2_dflt_clk_enable()".  Since we have a hierarchy of
clocks, "emu_src_ck" may not be the right clock to call if I want it
to be active upon returning from clk_enable().

I perused through the TRM and browsed the code, more specifically the
clocks found in "drivers/clk/ti/clk-3xxx.c".  I made a list of the
clocks that do have "omap2_dflt_clk_enable()" as their enable function
but I simply couldn't find a match between the EMU clock domain and
the top clock I need to enable in the code.

At this point I know two things:

1) I probably missed something in that staggering heap of clocks.
2) Someone somewhere knows the answer of the top of their head.

I would be grateful if that magic "someone" would take 2 minutes to
answer my email.  I need to know which clock listed in "clk-3xxx.c"
that will get me a working "emu_src_ck" clock upon return from
"clk_enable(clk)".

Best regards,
Mathieu

[1]. "Unhandled fault: external abort on non-linefetch (0x1028) at 0xfe810010"
