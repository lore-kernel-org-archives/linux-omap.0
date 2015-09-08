From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: Fix GPIO numbering for deferred probe
Date: Tue, 8 Sep 2015 16:14:30 +0200
Message-ID: <CACRpkdZFyt5KvfYu2GwdmMJmQtG1MiNXVkqHLRD=nZauK2ww3A@mail.gmail.com>
References: <1441301487-6238-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1441301487-6238-1-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 3, 2015 at 7:31 PM, Tony Lindgren <tony@atomide.com> wrote:

> If gpio-omap probe fails with -EPROBE_DEFER, the GPIO numbering
> keeps increasing. Only increase the gpio count if gpiochip_add()
> was successful as otherwise the numbers will increase for each
> probe attempt.
>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied with Grygorii's review tag.

Yours,
Linus Walleij
