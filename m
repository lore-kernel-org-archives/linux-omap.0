From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] GPIO: gpio-twl6040: Remove support for legacy (pdata) mode
Date: Sat, 20 Jul 2013 21:38:57 +0200
Message-ID: <CACRpkdYJ2ugJHO512cu14uZ5Om4wKL7tq=yz_fb9sTiZne-+OQ@mail.gmail.com>
References: <1373628643-11360-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51346 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab3GTTi5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Jul 2013 15:38:57 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so7544893oag.33
        for <linux-omap@vger.kernel.org>; Sat, 20 Jul 2013 12:38:57 -0700 (PDT)
In-Reply-To: <1373628643-11360-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Grant Likely <grant.likely@linaro.org>, linux-gpio@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>

On Fri, Jul 12, 2013 at 1:30 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> TWL6040 is used only with OMAP4/5 SoCs and they can only boot in in DT mode.
> The support for pdata/legacy boot can be removed.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

OK patch applied.

Yours,
Linus Walleij
