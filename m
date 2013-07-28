From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 18:29:09 +0200
Message-ID: <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<51F4F973.8000303@ahsoftware.de>
	<CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
	<51F515A9.9010005@ahsoftware.de>
	<CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com>
	<448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:38541 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab3G1Q3M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 12:29:12 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so7753934obc.13
        for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 09:29:09 -0700 (PDT)
In-Reply-To: <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Alexander Holler <holler@ahsoftware.de>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

On Sun, Jul 28, 2013 at 4:37 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:

> I think the default OMAP DT files will continue to work with
>  these patches applied and mostly doesn't break anything
> in default configuration.

What does "mostly" mean? Hm hm. OK I feel a little
bit better about this now...

> Ofcourse with the DT modification as done
> by Alexander will expose the issue.

So this is all caused by non-upstream code or
non-upstream DTS files?

> I really wanted to have the auto request GPIO supported
> when used as IRQ line but surely not at expense of
> breaking the client drivers.

If things are working for the default DTS files in the
kernel then I am OK with it.

However moving forward to support the cases that
Alexander is highlighting, I really really thin we need
to put the information about taken GPIOs "input-hogs"
into the gpio DT node.

Yours,
Linus Walleij
