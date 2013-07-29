From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 29 Jul 2013 12:48:37 +0200
Message-ID: <51F64885.1020403@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de> <51F529D6.8030809@ahsoftware.de> <CACRpkdYKSMcCe+uNiB2Jbc8GbUwvJxyq+7EiLM-xdOevVRK-wQ@mail.gmail.com> <51F54A98.80601@ahsoftware.de> <CACRpkdYb7jBpZofLn5VLL7pcMdh5P227ZpwYfV2HJAszFwUEig@mail.gmail.com> <CAAwP0s0q6U6MDYBHiA=u3N_3bJ7CXTPKX_A_wwTrWrqj17mH0w@mail.gmail.com> <51F5FC8E.9010007@ahsoftware.de> <CACRpkda3vN1SQR-25358B20Gye3kgVOBTQqYT+reYhjQoZ2rbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:49598 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab3G2KtV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 06:49:21 -0400
Received: from eiche.ahsoftware (p57B216E0.dip0.t-ipconnect.de [87.178.22.224])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id AAE3C423C2BE
	for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 12:49:19 +0200 (CEST)
In-Reply-To: <CACRpkda3vN1SQR-25358B20Gye3kgVOBTQqYT+reYhjQoZ2rbA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, Balaji T K <balajitk@ti.com>

Am 29.07.2013 11:05, schrieb Linus Walleij:
> On Mon, Jul 29, 2013 at 7:24 AM, Alexander Holler <holler@ahsoftware.de> wrote:
>
>> Maybe it might be worth to suggest using/returning NO_IRQ in (new) patches
>> instead of zero. That would make it very clear that the value 0 isn't to be
>> used later.
>
> Using NO_IRQ is also discouraged, and this is because we should
> use the if (!irq) design pattern and not if (irq == NO_IRQ).

So the article on lkml is already outdated. After reading the article, I 
had the impression that using NO_IRQ (at least for return codes) is 
encouraged.

Regards,

Alexander Holler

