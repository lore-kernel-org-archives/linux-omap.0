From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH RFC 2/7] net: smsc911x: add pinctrl support
Date: Mon, 11 Feb 2013 15:29:33 +0100
Message-ID: <CAAwP0s2V6x7d_8V037JrBSA1UsPa9W14Kp_1z05BhFCW=XFy4Q@mail.gmail.com>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1360442671-15216-3-git-send-email-javier.martinez@collabora.co.uk> <CACRpkdY8FBoMCO1hjEOhCir=5mNJpiY7sG3PMvKeXJ-hHXXmjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:37951 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757095Ab3BKO3y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 09:29:54 -0500
Received: by mail-ie0-f171.google.com with SMTP id 10so7670743ied.16
        for <linux-omap@vger.kernel.org>; Mon, 11 Feb 2013 06:29:54 -0800 (PST)
In-Reply-To: <CACRpkdY8FBoMCO1hjEOhCir=5mNJpiY7sG3PMvKeXJ-hHXXmjQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Feb 11, 2013 at 3:23 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Feb 9, 2013 at 9:44 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>
>> If no pinctrl is available just report a warning since
>> it may not needed in some cases (e.g: non-DT kernels).
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> (...)
>> +       struct pinctrl *pinctrl;
> (...)
>> +       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>> +       if (IS_ERR(pinctrl)) {
>> +               retval = PTR_ERR(pinctrl);
>> +               if (retval == -EPROBE_DEFER)
>> +                       goto out_0;
>> +
>> +               dev_warn(&pdev->dev, "No pinctrl provided\n");
>> +       }
>
> NACK.
>
> This will be handled from the device core after the v3.9 merge
> window.
>
> See:
> http://marc.info/?l=linux-kernel&m=135887740715083&w=2
>

Great, I also wondered why it couldn't be part of the device core
since we basically duplicate this in all the DT aware drivers and
pinctrl was not used anywhere after setting to its default state.

This is a nice improvement.

> Yours,
> Linus Walleij
> --

Thanks a lot and best regards,
Javier
