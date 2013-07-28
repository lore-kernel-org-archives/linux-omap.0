From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 19:13:17 +0200
Message-ID: <51F5512D.1070105@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de> <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com> <51F515A9.9010005@ahsoftware.de> <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com> <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com> <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:43578 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab3G1ROA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 13:14:00 -0400
Received: from eiche.ahsoftware (p57B21DD0.dip0.t-ipconnect.de [87.178.29.208])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 95126423C293
	for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 19:13:57 +0200 (CEST)
In-Reply-To: <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Am 28.07.2013 18:29, schrieb Linus Walleij:
> On Sun, Jul 28, 2013 at 4:37 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
> 
>> I think the default OMAP DT files will continue to work with
>>  these patches applied and mostly doesn't break anything
>> in default configuration.
> 
> What does "mostly" mean? Hm hm. OK I feel a little
> bit better about this now...
> 
>> Ofcourse with the DT modification as done
>> by Alexander will expose the issue.
> 
> So this is all caused by non-upstream code or
> non-upstream DTS files?
> 
>> I really wanted to have the auto request GPIO supported
>> when used as IRQ line but surely not at expense of
>> breaking the client drivers.
> 
> If things are working for the default DTS files in the
> kernel then I am OK with it.

Sorry, but that isn't and can't be a solution. Most upstream DTS files
are just for a small number of developer boards and DT got introduced to
support a lot of boards while only providing a few DTs.

Having a quick look git grep gpio_to_irq, I've quickly spotted e.g. this
in drivers/input/keyboard/gpio_keys.c:

                irq = gpio_to_irq(button->gpio);
                if (irq < 0) {

(again <0 not <=0)

and I assume that gpio-keys now fails too.

But I haven't tested it (yet).

Maybe my dts entry is wrong or incomplete, but I don't see a way how to
define the irq-domain besides the one which is already defined by the
definition of the gpio. And I don't see why that should be necessary, in
the dts the domain is already defined, it just (now) isn't used anymore.

Besides that, I feel free to ignore me. I don't know what the new
patches do fix and I don't really have a need for a solution.

Regards,

Alexander Holler
