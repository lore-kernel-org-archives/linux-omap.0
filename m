From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC/RFT/PATCH V3] gpio: omap: refresh patch "be more aggressive
 with pm_runtime" against v3.12-rc5
Date: Thu, 12 Dec 2013 19:19:35 +0100
Message-ID: <CACRpkdaD13JnGetD-GLpxSoaf_LkRKYFjis7Tftc6U38E1ES5A@mail.gmail.com>
References: <1385506004-14943-1-git-send-email-caesarxuchao@gmail.com>
	<1386477638-6331-1-git-send-email-caesarxuchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:56693 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab3LLSTg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 13:19:36 -0500
Received: by mail-ob0-f180.google.com with SMTP id wo20so805830obc.25
        for <linux-omap@vger.kernel.org>; Thu, 12 Dec 2013 10:19:35 -0800 (PST)
In-Reply-To: <1386477638-6331-1-git-send-email-caesarxuchao@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chao Xu <caesarxuchao@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>

On Sun, Dec 8, 2013 at 5:40 AM, Chao Xu <caesarxuchao@gmail.com> wrote:

> From: Felipe Balbi <balbi@ti.com>
>
> try to keep gpio block suspended as much as possible.
>
> Tested with pandaboard and a sysfs exported gpio.
>
> Signed-off-by: Felipe Balbi <balbi at ti.com>
>
> [caesarxuchao@gmail.com : Refreshed against v3.12-rc5, and added
> revision check to enable aggressive pm_runtime on OMAP4-only. Because
> am33xx_gpio_sysc.idlemodes seems to be wrongly marked as
> SIDLE_SMART_WKUP, which might cause missed interrupts with this patch.
> Tested on Pandaboard rev A2.]
> Signed-off-by: Chao Xu <caesarxuchao@gmail.com>
> ---
> changes since v2:
> *add wrapper function to avoid 'is_aggressive_pm' check everywhere, as
> suggested by Santosh Shilimkar
> *fix format issue in commit log

I'm dropping this until you convince Kevin/Tony that this is
the way to go.

One thing caught my eye, you add:

> +static void _aggressive_pm_runtime_get_sync(struct gpio_bank *bank)
> +static void _aggressive_pm_runtime_put(struct gpio_bank *bank)
(..)

Then everywhere:

> +       _aggressive_pm_runtime_get_sync(bank);
(...)
> +       _aggressive_pm_runtime_put(bank);

Aggressive, argh, runtime PM is agressive by definition. If you
want to switch this on and off use the compile option
to enable/disable runtime PM altogether and do not wrap it
like this.

Yours,
Linus Walleij
