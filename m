From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/5] gpio: omap: add a GPIO_OMAP option instead of using
 ARCH_OMAP
Date: Thu, 10 Apr 2014 13:37:15 -0400
Message-ID: <5346D6CB.6070003@ti.com>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk> <1396796297-13002-4-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1396796297-13002-4-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Linus Walleij <linus.walleij@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sunday 06 April 2014 10:58 AM, Javier Martinez Canillas wrote:
> The ARCH_OMAP config option was used to built the GPIO OMAP
> driver but this is not consistent with the rest of the GPIO
> drivers that have their own Kconfig option.
> 
> Also, this make it harder to add dependencies or reverse
> dependencies (i.e: select) since that would mean touching the
> sub-arch config option.
> 
> So is better to add a boolean Kconfig option for this driver
> that defaults to true if ARCH_OMAP is enabled.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


