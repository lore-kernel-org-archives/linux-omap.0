From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] gpio/omap: move bank->dbck initialization to omap_gpio_mod_init()
Date: Wed, 11 Jul 2012 23:51:28 +0200
Message-ID: <CACRpkdYdtrAu-GX4F6iv_3VM4DrTAU48ch63SotLybfi8oLffQ@mail.gmail.com>
References: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
	<1341997995-14020-2-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:38224 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab2GKVv3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 17:51:29 -0400
Received: by qadb17 with SMTP id b17so3468063qad.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 14:51:29 -0700 (PDT)
In-Reply-To: <1341997995-14020-2-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Wed, Jul 11, 2012 at 11:13 AM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:

> Since the bank->dbck initialization in a one time operation there
> is no need to keep this within gpio_debounce(). Therefore, moving
> clk_get(bank->dbck) to omap_gpio_mod_init(). Since the value of
> bank->dbck would be NULL at the beginning, this check has been
> removed.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Applied with Pauld reviewed-by.

Thanks,
Linus Walleij
