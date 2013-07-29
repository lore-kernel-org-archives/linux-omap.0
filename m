From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 29 Jul 2013 11:13:04 +0200
Message-ID: <CACRpkdYjbWXr41B0t+rGMiiZ9Hdt10+XyL+kYQgEm7j8SfSsww@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<51F4F973.8000303@ahsoftware.de>
	<CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
	<51F515A9.9010005@ahsoftware.de>
	<CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com>
	<448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com>
	<CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com>
	<CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com>
	<CACRpkdYEmzh-Viq+vj6-99yz8=Ghn=e3Xe5_UYvsSkTr0g8JyQ@mail.gmail.com>
	<CAAwP0s2ETdSwmFjh=QJP+LwU+hsBR_KQ0mYGX94BYYfjx3+QVA@mail.gmail.com>
	<51F60E81.7090103@ahsoftware.de>
	<CAAwP0s2ZF8_qwkHYTn4RBbMFjzL3otMNcmswsDFC9vXPmnpjwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:64102 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab3G2JNG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 05:13:06 -0400
Received: by mail-oa0-f49.google.com with SMTP id n16so1035229oag.22
        for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 02:13:05 -0700 (PDT)
In-Reply-To: <CAAwP0s2ZF8_qwkHYTn4RBbMFjzL3otMNcmswsDFC9vXPmnpjwg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Alexander Holler <holler@ahsoftware.de>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

P=E5 m=E5ndagen den 29 juli 2013 vid 10:17 AM, skrev Javier Martinez
Canillas <martinez.javier@gmail.com>:
> On Mon, Jul 29, 2013 at 8:41 AM, Alexander Holler <holler@ahsoftware.=
de> wrote:
>> Am 28.07.2013 21:06, schrieb Javier Martinez Canillas:

>>>>>                  interrupt-parent =3D <&gpio6>;
>>>>>                  interrupts =3D <16 8>;
>>
>>
>> What do the values 16 and 8 mean here? GPIO numbers?
>> And where do I have to place that?
(...)
>     - bits[3:0] trigger type and level flags
>         1 =3D low-to-high edge triggered
>         2 =3D high-to-low edge triggered
>         4 =3D active high level-sensitive
>         8 =3D active low level-sensitive
>
> So, the first cell in this example means the 16th GPIO in the omap
> gpio6 controller using the edge/level flag IRQ_TYPE_LEVEL_LOW.

We have a better way to express this to avoid confusion.
In your DTS file, using the new DTS preprocessor:

#include <dt-bindings/interrupt-controller/irq.h>

interrupt-parent =3D <&gpio6>;
interrupts =3D <16 IRQ_TYPE_LEVEL_LOW>;

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
