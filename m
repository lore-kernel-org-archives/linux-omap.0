From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 1 Jul 2013 15:23:36 +0200
Message-ID: <CACRpkda0CeLxGBt24XEHeLjmnOfn9iCBw6-r9FQDDkX9JChF5w@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<CACRpkdZryWYZuOLx5E2njLNRd1SLj4VgtEyEETh88+3SS5ckyQ@mail.gmail.com>
	<CAAwP0s2jtVEoqMVE7ru-tcXMX8ZKZObnDz0UDWiS4QkbJODOHA@mail.gmail.com>
	<CACRpkdaQ+zvrYF6o65Emkf2yiMR4YOfutBv-LTDc0xOmnkZkBg@mail.gmail.com>
	<CACxGe6sf4SEMuiYAPpUq=zE1ENu8cwPkz6G_9X8j5TjrmVDEhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:35568 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab3GANXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 09:23:36 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so4820280oag.6
        for <linux-omap@vger.kernel.org>; Mon, 01 Jul 2013 06:23:36 -0700 (PDT)
In-Reply-To: <CACxGe6sf4SEMuiYAPpUq=zE1ENu8cwPkz6G_9X8j5TjrmVDEhw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Mon, Jul 1, 2013 at 2:49 PM, Grant Likely <grant.likely@linaro.org> wrote:

> Linus, you can actually merge in the final v3.10 tag into your
> gpio-next branch and then apply on top of that. I would send it as two
> separate pull requests though. One pull with all the stuff that was in
> linux-next, and a second that includes the v3.10 merge and the OMAP
> patches.

The first is already done :-D

I'll queue the OMAP stuff on a branch based off v3.10 sharp and
put into -next right now so we can propose it for fixes or as a
second pull request during the merge window.

Yours,
Linus Walleij
