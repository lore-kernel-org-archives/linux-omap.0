From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH 7/8] OMAP4: clock: Add CPU local timer clock node.
Date: Thu, 8 Dec 2011 15:02:04 -0800
Message-ID: <CAJOA=zP0zs=eKsQXQPt5dj8EHQFnZ50Jnm_Ho425yH-NZkgY5A@mail.gmail.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
 <1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com>
 <CAKnu2Mp4QnQPwcGJCrfMqS6VcfvvvAxginjJkLG1mPLO0WJBUw@mail.gmail.com> <CAMQu2gyBq61jcP1sLDEs8+zGfdAa6Pur1fSec9Wfzs48CX5zjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:37954 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751310Ab1LHXC0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 18:02:26 -0500
Received: by mail-gx0-f178.google.com with SMTP id q4so2311663ggn.23
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 15:02:25 -0800 (PST)
In-Reply-To: <CAMQu2gyBq61jcP1sLDEs8+zGfdAa6Pur1fSec9Wfzs48CX5zjA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 30, 2011 at 2:15 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Fri, Sep 30, 2011 at 3:00 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> 2011/9/8 Santosh Shilimkar <santosh.shilimkar@ti.com>:
>>
>>> Local timer clock is sourced from the CPU clock and hence changes
>>> along with CPU clock. These per CPU local timers are used as
>>> clock-events, so they need to be reconfigured on CPU frequency
>>> change as part of CPUfreq governor.
>>
>> This requires patch 6956/2 right?
>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6956/2
>>
>> Can I add your Tested-by: to the patch as well?
>>
> Sure.

Santosh,

I've taken in Linus' patch as well as this patch while testing clk
notifiers (part of common clk framework code).

Linus' patch matches the clk based on dev_id, but the clkdev entry in
your patch populated dev_id with NULL and con_id with "smp_twd" so
things never worked correctly.  Below changed fixed it for me:

diff --git a/arch/arm/mach-omap2/clock44xx_data.c
b/arch/arm/mach-omap2/clock44xx_data.c
index ae8c292..0f8cf68 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -4114,7 +4114,7 @@ static struct omap_clk omap44xx_clks[] = {
        CLK(NULL,       "l4_div_ck",
&l4_div_ck_hw.clk,      CK_443X),
        CLK(NULL,       "lp_clk_div_ck",
&lp_clk_div_ck_hw.clk,  CK_443X),
        CLK(NULL,       "l4_wkup_clk_mux_ck",
&l4_wkup_clk_mux_ck_hw.clk,     CK_443X),
-       CLK(NULL,       "smp_twd",
&mpu_periphclk_hw.clk,  CK_443X),
+       CLK("smp_twd",  NULL,                   &mpu_periphclk_hw.clk,
 CK_443X),
        CLK(NULL,       "ocp_abe_iclk",
&ocp_abe_iclk_hw.clk,   CK_443X),
        CLK(NULL,       "per_abe_24m_fclk",
&per_abe_24m_fclk_hw.clk,       CK_443X),
        CLK(NULL,       "per_abe_nc_fclk",
&per_abe_nc_fclk_hw.clk,        CK_443X),

A better change might be for the code in smp_twd.c to match on con_id
but I'll let you guys sort that out.

Regards,
Mike
