From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
Date: Wed, 24 Oct 2012 10:16:09 +0200
Message-ID: <CACRpkdb_zO0G5hsU5hTqnmD6Zju_xBwdmnk6C=Ok1R7-oNT_iQ@mail.gmail.com>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44600 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965Ab2JXIQK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 04:16:10 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so116372wey.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Oct 2012 01:16:09 -0700 (PDT)
In-Reply-To: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

On Tue, Oct 23, 2012 at 8:09 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:

> From: Kevin Hilman <khilman@ti.com>
>
> When debounce clocks are disabled, ensure that the banks
> dbck_enable_mask is cleared also.  Otherwise, context restore on
> subsequent off-mode transition will restore previous value from the
> shadow copies (bank->context.debounce*) leading to mismatch state
> between driver state and hardware state.
>
> This was discovered when board code was doing
>
>   gpio_request_one()
>   gpio_set_debounce()
>   gpio_free()
>
> which was leaving the GPIO debounce settings in a confused state.
> Then, enabling off mode causing bogus state to be restored, leaving
> GPIO debounce enabled which then prevented the CORE powerdomain from
> transitioning.
>
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Thanks! Applied with Felipe's and Santosh's ACKs.

Yours,
Linus Walleij
