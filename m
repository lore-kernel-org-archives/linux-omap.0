From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 19:36:19 +0200
Message-ID: <CAAwP0s39w-_vVwTUK4J0eafoAyr2C94WQ10xwvND5GPC5nRABA@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
 <51F4F973.8000303@ahsoftware.de> <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
 <51F515A9.9010005@ahsoftware.de> <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com>
 <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com>
 <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com> <CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:45363 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab3G1Rgk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 13:36:40 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so11446320oag.12
        for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 10:36:40 -0700 (PDT)
In-Reply-To: <CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Alexander Holler <holler@ahsoftware.de>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

On Sun, Jul 28, 2013 at 7:33 PM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
> Hello,
>
> Being the author of these patches I'm ashamed that they are causing a
> regression. I did my best to make sure that it would work on OMAP1 and
> OMAP2+ platforms booting with both legacy board files and DT.
>
> Also, I didn't come with this solution in a vacuum. This was deeply
> discussed with Jon Hunter, Grant Likely, Jean-Christophe
> PLAGNIOL-VILLARD and others on a 90+ emails linux-omap thread [1] and
> over IRC in #linaro-kernel channel.
>

Just realized I forgot to add the reference to the original thread
were the issue that $subject fixes was discussed, sorry for the
noise...

[1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85544.html

Best regards,
Javier
