From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 6/8] gpio: omap: get rid of GPIO_BIT() macro
Date: Fri, 27 Mar 2015 11:07:36 +0100
Message-ID: <CACRpkdbDGUEurj+Bv8uxkwJuGbS4XgLQ8KdC2ftV=EtbySR8ew@mail.gmail.com>
References: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
	<1427113110-20813-7-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33284 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbC0KHg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2015 06:07:36 -0400
Received: by oifl3 with SMTP id l3so72027684oif.0
        for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2015 03:07:36 -0700 (PDT)
In-Reply-To: <1427113110-20813-7-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Mar 23, 2015 at 1:18 PM,  <grygorii.strashko@linaro.org> wrote:

> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> Now OMAP GPIO driver prepared for GPIO_BIT() macro removing.
> Do it ;)
>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>

Patch applied.

Yours,
Linus Walleij
