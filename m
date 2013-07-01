From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 1 Jul 2013 14:35:54 +0200
Message-ID: <CACRpkdYEF_0A8Kxg2VPJpNwvNErsj95=RnJvfAWBfjwnARat5g@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<CACRpkdZryWYZuOLx5E2njLNRd1SLj4VgtEyEETh88+3SS5ckyQ@mail.gmail.com>
	<CAAwP0s2jtVEoqMVE7ru-tcXMX8ZKZObnDz0UDWiS4QkbJODOHA@mail.gmail.com>
	<CACRpkdaQ+zvrYF6o65Emkf2yiMR4YOfutBv-LTDc0xOmnkZkBg@mail.gmail.com>
	<655D996E-9836-4919-B376-8A45490B3552@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:36470 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735Ab3GAMfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 08:35:54 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so4875098oag.12
        for <linux-omap@vger.kernel.org>; Mon, 01 Jul 2013 05:35:54 -0700 (PDT)
In-Reply-To: <655D996E-9836-4919-B376-8A45490B3552@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Mon, Jul 1, 2013 at 1:01 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> On 01/07/2013, at 10:04, Linus Walleij <linus.walleij@linaro.org> wrote:

>> Let's see if we can cram it in as part of a late v3.11 merge or
>> if we'll have to defer to v3.12.
>
> Ok no worries. Since these patches fixes an actual issue
> (using a GPIO as IRQ) I guess they still can be sent as
> part of the v3.11 -rc cycle gpio fixes.

Yes of course, we'll fix that up.

Yours,
Linus Walleij
