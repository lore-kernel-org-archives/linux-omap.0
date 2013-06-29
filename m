From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 30 Jun 2013 01:44:05 +0200
Message-ID: <CACRpkdZryWYZuOLx5E2njLNRd1SLj4VgtEyEETh88+3SS5ckyQ@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:57440 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab3F2XoG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Jun 2013 19:44:06 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so3614312oah.35
        for <linux-omap@vger.kernel.org>; Sat, 29 Jun 2013 16:44:05 -0700 (PDT)
In-Reply-To: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Fri, Jun 28, 2013 at 5:27 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> When a GPIO is defined as an interrupt line using Device
> Tree, a call to irq_create_of_mapping() is made that calls
> irq_create_mapping(). So, is not necessary to do the mapping
> for all OMAP GPIO lines and explicitly call irq_create_mapping()
> on the driver probe() when booting with Device Tree.
>
> Add a custom IRQ domain .map function handler that will be
> called by irq_create_mapping() to map the GPIO lines used as IRQ.
> This also allows to execute needed setup code such as configuring
> a GPIO as input and enabling the GPIO bank.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>
> Changes since v3:
>   - Use bank->chip.of_node instead of_have_populated_dt() to check
>     DT or legacy boot as suggested by Jean-Christophe PLAGNIOL-VILLARD

This does not apply to the "next" branch on my GPIO tree,
i.e:
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/

Not even with fuzzing :-(

Can you rebase them?

Yours,
Linus Walleij
