From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/5] arm: omap: switch over to gpio_set_debounce
Date: Wed, 16 Jun 2010 20:26:30 +0300
Message-ID: <AANLkTikeS8VtXbO5iOgvDMxy7QIxrbfzS4Hob_BsHylj@mail.gmail.com>
References: <1274090554-19420-1-git-send-email-felipe.balbi@nokia.com>
	<1274090554-19420-4-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48898 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932482Ab0FPR0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 13:26:31 -0400
Received: by gye5 with SMTP id 5so4147134gye.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 10:26:30 -0700 (PDT)
In-Reply-To: <1274090554-19420-4-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Mon, May 17, 2010 at 1:02 PM,  <felipe.balbi@nokia.com> wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
>
> stop using the omap-specific implementations for gpio
> debouncing now that gpiolib provides its own support.

hmm, this gives me:
[    0.000000] WARNING: at drivers/gpio/gpiolib.c:104
gpio_ensure_requested+0x50/0xcc()
[    0.000000] autorequest GPIO-96
[    0.000000] Modules linked in:
[    0.000000] [<c00302bc>] (unwind_backtrace+0x0/0xec) from
[<c00510dc>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c00510dc>] (warn_slowpath_common+0x4c/0x64) from
[<c0051174>] (warn_slowpath_fmt+0x2c/0x3)
[    0.000000] [<c0051174>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c0166c2c>] (gpio_ensure_requested+0x50/0x)
[    0.000000] [<c0166c2c>] (gpio_ensure_requested+0x50/0xcc) from
[<c0166d14>] (gpio_set_debounce+0x6c/0x)
[    0.000000] [<c0166d14>] (gpio_set_debounce+0x6c/0xb0) from
[<c000ee84>] (omap3pandora_init+0x94/0xcc)
[    0.000000] [<c000ee84>] (omap3pandora_init+0x94/0xcc) from
[<c000b300>] (customize_machine+0x18/0x24)

..and later gpio-keys is unable to request the same GPIO because of
above autorequest.

So how is this supposed to be used here, should I request all GPIOs I
want to have debouncing on, setup debounce time and release them for
gpio-keys to take? Or should I wait for this to get supported in
gpio-keys?
