From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] usb: phy: phy-generic: Fix reset behaviour on legacy boot
Date: Thu, 13 Aug 2015 22:48:10 -0300
Message-ID: <CAOMZO5BZnY6X+PYQxB9zzq8e6__t8uiTRF+89orkJ891j6s=og@mail.gmail.com>
References: <1439461722-9498-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439461722-9498-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Fabio Estevam <fabio.estevam@freescale.com>, USB list <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 13, 2015 at 7:28 AM, Roger Quadros <rogerq@ti.com> wrote:
> The gpio-desc migration done in v4.0 caused a regression
> with legacy boots due to reversed reset logic.
> e.g. omap3-beagle USB host breaks on legacy boot.
>
> Request the reset GPIO with GPIOF_ACTIVE_LOW flag so that
> it matches the driver logic and pin behaviour.
>
> Fixes: e9f2cefb0cdc ("usb: phy: generic: migrate to gpio_desc")
> Cc: <stable@vger.kernel.org> # 4.0+
> Signed-off-by: Roger Quadros <rogerq@ti.com>

The USB on my mx51-babbage board still works fine with this change:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
