From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/1] gpio: omap: Fix PM runtime issue and remove most
 BANK_USED macros
Date: Tue, 12 May 2015 11:00:10 +0200
Message-ID: <CACRpkdZ1nJ=-NPHrZdCQ6_TCrF7009R9Y7zVyXN1z9RWcv3a6A@mail.gmail.com>
References: <1429632533-23285-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35274 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbbELJAL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2015 05:00:11 -0400
Received: by oign205 with SMTP id n205so491371oig.2
        for <linux-omap@vger.kernel.org>; Tue, 12 May 2015 02:00:10 -0700 (PDT)
In-Reply-To: <1429632533-23285-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Grygorii Strashko <grygorii.strashko@linaro.org>, Javier Martinez Canillas <jmartinez@softcrates.net>, Nishanth Menon <nm@ti.com>

On Tue, Apr 21, 2015 at 6:08 PM, Tony Lindgren <tony@atomide.com> wrote:

> Looks like omap_gpio_irq_type can return early at several places
> leaving a GPIO bank enabled without doing pm_runtime_put if wrong
> GPIO arguments are passed.
>
> Instead of adding more complicated BANK_USED macros, let's fix the
> issue properly. We can pass is_irq flag to omap_enable_gpio_module
> and omap_disble_gpio_module. And with that we can remove all the
> similar code elsewhere to get rid of most BANK_USED macros.
>
> Note that the reason for the BANK_USED macro is that we need to manage
> PM runtime on per GPIO bank basis. In the long run we want to move to
> using PM runtime counts for each GPIO line to determine if a GPIO
> bank is used. Once we have a solution for omap_enable_gpio_module
> and omap_disable_gpio_module, we can remove the remaining BANK_USED
> macros.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Javier Martinez Canillas <jmartinez@softcrates.net>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

There is so much discussion around this patch that I can't make
up my mind whether I should apply this or some subsequent inline
version of it.

Holding this off for now...

Yours,
Linus Walleij
