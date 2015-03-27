From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/8] gpio: omap: convert omap_gpio_is_input() to use
 gpio offset
Date: Fri, 27 Mar 2015 11:03:30 +0100
Message-ID: <CACRpkdamuvz-OHoL64AtuZg437eQ_h4=sW9ObJ4ZVDinUBnJ-w@mail.gmail.com>
References: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
	<1427113110-20813-2-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36723 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbbC0KDb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2015 06:03:31 -0400
Received: by obbld8 with SMTP id ld8so15330788obb.3
        for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2015 03:03:30 -0700 (PDT)
In-Reply-To: <1427113110-20813-2-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Mar 23, 2015 at 1:18 PM,  <grygorii.strashko@linaro.org> wrote:

> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> Convert omap_gpio_is_input() to use GPIO offset instead of mask and,
> in such way, make code simpler and remove few lines of code.
>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>

Patch applied.

Yours,
Linus Walleij
