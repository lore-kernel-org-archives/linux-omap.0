From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] gpio/omap: use gpiolib API to mark a GPIO used as
 an IRQ
Date: Wed, 16 Oct 2013 10:25:40 +0200
Message-ID: <525E4D84.4030504@collabora.co.uk>
References: <1381884450-2358-1-git-send-email-javier.martinez@collabora.co.uk> <CACRpkdYWtgExaaFZ_nV_yX43FXpMCeskjGtKMyVySd+awuepOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:47392 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193Ab3JPI0Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Oct 2013 04:26:25 -0400
In-Reply-To: <CACRpkdYWtgExaaFZ_nV_yX43FXpMCeskjGtKMyVySd+awuepOQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Enric Balletbo i Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>

On 10/16/2013 10:06 AM, Linus Walleij wrote:
> On Wed, Oct 16, 2013 at 2:47 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
> 
>> The OMAP GPIO driver keeps track about GPIO pins that are
>> used as IRQ lines for two reasons:
>>
>> 1) To prevent GPIO banks to be disabled while one of their
>>    GPIO pins are only used as an interrupt line.
>>
>> 2) To not allow another caller to set the GPIO pin as output.
>>
>> Now gpiolib has an API to mark GPIO pins as used as IRQ lines
>> so the GPIO core only allows to set as output GPIO pins not
>> tied to an IRQ. So there is no need to have custom code for 2).
>>
>> The IRQ usage still has to be maintained locally for 1) though.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Patch applied. I had to merge in v3.12-rc4 to get the dependency
> fixes, so I guess you did something similar when developing
> this...
>

Thanks and yes since this is not a critical bug it was meant to be for v3.13 on
top of fac7fa162 ("gpio/omap: auto-setup a GPIO when used as an IRQ") and after
you have merged your flag-irqs branch.

Sorry for not explicitly mentioning this dependency.

> Yours,
> Linus Walleij
> 

Best regards,
Javier
