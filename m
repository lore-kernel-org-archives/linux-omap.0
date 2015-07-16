From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: prevent module from being unloaded while in use
Date: Thu, 16 Jul 2015 14:27:17 +0200
Message-ID: <CACRpkdbfPab9rv8Pz0gO5P69jbSQe-_ReCou=U4RHZyX--9SuQ@mail.gmail.com>
References: <1435245213-17858-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435245213-17858-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 25, 2015 at 5:13 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> OMAP GPIO driver allowed to be built as loadable module, but it
> doesn't set owner field in GPIO chip structure. As result,
> module_get/put() API is not working and it's possible to unload
> OMAP driver while in use:
>
>   omap_gpio 48051000.gpio: REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED
>
> Hence, add missing configuration.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Fixes: cac089f9026e ('gpio: omap: Allow building as a loadable module')
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> Hi Linus,
>
> Seems this one is for 4.2-rc.

Yup applied for fixes with Alex' ACK.

The bigger fix is applied for devel and the best way to handle this
is open for discussion.

Yours,
Linus Walleij
