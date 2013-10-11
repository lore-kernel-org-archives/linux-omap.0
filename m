From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ mask
 is changed
Date: Fri, 11 Oct 2013 18:19:25 +0200
Message-ID: <CACRpkdb7iUypffB7O7-RhQhVf5WkjYdVCNLRz=BgySG4FET-xQ@mail.gmail.com>
References: <1381507996-15021-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:44384 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665Ab3JKQTZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 12:19:25 -0400
Received: by mail-ie0-f172.google.com with SMTP id x13so8751067ief.31
        for <linux-omap@vger.kernel.org>; Fri, 11 Oct 2013 09:19:25 -0700 (PDT)
In-Reply-To: <1381507996-15021-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Benoit Cousson <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>

On Fri, Oct 11, 2013 at 6:13 PM, Roger Quadros <rogerq@ti.com> wrote:

> On OMAPs the IO ring must be rearmed each time the pad wakeup
> configuration is changed. So call pcs_soc->rearm() from
> pcs_irq_set().
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

If Tony needs to apply this with the other patches: Acked-by.

Yours,
Linus Walleij
