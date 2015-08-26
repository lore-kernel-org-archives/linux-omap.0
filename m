From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/7] gpio: omap: switch to use platform_get_irq
Date: Wed, 26 Aug 2015 09:47:43 +0200
Message-ID: <CACRpkdaZhba2mJT5DB4NDJhsmyxyJ+TUo_z7iAHFxQWqDCf1=g@mail.gmail.com>
References: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
	<1439896258-26449-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1439896258-26449-3-git-send-email-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 18, 2015 at 1:10 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Switch OMAP GPIO driver to use platform_get_irq(), because
> it is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ, ..)
> for requesting IRQ resources any more, as they can be not ready yet
> in case of DT-boot.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Sane handling of deffred probe.

Patch applied.

Yours,
Linus Walleij
