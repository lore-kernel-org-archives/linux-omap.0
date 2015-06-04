From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/5] [RFC] ARM: timer-sp: Use of_clk_get_parent_count()
 instead of open coding
Date: Thu, 4 Jun 2015 09:26:43 +0200
Message-ID: <CAMuHMdXRQbBJWLCiDgx=vRcj=MS5BAQ6gskfcMGZzW1gKa6J8g@mail.gmail.com>
References: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
	<1432891549-23295-6-git-send-email-geert+renesas@glider.be>
	<20150603234426.GB490@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:35553 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbbFDH0o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2015 03:26:44 -0400
In-Reply-To: <20150603234426.GB490@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-clk@vger.kernel.org, kernel@stlinux.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Stephen,

On Thu, Jun 4, 2015 at 1:44 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 05/29, Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> This is an RFC, as it depends on "[RFC] clk: Provide dummy
>> of_clk_get_parent_count() for !OF/!CCF".
>> ---
>>  arch/arm/common/timer-sp.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
>> index 19211324772f387c..be87a5d480ffb655 100644
>> --- a/arch/arm/common/timer-sp.c
>> +++ b/arch/arm/common/timer-sp.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/clk.h>
>>  #include <linux/clocksource.h>
>>  #include <linux/clockchips.h>
>> +#include <linux/clk-provider.h>
>
> This looks weird. This is not a clock provider.

But that's where the declaration of of_clk_get_parent_count() lives...

>>  #include <linux/err.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/irq.h>
>> @@ -234,7 +235,7 @@ static void __init sp804_of_init(struct device_node *np)
>>               clk1 = NULL;
>>
>>       /* Get the 2nd clock if the timer has 3 timer clocks */
>> -     if (of_count_phandle_with_args(np, "clocks", "#clock-cells") == 3) {
>> +     if (of_clk_get_parent_count(np) == 3) {
>
> So maybe it means if we want to expose of_clk_get_parent_count()
> we should move it to some other header file (of_clk.h?). And then
> maybe we should always compile said helpers if OF=y and
> HAVE_CLK=y.

That makes sense.

Currently we have lots of of_clk_*() in <linux/clk-provider.h>, and a few
of_clk_get*() in <inux/clk.h>.
And the mysterious of_clk_set_defaults() in <linux/clk/clk-conf.h>.

All of_clk_get*() could be moved to a new <linux/of_clk.h>.

Alternatively, of_clk_get_parent_count() could just move to <linux/clk.h>?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
