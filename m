From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/5] GPIO OMAP driver changes for v3.16
Date: Thu, 10 Apr 2014 19:29:26 +0200
Message-ID: <CACRpkdarYt4tAD9WMDu6Me+dhipVyDHMpgF-AQ8SDNKMmhSjsA@mail.gmail.com>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Apr 6, 2014 at 4:58 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> Now that you have sent your changes for v3.15 to Torvalds, here are some
> changes for the OMAP GPIO driver targeted to v3.16. Mostly improvements
> so nothing here is -rc material.

I like this series so I have applied them for v3.16, pending some ACK
from Kevin &| Santosh.

> The biggest change is Patch 4 that converts the driver to use the newly
> introduced generic irqchip helpers in the gpiolib core which allows to
> remove some driver specific logic that should really be generic.

Excellent, I will take a closer look at this, it seems there is some
cruft still in but let me look.

Yours,
Linus Walleij
