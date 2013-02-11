From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 2/7] net: smsc911x: add pinctrl support
Date: Mon, 11 Feb 2013 15:23:38 +0100
Message-ID: <CACRpkdY8FBoMCO1hjEOhCir=5mNJpiY7sG3PMvKeXJ-hHXXmjQ@mail.gmail.com>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
	<1360442671-15216-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:51989 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757383Ab3BKOXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 09:23:40 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so6342054iab.37
        for <linux-omap@vger.kernel.org>; Mon, 11 Feb 2013 06:23:40 -0800 (PST)
In-Reply-To: <1360442671-15216-3-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Feb 9, 2013 at 9:44 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> If no pinctrl is available just report a warning since
> it may not needed in some cases (e.g: non-DT kernels).
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
(...)
> +       struct pinctrl *pinctrl;
(...)
> +       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +       if (IS_ERR(pinctrl)) {
> +               retval = PTR_ERR(pinctrl);
> +               if (retval == -EPROBE_DEFER)
> +                       goto out_0;
> +
> +               dev_warn(&pdev->dev, "No pinctrl provided\n");
> +       }

NACK.

This will be handled from the device core after the v3.9 merge
window.

See:
http://marc.info/?l=linux-kernel&m=135887740715083&w=2

Yours,
Linus Walleij
