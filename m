From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 29 Jul 2013 13:33:45 +0200
Message-ID: <51F65319.7000901@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de> <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com> <51F515A9.9010005@ahsoftware.de> <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com> <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com> <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com> <CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com> <CACRpkdYEmzh-Viq+vj6-99yz8=Ghn=e3Xe5_UYvsSkTr0g8JyQ@mail.gmail.com> <CAAwP0s2ETdSwmFjh=QJP+LwU+hsBR_KQ0mYGX94BYYfjx3+QVA@mail.gmail.com> <51F60E81.7090103@ahsoftware.de> <CAAwP0s2ZF8_qwkHYTn4RBbMFjzL3otMNcmswsDFC9vXPmnpjwg@mail.gmail.com> <51F64397.2090107@ahsoftware.de> <2AF86F5A-DEF4-47BD-A08D-7292753A51EC@collabora
 .co.uk> <51F65240.4010308@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:56345 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab3G2LeL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 07:34:11 -0400
Received: from eiche.ahsoftware (p57B216E0.dip0.t-ipconnect.de [87.178.22.224])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id C7D24423C26F
	for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 13:34:09 +0200 (CEST)
In-Reply-To: <51F65240.4010308@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Am 29.07.2013 13:30, schrieb Alexander Holler:

>> So I think the driver has to be changed independently of the approach
>> for auto request GPIO used.
>
> Maybe, but that isn't much effort. I had done that in 3 minutes (ok,
> without the would be necessary #ifdef CONFIG_OF_GPIO). But you have a
> chicken and egg situation here, because you can't change drivers without
> the new patch and you can't introduce the new patch without changes to
> drivers.
>
> As I had mentioned before, another approach could be to map the irq when
> gpio_to_irq() is called. I think that would be downward compatible
> without the need for some changes in a dts.

Having send that, I had another idea: introduce a config option to 
enable/disable the new behaviour. That would make it possible to change 
drivers while not breaking compatibility, and when all are changed, the 
config option could go away.

Regards,

Alexander Holler

