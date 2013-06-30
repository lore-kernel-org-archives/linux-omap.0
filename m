From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 30 Jun 2013 02:25:15 +0200
Message-ID: <CAAwP0s2jtVEoqMVE7ru-tcXMX8ZKZObnDz0UDWiS4QkbJODOHA@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <CACRpkdZryWYZuOLx5E2njLNRd1SLj4VgtEyEETh88+3SS5ckyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:58811 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab3F3AZg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Jun 2013 20:25:36 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so6975839iec.13
        for <linux-omap@vger.kernel.org>; Sat, 29 Jun 2013 17:25:36 -0700 (PDT)
In-Reply-To: <CACRpkdZryWYZuOLx5E2njLNRd1SLj4VgtEyEETh88+3SS5ckyQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Sun, Jun 30, 2013 at 1:44 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jun 28, 2013 at 5:27 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>
>> When a GPIO is defined as an interrupt line using Device
>> Tree, a call to irq_create_of_mapping() is made that calls
>> irq_create_mapping(). So, is not necessary to do the mapping
>> for all OMAP GPIO lines and explicitly call irq_create_mapping()
>> on the driver probe() when booting with Device Tree.
>>
>> Add a custom IRQ domain .map function handler that will be
>> called by irq_create_mapping() to map the GPIO lines used as IRQ.
>> This also allows to execute needed setup code such as configuring
>> a GPIO as input and enabling the GPIO bank.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> ---
>>
>> Changes since v3:
>>   - Use bank->chip.of_node instead of_have_populated_dt() to check
>>     DT or legacy boot as suggested by Jean-Christophe PLAGNIOL-VILLARD
>
> This does not apply to the "next" branch on my GPIO tree,
> i.e:
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/
>
> Not even with fuzzing :-(
>
> Can you rebase them?
>
> Yours,
> Linus Walleij
> --

Hi Linus,

Yes, It doesn't apply cleanly to your "next" branch cleanly because
this patch-set depends on the following bugfix patch merged late on
the -rc cycle (3.10-rc7):

397eada9 ("gpio/omap: don't use linear domain mapping for OMAP1")

but your next branch is based on Linux 3.10-rc3.

So, I could change the patches so they can be applied cleanly on your
branch but then it will not apply cleanly when you send your pull
request to Torvalds.

Thanks a lot and best regards,
Javier
