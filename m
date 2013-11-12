From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ mask
 is changed
Date: Tue, 12 Nov 2013 19:44:32 +0100
Message-ID: <CACRpkdbo_TwX79hnJ5mCo8D4TSDd6OUzaOsFa8MgzjLy-H2U4Q@mail.gmail.com>
References: <1381507996-15021-1-git-send-email-rogerq@ti.com>
	<CACRpkdb7iUypffB7O7-RhQhVf5WkjYdVCNLRz=BgySG4FET-xQ@mail.gmail.com>
	<20131011172337.GU29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:42897 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab3KLSoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Nov 2013 13:44:32 -0500
Received: by mail-ob0-f181.google.com with SMTP id uz6so5076727obc.40
        for <linux-omap@vger.kernel.org>; Tue, 12 Nov 2013 10:44:32 -0800 (PST)
In-Reply-To: <20131011172337.GU29913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Benoit Cousson <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>

On Fri, Oct 11, 2013 at 7:23 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Walleij <linus.walleij@linaro.org> [131011 09:27]:
>> On Fri, Oct 11, 2013 at 6:13 PM, Roger Quadros <rogerq@ti.com> wrote:
>>
>> > On OMAPs the IO ring must be rearmed each time the pad wakeup
>> > configuration is changed. So call pcs_soc->rearm() from
>> > pcs_irq_set().
>> >
>> > Signed-off-by: Roger Quadros <rogerq@ti.com>
>>
>> If Tony needs to apply this with the other patches: Acked-by.
>
> Just replied with a slightly modified version of Roger's patch
> suggesting you pull in the signed tag I posted for you yesterday
> and then you can pick up Roger's fix into the pinctrl tree :)

Hm now that I go over these old mails in my inbox I start to
worry that I missed something here, I have no memory of pulling
a tag for OMAP... is this all in the state
it needs to be for OMAP?

Yours,
Linus Walleij
