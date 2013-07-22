From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] pinctrl: single: omap: Add SoC specific module for
 wake-up events
Date: Tue, 23 Jul 2013 00:06:12 +0200
Message-ID: <CACRpkdathAjMtTGXz9U7EhsNEqdRCtxFuwQ2SFb=k8HEUewpAQ@mail.gmail.com>
References: <20130607203936.16513.57494.stgit@localhost>
	<20130607205044.16513.27675.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:49642 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab3GVWGN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 18:06:13 -0400
Received: by mail-oa0-f47.google.com with SMTP id k18so561135oag.20
        for <linux-omap@vger.kernel.org>; Mon, 22 Jul 2013 15:06:13 -0700 (PDT)
In-Reply-To: <20130607205044.16513.27675.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>

On Fri, Jun 7, 2013 at 10:50 PM, Tony Lindgren <tony@atomide.com> wrote:

> For wake-up events from deeper idle modes we need to check the
> configured padconf registers for the wake-up bit and then call
> the related interrupt handler.
>
> Done in collaboration with Roger Quadros <rogerq@ti.com>.
>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
(...)
> +                       pcsoi->gpio = r->gpio;

This "gpio" member appear to be used nowhere, which is probably
related to what I was saying about custom GPIO interfaces doing
pinconf, but I could be wrong...

> +/*
> + * Note that omap2430 has 8-bit padconf registers and uses
> + * the plain pinctrl-single binding.
> + */
> +static const struct of_device_id pcs_omap_of_match[] = {
> +       { .compatible = "ti,omap3-padconf", },
> +       { .compatible = "ti,omap4-padconf", },
> +       { .compatible = "ti,omap5-padconf", },
> +       {}
> +};

Goes into some binding document?

Yours,
Linus Walleij
