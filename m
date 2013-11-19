From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ mask
 is changed
Date: Tue, 19 Nov 2013 09:41:07 +0100
Message-ID: <CACRpkdbLWnkoRtG1jJg73XWKveMSbf244SbmNdXN+cdEfEMcew@mail.gmail.com>
References: <1381507996-15021-1-git-send-email-rogerq@ti.com>
	<CACRpkdb7iUypffB7O7-RhQhVf5WkjYdVCNLRz=BgySG4FET-xQ@mail.gmail.com>
	<20131011172337.GU29913@atomide.com>
	<CACRpkdbo_TwX79hnJ5mCo8D4TSDd6OUzaOsFa8MgzjLy-H2U4Q@mail.gmail.com>
	<20131112195611.GT15154@atomide.com>
	<20131114182447.GJ10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:45374 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab3KSIlI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 03:41:08 -0500
Received: by mail-oa0-f51.google.com with SMTP id i7so3294625oag.38
        for <linux-omap@vger.kernel.org>; Tue, 19 Nov 2013 00:41:07 -0800 (PST)
In-Reply-To: <20131114182447.GJ10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Benoit Cousson <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>

On Thu, Nov 14, 2013 at 7:24 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [131112 11:57]:

>> The fix from Roger is still missing. You can go ahead and queue
>> it, or if you prefer me to do it I can add it to my fixes.
>
> Actually Linus, I'll queue this with your ack as the interrupts-extended
> property is now merged in and I can also enable some minimal wake-up
> events for omap3.

OK thanks for the heads-up, go ahead.

Yours,
Linus Walleij
