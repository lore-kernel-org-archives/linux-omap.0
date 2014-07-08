From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] gpio: omap: Add an omap prefix to all functions
Date: Tue, 8 Jul 2014 09:57:01 +0200
Message-ID: <CACRpkdbQLm4sf51TM+qyjUcCpifipDTqnygqTHVmdahMgp8AMw@mail.gmail.com>
References: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
	<1403900258-20717-4-git-send-email-jmartinez@softcrates.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1403900258-20717-4-git-send-email-jmartinez@softcrates.net>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Javier Martinez Canillas <jmartinez@softcrates.net>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 27, 2014 at 10:17 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:

> The GPIO OMAP driver didn't have a consistent naming scheme for
> all its functions. Some of them had an omap prefix while others
> didn't. There are many advantages on having a separate namespace
> for driver functions so let's add an "omap" prefix to all of them.
>
> Signed-off-by: Javier Martinez Canillas <jmartinez@softcrates.net>

Yeah that was very disturbing, patch applied, thanks!

Yours,
Linus Walleij
